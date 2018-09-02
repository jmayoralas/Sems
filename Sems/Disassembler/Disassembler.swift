//
//  Disassembler.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 21/8/18.
//  Copyright © 2018 LomoCorp. All rights reserved.
//

import Foundation

class Disassembler {
    typealias OpcodeTable = [() -> Void]
    
    let clock: Clock
    var opcode_tables : [OpcodeTable]!
    var id_opcode_table : Int
    let data : Bus16
    var pc: UInt16
    var xx_reg = "ix"
    
    var current_instruction: Instruction
    
    init(dataBus: Bus16) {
        self.data = dataBus
        self.clock = Clock()
        pc = 0x0000
        
        current_instruction = Instruction(address: pc, opcode: 0x00)
        
        id_opcode_table = table_NONE
        
        opcode_tables = [OpcodeTable](repeating: OpcodeTable(repeating: {
            // by default, every undocumented and unimplemented opcode prefixed by DD or FD, will execute his equivalent in the un-prefixed opcode table
            // and NOP in the rest of cases
            if self.id_opcode_table == table_XX {
                self.opcode_tables[table_NONE][Int(self.current_instruction.opcode)]()
            } else {
                self.current_instruction.caption = "not implemented"
            }
        }, count: 0x100), count: 5)
        
        initOpcodeTableNONE(&opcode_tables[table_NONE])
        initOpcodeTableXX(&opcode_tables[table_XX])
        initOpcodeTableXXCB(&opcode_tables[table_XXCB])
        initOpcodeTableCB(&opcode_tables[table_CB])
        initOpcodeTableED(&opcode_tables[table_ED])
        
        self.clock.reset()
    }
    
    func org(_ pc: UInt16) {
        self.pc = pc
    }
    
    
    // gets next opcode from PC and executes it
    func step() {
        repeat {
            self.processInstruction()
        } while id_opcode_table != table_NONE
        
        NSLog("0x%@: %@ %@", current_instruction.address.hexStr(), current_instruction.dump(), current_instruction.toString())
    }
    
    func processInstruction() {
        self.current_instruction.address = pc
        self.current_instruction.opcode = dataRead(pc)
        self.current_instruction.clearParams()
        pc = pc &+ 1
        
        self.clock.add(tCycles: 1)
        
        self.opcode_tables[id_opcode_table][Int(current_instruction.opcode)]()
    }
    
    public func dataRead(_ pc: UInt16) -> UInt8 {
        self.clock.add(tCycles: 3)
        
        return data.peek(pc)
    }
}
