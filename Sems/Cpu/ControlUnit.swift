//
//  cu.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 6/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

extension Z80 {
    // MARK: Methods
    func isPrefixed() -> Bool {
        return (id_opcode_table != table_NONE) ? true : false
    }
    
    func aluCall16(_ operandA: UInt16, _ operandB: UInt16, ulaOp: UlaOp) -> UInt16 {
        let f_old = regs.f
        
        let result_l = aluCall(operandA.low, operandB.low, ulaOp: ulaOp, ignoreCarry: false)
        
        var ulaOp_high = ulaOp
        
        switch ulaOp {
        case .add: ulaOp_high = .adc
        case .sub: ulaOp_high = .sbc
        default: break
        }
        
        let result_h = aluCall(operandA.high, operandB.high, ulaOp: ulaOp_high, ignoreCarry: false)
        
        if result_h == 0 && result_l == 0 {
            self.regs.f.setBit(Z)
        } else {
            self.regs.f.resetBit(Z)
        }
        
        if ulaOp == .add {
            // bits S, Z and PV are not affected so restore from F backup
            self.regs.f.bit(S, newVal: f_old.bit(S))
            self.regs.f.bit(Z, newVal: f_old.bit(Z))
            self.regs.f.bit(PV, newVal: f_old.bit(PV))
        }
        
        return addressFromPair(result_h, result_l)
    }
    
    func aluCall(_ operandA: UInt8, _ operandB: UInt8, ulaOp: UlaOp, ignoreCarry: Bool) -> UInt8 {
        /*
        Bit      7 6 5 4 3  2  1 0
        ￼￼Position S Z X H X P/V N C
        */

        let originalUlaOp = ulaOp
        let ulaOp = ulaOp != .cp ? ulaOp : .sub
        
        var result: UInt8
        var old_carry: UInt8 = 0
        
        switch ulaOp {
        case .adc:
            old_carry = UInt8(regs.f.bit(C))
            fallthrough
        case .add:
            result = operandA &+ operandB &+ old_carry

            if (UInt8(operandA.low &+ operandB.low &+ old_carry) & 0xF0 > 0) {
                regs.f.setBit(H)
            } else {
                regs.f.resetBit(H)
            }
            
            regs.f.resetBit(N)
            regs.f.bit(PV, newVal: checkOverflow(operandA, operandB, result: result, ulaOp: ulaOp))
            
            if !ignoreCarry {
                if (result < operandA) || (result == operandA && operandB > 0) {
                    regs.f.setBit(C)
                } else {
                    regs.f.resetBit(C)
                } 
            }
            
        case .sbc:
            old_carry = UInt8(regs.f.bit(C))
            fallthrough
        case .sub:
            result = UInt8(operandA &- operandB &- old_carry)
            
            // H (Half Carry)
            if (UInt8(operandA.low &- operandB.low &- old_carry) & 0xF0 > 0) {
                regs.f.setBit(H)
            } else {
                regs.f.resetBit(H)
            }
            
            regs.f.setBit(N) // N (Substract)
            regs.f.bit(PV, newVal: checkOverflow(operandA, operandB, result: result, ulaOp: ulaOp))
            
            if !ignoreCarry {
                if (result > operandA) || (result == operandA && operandB > 0) {
                    regs.f.setBit(C)
                } else {
                    regs.f.resetBit(C)
                }
            }
            
        case .rl:
            old_carry = UInt8(regs.f.bit(C))
            fallthrough
        case .rlc:
            regs.f.bit(C, newVal: operandA.bit(7)) // sign bit is copied to the carry flag
            result = operandA << 1
            if ulaOp == .rl {
                result.bit(0, newVal: Int(old_carry)) // old carry is copied to the bit 0
            } else {
                result.bit(0, newVal: regs.f.bit(C)) // new carry is copied to the bit 0
            }
            
            regs.f.resetBit(H)
            regs.f.resetBit(N)
            regs.f.bit(PV, newVal: checkParity(result))
            
        case .rr:
            old_carry = UInt8(regs.f.bit(C))
            fallthrough
        case .rrc:
            regs.f.bit(C, newVal: operandA.bit(0)) // least significant bit is copied to the carry flag
            result = operandA >> 1
            if ulaOp == .rr {
                result.bit(7, newVal: Int(old_carry)) // old carry is copied to the bit 7
            } else {
                result.bit(7, newVal: regs.f.bit(C)) // new carry is copied to the bit 7
            }
            
            regs.f.resetBit(H)
            regs.f.resetBit(N)
            regs.f.bit(PV, newVal: checkParity(result))
        
        case .sls:
            fallthrough
        case .sla:
            regs.f.bit(C, newVal: operandA.bit(7)) // sign bit is copied to the carry flag
            result = operandA << 1
            if ulaOp == .sls {
                result.bit(0, newVal: 1)
            }
            
            regs.f.resetBit(H)
            regs.f.resetBit(N)
            regs.f.bit(PV, newVal: checkParity(result))
            
        case .sra:
            regs.f.bit(C, newVal: operandA.bit(0)) // bit 0 is copied to the carry flag
            let sign_bit = operandA.bit(7)
            result = operandA >> 1
            result.bit(7, newVal: sign_bit) // sign bit is restored
            
            regs.f.resetBit(H)
            regs.f.resetBit(N)
            regs.f.bit(PV, newVal: checkParity(result))
        
        case .srl:
            regs.f.bit(C, newVal: operandA.bit(0)) // bit 0 is copied to the carry flag
            result = operandA >> 1
            
            regs.f.resetBit(H)
            regs.f.resetBit(N)
            regs.f.bit(PV, newVal: checkParity(result))
            
        case .and:
            fallthrough
        case .or:
            fallthrough
        case .xor:
            switch ulaOp {
            case .and:
                result = operandA & operandB
                regs.f.setBit(H)
            case .or:
                result = operandA | operandB
                regs.f.resetBit(H)
            case .xor:
                result = operandA ^ operandB
                regs.f.resetBit(H)
            default:
                // This is weird. Never shouldn't happen
                result = operandA
                break
            }
            
            regs.f.bit(PV, newVal: checkParity(result))
            regs.f.resetBit(N)
            regs.f.resetBit(C)
            
        case .bit:
            result = operandA
            
            regs.f.resetBit(S)
            
            if result.bit(Int(operandB)) == 0 {
                regs.f.setBit(Z)
                regs.f.setBit(PV)
            } else {
                regs.f.resetBit(Z)
                regs.f.resetBit(PV)
                
                if operandB == 7 {
                    regs.f.setBit(S)
                }
            }
            regs.f.setBit(H)
            regs.f.resetBit(N)
            
        default:
            result = operandA
        }
        
        var testValueUndocumentedFlags = result
        
        if originalUlaOp != .bit {
            regs.f.bit(S, newVal: result.bit(7))
            if result == 0 {regs.f.setBit(Z)} else {regs.f.resetBit(Z)} // Z (Zero)
            
            if originalUlaOp == .cp {
                testValueUndocumentedFlags = operandB
            }
        } else {
            if self.id_opcode_table == table_XXCB {
                testValueUndocumentedFlags = self.dataBus.lastAddress.high
            }
        }
        
        self.regs.f.bit(3, newVal: testValueUndocumentedFlags.bit(3))
        self.regs.f.bit(5, newVal: testValueUndocumentedFlags.bit(5))
        
        return result
    }
    
    func checkOverflow(_ opA: UInt8, _ opB: UInt8, result: UInt8, ulaOp: UlaOp) -> Int {
        // will return true if an overflow has occurred, false if no overflow
        switch ulaOp {
        case .add:
            fallthrough
        case .adc:
            if (opA.bit(7) == opB.bit(7)) && (result.bit(7) != opA.bit(7)) {
                // same sign in both operands and different sign in result
                return 1
            }
        case .sub:
            fallthrough
        case .sbc:
            if (opA.bit(7) != opB.bit(7)) && (result.bit(7) == opB.bit(7)) {
                // different sign in both operands and same sign in result
                return 1
            }
            
        default:
            break
        }
        
        return 0
    }
    
    func checkParity(_ data: UInt8) -> Int {
        return (data.parity == 0) ? 1 : 0 // 1 -> Even parity, 0 -> Odd parity
    }

    func call(_ address: UInt16) {
        clock.add(tCycles: 1)
        var sp = regs.sp &- 1
        dataBus.write(sp, value: regs.pc.high)
        sp = regs.sp &- 2
        dataBus.write(sp, value: regs.pc.low)
        regs.sp = regs.sp &- 2
        regs.pc = address
    }

    func ret() {
        regs.pc = addressFromPair(dataBus.read(regs.sp &+ 1), dataBus.read(regs.sp))
        regs.sp = regs.sp &+ 2
    }
    
    func nonMaskableInterrupt() -> Bool {
        guard self.nmi else {
            return false
        }
        
        // Acknowledge an interrupt
        if self.halted {
            self.regs.pc = self.regs.pc &+ 1
            self.halted = false
        }
        
        clock.add(tCycles: 8)
        
        self.call(0x0066)
        
        self.regs.IFF2 = self.regs.IFF1
        self.regs.IFF1 = false
        
        self.nmi = false
        
        return true
    }
    
    func maskableInterrupt() -> Bool {
        guard self.int && self.regs.IFF1 && !self.eiExecuted else {
            return false
        }
        
        // Acknowledge an interrupt
        if self.halted {
            self.regs.pc = self.regs.pc &+ 1
            self.halted = false
        }
        
        clock.add(tCycles: 6)
        
        switch regs.int_mode {
        case 0:
            // read next instruction from dataBus
            self.opcode_tables[self.id_opcode_table][Int(self.dataBus.read())]()
        case 1:
            // do a RST 38
            self.opcode_tables[self.id_opcode_table][0xFF]()
        case 2:
            let vector_address = addressFromPair(regs.i, dataBus.last_data & 0xFE) // reset bit 0 of the byte in dataBus to make sure we get an even address
            let routine_address = addressFromPair(dataBus.read(vector_address + 1), dataBus.read(vector_address))
            
            self.call(routine_address)
        default:
            break
        }
        
        regs.IFF1 = false
        regs.IFF2 = false
        
        return true
    }
    
    func addRelative(displacement: UInt8, toAddress address: UInt16) -> UInt16 {
        var newAddress: UInt16 = 0
        
        if displacement.comp2 < 0 {
            newAddress = address &- UInt16(-displacement.comp2)
        } else {
            newAddress = address &+ UInt16(displacement.comp2)
        }
        
        return newAddress
    }
}
