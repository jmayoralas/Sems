//
//  cu_opcodes_none.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 15/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

// t_cycle = 4 ((Op)4)
extension Z80 {
    func initOpcodeTableNONE(_ opcodes: inout OpcodeTable) {
        opcodes[0x00] = { // NOP
        }
        opcodes[0x01] = { // LD BC,&0000
            self.clock.tCycles += 6
            self.regs.c = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            self.regs.b = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x02] = { // LD (BC),A
            self.clock.tCycles += 3
            self.dataBus.write(self.regs.bc, value: self.regs.a)
        }
        opcodes[0x03] = { // INC BC
            self.clock.tCycles += 2
            self.regs.bc = self.regs.bc &+ 1
        }
        opcodes[0x04] = { // INC B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .add, ignoreCarry: true)
        }
        opcodes[0x05] = { // DEC B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .sub, ignoreCarry: true)
        }
        opcodes[0x06] = { // LD B,N
            self.clock.tCycles += 3
            self.regs.b = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x07] = { // RLCA
            let PV_backup = self.regs.f.bit(PV)
            let S_backup = self.regs.f.bit(S)
            let Z_backup = self.regs.f.bit(Z)
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .rlc, ignoreCarry: false)
            self.regs.f.bit(PV, newVal: PV_backup)
            self.regs.f.bit(S, newVal: S_backup)
            self.regs.f.bit(Z, newVal: Z_backup)
        }
        opcodes[0x08] = { // EX AF,AF'
            let af_ = self.regs.af_
            self.regs.af_ = self.regs.af
            self.regs.af = af_
        }
        opcodes[0x09] = { // ADD HL,BC
            self.clock.tCycles += 7
            self.regs.hl = self.aluCall16(self.regs.hl, self.regs.bc, ulaOp: .add)
        }
        opcodes[0x0A] = { // LD A,(BC)
            self.clock.tCycles += 3
            self.regs.a = self.dataBus.read(self.regs.bc)
        }
        opcodes[0x0B] = { // DEC BC
            self.clock.tCycles += 2
            self.regs.bc = self.regs.bc &- 1
        }
        opcodes[0x0C] = { // INC C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .add, ignoreCarry: true)
        }
        opcodes[0x0D] = { // DEC C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .sub, ignoreCarry: true)
        }
        opcodes[0x0E] = { // LD C,N
            self.clock.tCycles += 3
            self.regs.c = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x0F] = { // RRCA
            let PV_backup = self.regs.f.bit(PV)
            let S_backup = self.regs.f.bit(S)
            let Z_backup = self.regs.f.bit(Z)
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .rrc, ignoreCarry: false)
            self.regs.f.bit(PV, newVal: PV_backup)
            self.regs.f.bit(S, newVal: S_backup)
            self.regs.f.bit(Z, newVal: Z_backup)
        }
        opcodes[0x10] = { // DJNZ N
            self.clock.tCycles += 4
            let displ = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            self.regs.b = self.regs.b &- 1
            if self.regs.b != 0 {
                self.clock.tCycles += 5
                self.regs.pc = self.addRelative(displacement: displ, toAddress: self.regs.pc)
            }
        }
        opcodes[0x11] = { // LD DE,&0000
            self.clock.tCycles += 6
            self.regs.e = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            self.regs.d = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x12] = { // LD (DE),A
            self.clock.tCycles += 3
            self.dataBus.write(self.regs.de, value: self.regs.a)
        }
        opcodes[0x13] = { // INC DE
            self.clock.tCycles += 2
            self.regs.de = self.regs.de &+ 1
        }
        opcodes[0x14] = { // INC D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .add, ignoreCarry: true)
        }
        opcodes[0x15] = { // DEC D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .sub, ignoreCarry: true)
        }
        opcodes[0x16] = { // LD D,&00
            self.clock.tCycles += 3
            self.regs.d = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x17] = { // RLA
            let PV_backup = self.regs.f.bit(PV)
            let S_backup = self.regs.f.bit(S)
            let Z_backup = self.regs.f.bit(Z)
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .rl, ignoreCarry: false)
            self.regs.f.bit(PV, newVal: PV_backup)
            self.regs.f.bit(S, newVal: S_backup)
            self.regs.f.bit(Z, newVal: Z_backup)
        }
        opcodes[0x18] = { // JR &00
            self.clock.tCycles += 8
            let displ = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            self.regs.pc = self.addRelative(displacement: displ, toAddress: self.regs.pc)
        }
        opcodes[0x19] = { // ADD HL,DE
            self.clock.tCycles += 7
            self.regs.hl = self.aluCall16(self.regs.hl, self.regs.de, ulaOp: .add)
        }
        opcodes[0x1A] = { // LD A,(DE)
            self.clock.tCycles += 3
            self.regs.a = self.dataBus.read(self.regs.de)
        }
        opcodes[0x1B] = { // DEC DE
            self.clock.tCycles += 2
            self.regs.de = self.regs.de &- 1
        }
        opcodes[0x1C] = { // INC E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .add, ignoreCarry: true)
        }
        opcodes[0x1D] = { // DEC E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .sub, ignoreCarry: true)
        }
        opcodes[0x1E] = { // LD E,&00
            self.clock.tCycles += 3
            self.regs.e = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x1F] = { // RRA
            let PV_backup = self.regs.f.bit(PV)
            let Z_backup = self.regs.f.bit(Z)
            let S_backup = self.regs.f.bit(S)
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .rr, ignoreCarry: false)
            self.regs.f.bit(PV, newVal: PV_backup)
            self.regs.f.bit(Z, newVal: Z_backup)
            self.regs.f.bit(S, newVal: S_backup)
        }
        opcodes[0x20] = { // JR NZ &00
            self.clock.tCycles += 3
            let displ = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            if self.regs.f.bit(Z) == 0 {
                self.clock.tCycles += 5
                self.regs.pc = self.addRelative(displacement: displ, toAddress: self.regs.pc)
            }
        }
        opcodes[0x21] = { // LD HL,&0000
            self.clock.tCycles += 6
            self.regs.l = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            self.regs.h = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x22] = { // LD (&0000),HL
            self.clock.tCycles += 12
            let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            self.regs.pc = self.regs.pc &+ 2
            self.dataBus.write(address, value: self.regs.l)
            self.dataBus.write(address &+ 1, value: self.regs.h)
        }
        opcodes[0x23] = { // INC HL
            self.clock.tCycles += 2
            self.regs.hl = self.regs.hl &+ 1
        }
        opcodes[0x24] = { // INC H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .add, ignoreCarry: true)
        }
        opcodes[0x25] = { // DEC H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .sub, ignoreCarry: true)
        }
        opcodes[0x26] = { // LD H,&00
            self.clock.tCycles += 3
            self.regs.h = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x27] = { // DAA
            /*
            The exact process is the following:
            - if the least significant four bits of A contain a non-BCD digit (i. e. it is greater than 9) or the H flag is set, then $06 is added to the register
            - then the four most significant bits are checked. If this more significant digit also happens to be greater than 9 or the C flag is set, then $60 is added.
            - if the second addition was needed, the C flag is set after execution, otherwise it is reset.
            - the N flag is preserved
            - P/V is parity
            - the others flags are altered by definition.
            */
            let a = self.regs.a
            var add: UInt8 = 0
            var carry = self.regs.f.bit(C)
            
            if a.low > 9 || self.regs.f.bit(H) == 1 {
                add = 0x06
            }
            
            if a > 0x99 || self.regs.f.bit(C) == 1 {
                add |= 0x60
                carry = 1
            }
            
            if self.regs.f.bit(N) == 1 {
                self.regs.a = self.aluCall(self.regs.a, add, ulaOp: .sub, ignoreCarry: true)
            } else {
                self.regs.a = self.aluCall(self.regs.a, add, ulaOp: .add, ignoreCarry: true)
            }
            
            self.regs.f.bit(C, newVal: carry)
            if self.regs.a.parity == 0 {
                self.regs.f.setBit(PV) // even parity
            } else {
                self.regs.f.resetBit(PV) // odd parity
            }
        }
        opcodes[0x28] = { // JR Z &00
            self.clock.tCycles += 3
            let displ = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            if self.regs.f.bit(Z) == 1 {
                self.clock.tCycles += 5
                self.regs.pc = self.addRelative(displacement: displ, toAddress: self.regs.pc)
            }
        }
        opcodes[0x29] = { // ADD HL,HL
            self.clock.tCycles += 7
            self.regs.hl = self.aluCall16(self.regs.hl, self.regs.hl, ulaOp: .add)
        }
        opcodes[0x2A] = { // LD HL,(&0000)
            self.clock.tCycles += 12
            let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            self.regs.pc = self.regs.pc &+ 2
            self.regs.l = self.dataBus.read(address)
            self.regs.h = self.dataBus.read(address &+ 1)
        }
        opcodes[0x2B] = { // DEC HL
            self.clock.tCycles += 2
            self.regs.hl = self.regs.hl &- 1
        }
        opcodes[0x2C] = { // INC L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .add, ignoreCarry: true)
        }
        opcodes[0x2D] = { // DEC L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .sub, ignoreCarry: true)
        }
        opcodes[0x2E] = { // LD L,&00
            self.clock.tCycles += 3
            self.regs.l = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x2F] = { // CPL
            self.regs.a = ~self.regs.a
            self.regs.f.setBit(H)
            self.regs.f.setBit(N)
            self.regs.f.bit(3, newVal: self.regs.a.bit(3))
            self.regs.f.bit(5, newVal: self.regs.a.bit(5))
        }
        opcodes[0x30] = { // JR NC &00
            self.clock.tCycles += 3
            let displ = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            if self.regs.f.bit(C) == 0 {
                self.clock.tCycles += 5
                self.regs.pc = self.addRelative(displacement: displ, toAddress: self.regs.pc)
            }
        }
        opcodes[0x31] = { // LD SP,&0000
            self.clock.tCycles += 6
            self.regs.sp = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            self.regs.pc = self.regs.pc &+ 2
        }
        opcodes[0x32] = { // LD (&0000),A
            self.clock.tCycles += 9
            self.dataBus.write(self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc)), value: self.regs.a)
            self.regs.pc = self.regs.pc &+ 2
        }
        opcodes[0x33] = { // INC SP
            self.clock.tCycles += 2
            self.regs.sp = self.regs.sp &+ 1
        }
        opcodes[0x34] = { // INC (HL)
            self.clock.tCycles += 7
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .add, ignoreCarry: true)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x35] = { // DEC (HL)
            self.clock.tCycles += 7
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .sub, ignoreCarry: true)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x36] = { // LD (HL),&00
            self.clock.tCycles += 6
            self.dataBus.write(self.regs.hl, value: self.dataBus.read(self.regs.pc))
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x37] = { // SCF
            let result = self.regs.q == 1 ? self.regs.a : self.regs.a | self.regs.f
            
            self.regs.f.setBit(C)
            self.regs.f.resetBit(H)
            self.regs.f.resetBit(N)
            
            self.regs.f.bit(3, newVal: result.bit(3))
            self.regs.f.bit(5, newVal: result.bit(5))
            
            self.regs.q = 1
        }
        opcodes[0x38] = { // JR C &00
            self.clock.tCycles += 3
            let displ = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            if self.regs.f.bit(C) == 1 {
                self.clock.tCycles += 5
                self.regs.pc = self.addRelative(displacement: displ, toAddress: self.regs.pc)
            }
        }
        opcodes[0x39] = { // ADD HL,SP
            self.clock.tCycles += 7
            self.regs.hl = self.aluCall16(self.regs.hl, self.regs.sp, ulaOp: .add)
        }
        opcodes[0x3A] = { // LD A,(&0000)
            self.clock.tCycles += 9
            self.regs.a = self.dataBus.read(self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc)))
            self.regs.pc = self.regs.pc &+ 2
        }
        opcodes[0x3B] = { // DEC SP
            self.clock.tCycles += 2
            self.regs.sp = self.regs.sp &- 1
        }
        opcodes[0x3C] = { // INC A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .add, ignoreCarry: true)
        }
        opcodes[0x3D] = { // DEC A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .sub, ignoreCarry: true)
        }
        opcodes[0x3E] = { // LD A,&00
            self.clock.tCycles += 3
            self.regs.a = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x3F] = { // CCF
            let result = self.regs.q == 1 ? self.regs.a : self.regs.a | self.regs.f
            
            self.regs.f.bit(H, newVal: self.regs.f.bit(C))
            if self.regs.f.bit(C) == 0 {
                self.regs.f.setBit(C)
            } else {
                self.regs.f.resetBit(C)
            }
            self.regs.f.resetBit(N)
            
            self.regs.f.bit(3, newVal: result.bit(3))
            self.regs.f.bit(5, newVal: result.bit(5))
            
            self.regs.q = 1
        }
        opcodes[0x40] = { // LD B,B
            self.regs.b = self.regs.b
        }
        opcodes[0x41] = { // LD B,C
            self.regs.b = self.regs.c
        }
        opcodes[0x42] = { // LD B,D
            self.regs.b = self.regs.d
        }
        opcodes[0x43] = { // LD B,E
            self.regs.b = self.regs.e
        }
        opcodes[0x44] = { // LD B,H
            self.regs.b = self.regs.h
        }
        opcodes[0x45] = { // LD B,L
            self.regs.b = self.regs.l
        }
        opcodes[0x46] = { // LD B,(HL)
            self.clock.tCycles += 3
            self.regs.b = self.dataBus.read(self.regs.hl)
        }
        opcodes[0x47] = { // LD B,A
            self.regs.b = self.regs.a
        }
        opcodes[0x48] = { // LD C,B
            self.regs.c = self.regs.b
        }
        opcodes[0x49] = { // LD C,C
            self.regs.c = self.regs.c
        }
        opcodes[0x4A] = { // LD C,D
            self.regs.c = self.regs.d
        }
        opcodes[0x4B] = { // LD C,E
            self.regs.c = self.regs.e
        }
        opcodes[0x4C] = { // LD C,H
            self.regs.c = self.regs.h
        }
        opcodes[0x4D] = { // LD C,L
            self.regs.c = self.regs.l
        }
        opcodes[0x4E] = { // LD C,(HL)
            self.clock.tCycles += 3
            self.regs.c = self.dataBus.read(self.regs.hl)
        }
        opcodes[0x4F] = { // LD C,A
            self.regs.c = self.regs.a
        }
        opcodes[0x50] = { // LD D,B
            self.regs.d = self.regs.b
        }
        opcodes[0x51] = { // LD D,C
            self.regs.d = self.regs.c
        }
        opcodes[0x52] = { // LD D,D
            self.regs.d = self.regs.d
        }
        opcodes[0x53] = { // LD D,E
            self.regs.d = self.regs.e
        }
        opcodes[0x54] = { // LD D,H
            self.regs.d = self.regs.h
        }
        opcodes[0x55] = { // LD D,L
            self.regs.d = self.regs.l
        }
        opcodes[0x56] = { // LD D,(HL)
            self.clock.tCycles += 3
            self.regs.d = self.dataBus.read(self.regs.hl)
        }
        opcodes[0x57] = { // LD D,A
            self.regs.d = self.regs.a
        }
        opcodes[0x58] = { // LD E,B
            self.regs.e = self.regs.b
        }
        opcodes[0x59] = { // LD E,C
            self.regs.e = self.regs.c
        }
        opcodes[0x5A] = { // LD E,D
            self.regs.e = self.regs.d
        }
        opcodes[0x5B] = { // LD E,E
            self.regs.e = self.regs.e
        }
        opcodes[0x5C] = { // LD E,H
            self.regs.e = self.regs.h
        }
        opcodes[0x5D] = { // LD E,L
            self.regs.e = self.regs.l
        }
        opcodes[0x5E] = { // LD E,(HL)
            self.clock.tCycles += 3
            self.regs.e = self.dataBus.read(self.regs.hl)
        }
        opcodes[0x5F] = { // LD E,A
            self.regs.e = self.regs.a
        }
        opcodes[0x60] = { // LD H,B
            self.regs.h = self.regs.b
        }
        opcodes[0x61] = { // LD H,C
            self.regs.h = self.regs.c
        }
        opcodes[0x62] = { // LD H,D
            self.regs.h = self.regs.d
        }
        opcodes[0x63] = { // LD H,E
            self.regs.h = self.regs.e
        }
        opcodes[0x64] = { // LD H,H
            self.regs.h = self.regs.h
        }
        opcodes[0x65] = { // LD H,L
            self.regs.h = self.regs.l
        }
        opcodes[0x66] = { // LD H,(HL)
            self.clock.tCycles += 3
            self.regs.h = self.dataBus.read(self.regs.hl)
        }
        opcodes[0x67] = { // LD H,A
            self.regs.h = self.regs.a
        }
        opcodes[0x68] = { // LD L,B
            self.regs.l = self.regs.b
        }
        opcodes[0x69] = { // LD L,C
            self.regs.l = self.regs.c
        }
        opcodes[0x6A] = { // LD L,D
            self.regs.l = self.regs.d
        }
        opcodes[0x6B] = { // LD L,E
            self.regs.l = self.regs.e
        }
        opcodes[0x6C] = { // LD L,H
            self.regs.l = self.regs.h
        }
        opcodes[0x6D] = { // LD L,L
            self.regs.l = self.regs.l
        }
        opcodes[0x6E] = { // LD L,(HL)
            self.clock.tCycles += 3
            self.regs.l = self.dataBus.read(self.regs.hl)
        }
        opcodes[0x6F] = { // LD L,A
            self.regs.l = self.regs.a
        }
        opcodes[0x70] = { // LD (HL),B
            self.clock.tCycles += 3
            self.dataBus.write(self.regs.hl, value: self.regs.b)
        }
        opcodes[0x71] = { // LD (HL),C
            self.clock.tCycles += 3
            self.dataBus.write(self.regs.hl, value: self.regs.c)
        }
        opcodes[0x72] = { // LD (HL),D
            self.clock.tCycles += 3
            self.dataBus.write(self.regs.hl, value: self.regs.d)
        }
        opcodes[0x73] = { // LD (HL),E
            self.clock.tCycles += 3
            self.dataBus.write(self.regs.hl, value: self.regs.e)
        }
        opcodes[0x74] = { // LD (HL),H
            self.clock.tCycles += 3
            self.dataBus.write(self.regs.hl, value: self.regs.h)
        }
        opcodes[0x75] = { // LD (HL),L
            self.clock.tCycles += 3
            self.dataBus.write(self.regs.hl, value: self.regs.l)
        }
        opcodes[0x76] = { // HALT
            self.halted = true
            self.regs.pc = self.regs.pc &- 1
        }
        opcodes[0x77] = { // LD (HL),A
            self.clock.tCycles += 3
            self.dataBus.write(self.regs.hl, value: self.regs.a)
        }
        opcodes[0x78] = { // LD A,B
            self.regs.a = self.regs.b
        }
        opcodes[0x79] = { // LD A,C
            self.regs.a = self.regs.c
        }
        opcodes[0x7A] = { // LD A,D
            self.regs.a = self.regs.d
        }
        opcodes[0x7B] = { // LD A,E
            self.regs.a = self.regs.e
        }
        opcodes[0x7C] = { // LD A,H
            self.regs.a = self.regs.h
        }
        opcodes[0x7D] = { // LD A,L
            self.regs.a = self.regs.l
        }
        opcodes[0x7E] = { // LD A,(HL)
            self.clock.tCycles += 3
            self.regs.a = self.dataBus.read(self.regs.hl)
        }
        opcodes[0x7F] = { // LD A,A
            self.regs.a = self.regs.a
        }
        opcodes[0x80] = { // ADD A,B
            self.regs.a = self.aluCall(self.regs.a, self.regs.b, ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x81] = { // ADD A,C
            self.regs.a = self.aluCall(self.regs.a, self.regs.c, ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x82] = { // ADD A,D
            self.regs.a = self.aluCall(self.regs.a, self.regs.d, ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x83] = { // ADD A,E
            self.regs.a = self.aluCall(self.regs.a, self.regs.e, ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x84] = { // ADD A,H
            self.regs.a = self.aluCall(self.regs.a, self.regs.h, ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x85] = { // ADD A,L
            self.regs.a = self.aluCall(self.regs.a, self.regs.l, ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x86] = { // ADD A,(HL)
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.hl), ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x87] = { // ADD A,A
            self.regs.a = self.aluCall(self.regs.a, self.regs.a, ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x88] = { // ADC A,B
            self.regs.a = self.aluCall(self.regs.a, self.regs.b, ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x89] = { // ADC A,C
            self.regs.a = self.aluCall(self.regs.a, self.regs.c, ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x8A] = { // ADC A,D
            self.regs.a = self.aluCall(self.regs.a, self.regs.d, ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x8B] = { // ADC A,E
            self.regs.a = self.aluCall(self.regs.a, self.regs.e, ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x8C] = { // ADC A,H
            self.regs.a = self.aluCall(self.regs.a, self.regs.h, ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x8D] = { // ADC A,L
            self.regs.a = self.aluCall(self.regs.a, self.regs.l, ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x8E] = { // ADC A,(HL)
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.hl), ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x8F] = { // ADC A,A
            self.regs.a = self.aluCall(self.regs.a, self.regs.a, ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x90] = { // SUB A,B
            self.regs.a = self.aluCall(self.regs.a, self.regs.b, ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x91] = { // SUB A,C
            self.regs.a = self.aluCall(self.regs.a, self.regs.c, ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x92] = { // SUB A,D
            self.regs.a = self.aluCall(self.regs.a, self.regs.d, ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x93] = { // SUB A,E
            self.regs.a = self.aluCall(self.regs.a, self.regs.e, ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x94] = { // SUB A,H
            self.regs.a = self.aluCall(self.regs.a, self.regs.h, ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x95] = { // SUB A,L
            self.regs.a = self.aluCall(self.regs.a, self.regs.l, ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x96] = { // SUB A,(HL)
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.hl), ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x97] = { // SBC A,A
            self.regs.a = self.aluCall(self.regs.a, self.regs.a, ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x98] = { // SBC A,B
            self.regs.a = self.aluCall(self.regs.a, self.regs.b, ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0x99] = { // SBC A,C
            self.regs.a = self.aluCall(self.regs.a, self.regs.c, ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0x9A] = { // SBC A,D
            self.regs.a = self.aluCall(self.regs.a, self.regs.d, ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0x9B] = { // SBC A,E
            self.regs.a = self.aluCall(self.regs.a, self.regs.e, ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0x9C] = { // SBC A,H
            self.regs.a = self.aluCall(self.regs.a, self.regs.h, ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0x9D] = { // SBC A,L
            self.regs.a = self.aluCall(self.regs.a, self.regs.l, ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0x9E] = { // SBC A,(HL)
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.hl), ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0x9F] = { // SBC A,A
            self.regs.a = self.aluCall(self.regs.a, self.regs.a, ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0xA0] = { // AND B
            self.regs.a = self.aluCall(self.regs.a, self.regs.b, ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA1] = { // AND C
            self.regs.a = self.aluCall(self.regs.a, self.regs.c, ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA2] = { // AND D
            self.regs.a = self.aluCall(self.regs.a, self.regs.d, ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA3] = { // AND E
            self.regs.a = self.aluCall(self.regs.a, self.regs.e, ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA4] = { // AND H
            self.regs.a = self.aluCall(self.regs.a, self.regs.h, ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA5] = { // AND L
            self.regs.a = self.aluCall(self.regs.a, self.regs.l, ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA6] = { // AND (HL)
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.hl), ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA7] = { // AND A
            self.regs.a = self.aluCall(self.regs.a, self.regs.a, ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA8] = { // XOR B
            self.regs.a = self.aluCall(self.regs.a, self.regs.b, ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xA9] = { // XOR C
            self.regs.a = self.aluCall(self.regs.a, self.regs.c, ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xAA] = { // XOR D
            self.regs.a = self.aluCall(self.regs.a, self.regs.d, ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xAB] = { // XOR E
            self.regs.a = self.aluCall(self.regs.a, self.regs.e, ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xAC] = { // XOR H
            self.regs.a = self.aluCall(self.regs.a, self.regs.h, ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xAD] = { // XOR L
            self.regs.a = self.aluCall(self.regs.a, self.regs.l, ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xAE] = { // XOR (HL)
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.hl), ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xAF] = { // XOR A
            self.regs.a = self.aluCall(self.regs.a, self.regs.a, ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xB0] = { // OR B
            self.regs.a = self.aluCall(self.regs.a, self.regs.b, ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB1] = { // OR C
            self.regs.a = self.aluCall(self.regs.a, self.regs.c, ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB2] = { // OR D
            self.regs.a = self.aluCall(self.regs.a, self.regs.d, ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB3] = { // OR E
            self.regs.a = self.aluCall(self.regs.a, self.regs.e, ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB4] = { // OR H
            self.regs.a = self.aluCall(self.regs.a, self.regs.h, ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB5] = { // OR L
            self.regs.a = self.aluCall(self.regs.a, self.regs.l, ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB6] = { // OR (HL)
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.hl), ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB7] = { // OR A
            self.regs.a = self.aluCall(self.regs.a, self.regs.a, ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB8] = { // CP B
            let _ = self.aluCall(self.regs.a, self.regs.b, ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xB9] = { // CP C
            let _ = self.aluCall(self.regs.a, self.regs.c, ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xBA] = { // CP D
            let _ = self.aluCall(self.regs.a, self.regs.d, ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xBB] = { // CP E
            let _ = self.aluCall(self.regs.a, self.regs.e, ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xBC] = { // CP H
            let _ = self.aluCall(self.regs.a, self.regs.h, ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xBD] = { // CP L
            let _ = self.aluCall(self.regs.a, self.regs.l, ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xBE] = { // CP (HL)
            self.clock.tCycles += 3
            let _ = self.aluCall(self.regs.a, self.dataBus.read(self.regs.hl), ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xBF] = { // CP A
            let _ = self.aluCall(self.regs.a, self.regs.a, ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xC0] = { // RET NZ
            self.clock.tCycles += 1
            if self.regs.f.bit(Z) == 0 {
                self.ret()
            }
        }
        opcodes[0xC1] = { // POP BC
            self.clock.tCycles += 6
            self.regs.c = self.dataBus.read(self.regs.sp)
            self.regs.b = self.dataBus.read(self.regs.sp &+ 1)
            self.regs.sp = self.regs.sp &+ 2
        }
        opcodes[0xC2] = { // JP NZ &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(Z) == 0 {
                self.regs.pc = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xC3] = { // JP &0000
            self.clock.tCycles += 6
            self.regs.pc = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
        }
        opcodes[0xC4] = { // CALL NZ &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(Z) == 0 {
                let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
                self.regs.pc = self.regs.pc &+ 2
                self.call(address)
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xC5] = { // PUSH BC
            self.clock.tCycles += 7
            self.dataBus.write(self.regs.sp &- 1, value: self.regs.b)
            self.dataBus.write(self.regs.sp &- 2 , value: self.regs.c)
            self.regs.sp = self.regs.sp &- 2
        }
        opcodes[0xC6] = { // ADD A,&00
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.pc), ulaOp: .add, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xC7] = { // RST &00
            self.call(0x0000)
        }
        opcodes[0xC8] = { // RET Z
            self.clock.tCycles += 1
            if self.regs.f.bit(Z) == 1 {
                self.ret()
            }
        }
        opcodes[0xC9] = { // RET
            self.ret()
        }
        opcodes[0xCA] = { // JP Z &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(Z) == 1 {
                self.regs.pc = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xCB] = { // PREFIX *** CB ***
            self.id_opcode_table = table_CB
            self.processInstruction()
            self.id_opcode_table = table_NONE
        }
        opcodes[0xCC] = { // CALL Z &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(Z) == 1 {
                let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
                self.regs.pc = self.regs.pc &+ 2
                self.call(address)
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xCD] = { // CALL &0000
            self.clock.tCycles += 6
            let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            self.regs.pc = self.regs.pc &+ 2
            self.call(address)
        }
        opcodes[0xCE] = { // ADC A,&00
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.pc), ulaOp: .adc, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xCF] = { // RST &08
            self.call(0x0008)
        }
        opcodes[0xD0] = { // RET NC
            self.clock.tCycles += 1
            if self.regs.f.bit(C) == 0 {
                self.ret()
            }
        }
        opcodes[0xD1] = { // POP DE
            self.clock.tCycles += 6
            self.regs.e = self.dataBus.read(self.regs.sp)
            self.regs.d = self.dataBus.read(self.regs.sp &+ 1)
            self.regs.sp = self.regs.sp &+ 2
        }
        opcodes[0xD2] = { // JP NC &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(C) == 0 {
                self.regs.pc = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xD3] = { // OUT (&00), A
            self.clock.tCycles += 3
            self.ioBus.write(self.addressFromPair(self.regs.a, self.dataBus.read(self.regs.pc)), value: self.regs.a)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xD4] = { // CALL NC &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(C) == 0 {
                let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
                self.regs.pc = self.regs.pc &+ 2
                self.call(address)
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xD5] = { // PUSH DE
            self.clock.tCycles += 7
            self.dataBus.write(self.regs.sp &- 1 , value: self.regs.d)
            self.dataBus.write(self.regs.sp &- 2 , value: self.regs.e)
            self.regs.sp = self.regs.sp &- 2
        }
        opcodes[0xD6] = { // SUB A,&00
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.pc), ulaOp: .sub, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xD7] = { // RST &10
            self.call(0x0010)
        }
        opcodes[0xD8] = { // RET C
            self.clock.tCycles += 1
            if self.regs.f.bit(C) == 1 {
                self.ret()
            }
        }
        opcodes[0xD9] = { // EXX
            let bc = self.regs.bc
            let de = self.regs.de
            let hl = self.regs.hl
            self.regs.bc = self.regs.bc_
            self.regs.de = self.regs.de_
            self.regs.hl = self.regs.hl_
            self.regs.bc_ = bc
            self.regs.de_ = de
            self.regs.hl_ = hl
            
        }
        opcodes[0xDA] = { // JP C &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(C) == 1 {
                self.regs.pc = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xDB] = { // IN A,(&00)
            self.clock.tCycles += 3
            self.regs.a =  self.ioBus.read(self.addressFromPair(self.regs.a, self.dataBus.read(self.regs.pc)))
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xDC] = { // CALL C &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(C) == 1 {
                let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
                self.regs.pc = self.regs.pc &+ 2
                self.call(address)
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xDD] = { // PREFIX *** DD ***
            self.id_opcode_table = table_XX
            self.regs.xx = self.regs.ix
            self.processInstruction()
            self.regs.ix = self.regs.xx
            self.id_opcode_table = table_NONE
        }
        opcodes[0xDE] = { // SBC A,&00
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.pc), ulaOp: .sbc, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xDF] = { // RST &18
            self.call(0x0018)
        }
        opcodes[0xE0] = { // RET PO
            self.clock.tCycles += 1
            if self.regs.f.bit(PV) == 0 {
                self.ret()
            }
        }
        opcodes[0xE1] = { // POP HL
            self.clock.tCycles += 6
            self.regs.l = self.dataBus.read(self.regs.sp)
            self.regs.h = self.dataBus.read(self.regs.sp &+ 1)
            self.regs.sp = self.regs.sp &+ 2
        }
        opcodes[0xE2] = { // JP PO &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(PV) == 0 {
                self.regs.pc = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xE3] = { // EX (SP), HL
            self.clock.tCycles += 15
            let hl = self.regs.hl
            self.regs.hl = self.addressFromPair(self.dataBus.read(self.regs.sp &+ 1), self.dataBus.read(self.regs.sp))
            self.dataBus.write(self.regs.sp, value: hl.low)
            self.dataBus.write(self.regs.sp &+ 1, value: hl.high)
        }
        opcodes[0xE4] = { // CALL PO &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(PV) == 0 {
                let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
                self.regs.pc = self.regs.pc &+ 2
                self.call(address)
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xE5] = { // PUSH HL
            self.clock.tCycles += 7
            self.dataBus.write(self.regs.sp &- 1, value: self.regs.h)
            self.dataBus.write(self.regs.sp &- 2 , value: self.regs.l)
            self.regs.sp = self.regs.sp &- 2
        }
        opcodes[0xE6] = { // AND &00
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.pc), ulaOp: .and, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xE7] = { // RST &20
            self.call(0x0020)
        }
        opcodes[0xE8] = { // RET PE
            self.clock.tCycles += 1
            if self.regs.f.bit(PV) == 1 {
                self.ret()
            }
        }
        opcodes[0xE9] = { // JP (HL)
            self.regs.pc = self.addressFromPair(self.regs.h, self.regs.l)
        }
        opcodes[0xEA] = { // JP PE &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(PV) == 1 {
                self.regs.pc = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xEB] = { // EX DE, HL
            let d = self.regs.d
            let e = self.regs.e
            self.regs.d = self.regs.h
            self.regs.e = self.regs.l
            self.regs.h = d
            self.regs.l = e
        }
        opcodes[0xEC] = { // CALL PE &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(PV) == 1 {
                let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
                self.regs.pc = self.regs.pc &+ 2
                self.call(address)
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xED] = { // PREFIX *** ED ***
            self.id_opcode_table = table_ED
            self.processInstruction()
            self.id_opcode_table = table_NONE
        }
        opcodes[0xEE] = { // XOR &00
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.pc), ulaOp: .xor, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xEF] = { // RST &28
            self.call(0x0028)
        }
        opcodes[0xF0] = { // RET P
            self.clock.tCycles += 1
            if self.regs.f.bit(S) == 0 {
                self.ret()
            }
        }
        opcodes[0xF1] = { // POP AF
            self.clock.tCycles += 6
            self.regs.f = self.dataBus.read(self.regs.sp)
            self.regs.a = self.dataBus.read(self.regs.sp &+ 1)
            self.regs.sp = self.regs.sp &+ 2
        }
        opcodes[0xF2] = { // JP P &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(S) == 0 {
                self.regs.pc = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xF3] = { // DI
            self.regs.IFF1 = false
            self.regs.IFF2 = false
        }
        opcodes[0xF4] = { // CALL P &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(S) == 0 {
                let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
                self.regs.pc = self.regs.pc &+ 2
                self.call(address)
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xF5] = { // PUSH AF
            self.clock.tCycles += 7
            self.dataBus.write(self.regs.sp &- 1, value: self.regs.a)
            self.dataBus.write(self.regs.sp &- 2 , value: self.regs.f)
            self.regs.sp = self.regs.sp &- 2
        }
        opcodes[0xF6] = { // OR &00
            self.clock.tCycles += 3
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(self.regs.pc), ulaOp: .or, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xF7] = { // RST &30
            self.call(0x0030)
        }
        opcodes[0xF8] = { // RET M
            self.clock.tCycles += 1
            if self.regs.f.bit(S) == 1 {
                self.ret()
            }
        }
        opcodes[0xF9] = { // LD SP, HL
            self.clock.tCycles += 2
            self.regs.sp = self.regs.hl
        }
        opcodes[0xFA] = { // JP M &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(S) == 1 {
                self.regs.pc = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xFB] = { // EI
            self.eiExecuted = true
            self.regs.IFF1 = true
            self.regs.IFF2 = true
        }
        opcodes[0xFC] = { // CALL M &0000
            self.clock.tCycles += 6
            if self.regs.f.bit(S) == 1 {
                let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
                self.regs.pc = self.regs.pc &+ 2
                self.call(address)
            } else {
                self.regs.pc = self.regs.pc &+ 2
            }
        }
        opcodes[0xFD] = { // PREFIX *** FD ***
            self.id_opcode_table = table_XX
            self.regs.xx = self.regs.iy
            self.processInstruction()
            self.regs.iy = self.regs.xx
            self.id_opcode_table = table_NONE
        }
        opcodes[0xFE] = { // CP &00
            self.clock.tCycles += 3
            let _ = self.aluCall(self.regs.a, self.dataBus.read(self.regs.pc), ulaOp: .cp, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xFF] = { // RST &38
            self.call(0x0038)
        }
    }
}
