//
//  Disassembler.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 21/8/18.
//  Copyright © 2018 LomoCorp. All rights reserved.
//

import Foundation

// id opcode table
let table_NONE = 0
let table_XX = 1
let table_CB = 2
let table_XXCB = 3
let table_ED = 4

class Disassembler {
    typealias OpcodeTable = [() -> Void]
    
    let clock = Clock()
    var opcode_tables : [OpcodeTable]!
    var id_opcode_table : Int
    let data : Bus16
    var pc: UInt16 = 0x0000
    var xx_reg = "ix"
    
    var current_instruction = Instruction()
    
    init(dataBus: Bus16) {
        self.data = dataBus
        
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
    func next() -> Instruction {
        self.current_instruction.clearBytes()
        self.current_instruction.clearParams()
        
        self.current_instruction.address = pc

        repeat {
            self.processInstruction()
        } while id_opcode_table != table_NONE
        
        return current_instruction
    }
    
    func processInstruction() {
        self.current_instruction.addOpcodeByte(byte: dataRead(pc))
        pc = pc &+ 1
        
        self.clock.add(tCycles: 1)
        
        self.opcode_tables[id_opcode_table][Int(current_instruction.opcode)]()
    }
    
    func dataRead(_ pc: UInt16) -> UInt8 {
        self.clock.add(tCycles: 3)
        
        return data.read(pc)
    }
}
