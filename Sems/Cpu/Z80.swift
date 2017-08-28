//
//  z80core.swift
//  z80emu
//
//  Created by Jose Luis Fernandez-Mayoralas on 11/9/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

class Z80 {
    typealias OpcodeTable = [() -> Void]
    
    var regs : Registers
    
    let clock: Clock
    
    var halted: Bool = true
    
    var opcode_tables : [OpcodeTable]!
    
    var id_opcode_table : Int
    
    var frameTics: Int = 0;
    
    let dataBus : Bus16
    let ioBus : IoBus
    
    var nmi: Bool = false
    var int: Bool = false
    
    var stopped = true
    
    var eiExecuted: Bool = false
    
    init(dataBus: Bus16, ioBus: IoBus, clock: Clock) {
        self.regs = Registers()
        self.dataBus = dataBus
        self.ioBus = ioBus
        self.clock = clock
        
        id_opcode_table = table_NONE
        
        opcode_tables = [OpcodeTable](repeating: OpcodeTable(repeating: {
            // by default, every undocumented and unimplemented opcode prefixed by DD or FD, will execute his equivalent in the un-prefixed opcode table
            // and NOP in the rest of cases
            if self.id_opcode_table == table_XX {
                self.opcode_tables[table_NONE][Int(self.regs.ir)]()
            }
        }, count: 0x100), count: 5)
        
        initOpcodeTableNONE(&opcode_tables[table_NONE])
        initOpcodeTableXX(&opcode_tables[table_XX])
        initOpcodeTableXXCB(&opcode_tables[table_XXCB])
        initOpcodeTableCB(&opcode_tables[table_CB])
        initOpcodeTableED(&opcode_tables[table_ED])
        
        reset()
    }
    
    func reset() {
        regs.pc = 0x0000
        
        regs.int_mode = 0
        
        regs.IFF1 = false
        regs.IFF2 = false
        
        regs.i = 0x00
        regs.r = 0x00
        
        regs.sp = 0xFFFF
        
        regs.af = 0xFFFF
        regs.bc = 0xFFFF
        regs.de = 0xFFFF
        regs.hl = 0xFFFF
        regs.ix = 0xFFFF
        regs.iy = 0xFFFF
        
        regs.af_ = 0xFFFF
        regs.bc_ = 0xFFFF
        regs.de_ = 0xFFFF
        regs.hl_ = 0xFFFF
        
        self.clock.tCycles = 0
        
        halted = false
    }
    
    func org(_ pc: UInt16) {
        regs.pc = pc
    }
    
    func getRegs() -> Registers {
        return regs
    }
    
    func addressFromPair(_ val_h: UInt8, _ val_l: UInt8) -> UInt16 {
        return UInt16(Int(Int(val_h) * 0x100) + Int(val_l))
    }
    
    // gets next opcode from PC and executes it
    func step() {
        // check for non maskable interrupt
        guard !self.nonMaskableInterrupt() else {
            return
        }
        
        // save flags register before execute the opcode
        let fBackup = self.regs.f
        
        if !self.maskableInterrupt() {
            self.eiExecuted = false
            
            repeat {
                self.processInstruction()
            } while id_opcode_table != table_NONE
        }
        
        // test for flags changes and update q register acordingly
        if id_opcode_table != table_NONE || (id_opcode_table == table_NONE && self.regs.ir != 0x37 && self.regs.ir != 0x3F) {
            self.regs.q = fBackup != self.regs.f ? 1 : 0
        }
    }
    
    func processInstruction() {
        self.getNextOpcode()
        self.opcode_tables[id_opcode_table][Int(regs.ir)]()
    }
    
    func getNextOpcode() {
        self.clock.tCycles += 4
        
        if halted {
            // cpu halted, always execute NOP
            regs.ir = 0x00
        } else {
            // get opcode at PC into IR register
            regs.ir = dataBus.read(regs.pc)
            regs.pc = regs.pc &+ 1
        }
        
        if regs.ir != 0xCB || id_opcode_table == table_NONE {
            // save bit 7 of R to restore after increment
            let bit7 = regs.r.bit(7)
            // increment only seven bits
            regs.r.resetBit(7)
            regs.r = regs.r + 1 <= 0x7F ? regs.r + 1 : 0
            
            // restore bit 7
            regs.r.bit(7, newVal: bit7)
        }
    }
}
