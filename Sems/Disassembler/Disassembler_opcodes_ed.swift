//
//  ControlUnit_opcodes_ed.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 23/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

// t_cycle = 8 ((ED)4, (Op)4)
extension Disassembler {
    func initOpcodeTableED(_ opcodes: inout OpcodeTable) {
        opcodes[0x40] = { // IN B,(C)
            self.current_instruction.caption = "in b,(c)"
        }
        opcodes[0x41] = { // OUT (C),B
            self.current_instruction.caption = "out (c),b"
        }
        opcodes[0x42] = { // SBC HL,BC
            self.current_instruction.caption = "sbc hl,bc"
        }
        opcodes[0x43] = { // LD (&0000),BC
            self.current_instruction.caption = "ld (%@),bc"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x44] = { // NEG
            self.current_instruction.caption = "neg"
        }
        opcodes[0x45] = { // RETN
            self.current_instruction.caption = "retn"
        }
        opcodes[0x46] = { // IM 0
            self.current_instruction.caption = "im 0"
        }
        opcodes[0x47] = { // LD I,A
            self.current_instruction.caption = "ld i,a"
        }
        opcodes[0x48] = { // IN C,(C)
            self.current_instruction.caption = "in c,(c)"
        }
        opcodes[0x49] = { // OUT (C),C
            self.current_instruction.caption = "out (c),c"
        }
        opcodes[0x4A] = { // ADC HL,BC
            self.current_instruction.caption = "adc hl,bc"
        }
        opcodes[0x4B] = { // LD BC,(&0000)
            self.current_instruction.caption = "ld bc,(%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x4C] = { // NEG
            self.opcode_tables[self.id_opcode_table][0x44]()
        }
        opcodes[0x4D] = { // RETI
            self.current_instruction.caption = "reti"
        }
        opcodes[0x4E] = { // IM 0
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x4F] = { // LD R,A
            self.current_instruction.caption = "ld r,a"
        }
        opcodes[0x50] = { // IN D,(C)
            self.current_instruction.caption = "in d,(c)"
        }
        opcodes[0x51] = { // OUT (C),D
            self.current_instruction.caption = "out (c),d"
        }
        opcodes[0x52] = { // SBC HL,DE
            self.current_instruction.caption = "sbc hl,de"
        }
        opcodes[0x53] = { // LD (&0000),DE
            self.current_instruction.caption = "ld (%@),de"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x54] = { // NEG
            self.opcode_tables[self.id_opcode_table][0x44]()
        }
        opcodes[0x55] = { // RETN
            self.opcode_tables[self.id_opcode_table][0x45]()
        }
        opcodes[0x56] = { // IM 1
            self.current_instruction.caption = "im 1"
        }
        opcodes[0x57] = { // LD A,I
            self.current_instruction.caption = "ld a,i"
        }
        opcodes[0x58] = { // IN E,(C)
            self.current_instruction.caption = "in e,(c)"
        }
        opcodes[0x59] = { // OUT (C),E
            self.current_instruction.caption = "out (c),e"
        }
        opcodes[0x5A] = { // ADC HL,DE
            self.current_instruction.caption = "adc hl,de"
        }
        opcodes[0x5B] = { // LD DE,(&0000)
            self.current_instruction.caption = "ld de,(%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x5C] = { // NEG
            self.opcode_tables[self.id_opcode_table][0x44]()
        }
        opcodes[0x5D] = { // RETI
            self.opcode_tables[self.id_opcode_table][0x4D]()
        }
        opcodes[0x5E] = { // IM 2
            self.current_instruction.caption = "im 2"
        }
        opcodes[0x5F] = { // LD A,R
            self.current_instruction.caption = "ld a,r"
        }
        opcodes[0x60] = { // IN H,(C)
            self.current_instruction.caption = "in h,(c)"
        }
        opcodes[0x61] = { // OUT (C),H
            self.current_instruction.caption = "out (c),h"
        }
        opcodes[0x62] = { // SBC HL,HL
            self.current_instruction.caption = "sbc hl,hl"
        }
        opcodes[0x63] = { // LD (&0000),HL
            self.current_instruction.caption = "ld (%@),hl"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x64] = { // NEG
            self.opcode_tables[self.id_opcode_table][0x44]()
        }
        opcodes[0x65] = { // RETN
            self.opcode_tables[self.id_opcode_table][0x45]()
        }
        opcodes[0x66] = { // IM 0
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x67] = { // RRD
            self.current_instruction.caption = "rrd"
        }
        opcodes[0x68] = { // IN L,(C)
            self.current_instruction.caption = "in l,(c)"
        }
        opcodes[0x69] = { // OUT (C),L
            self.current_instruction.caption = "out (c),l"
        }
        opcodes[0x6A] = { // ADC HL,HL
            self.current_instruction.caption = "adc hl,hl"
        }
        opcodes[0x6B] = { // LD HL,(&0000)
            self.current_instruction.caption = "ld hl,(%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x6C] = { // NEG
            self.opcode_tables[self.id_opcode_table][0x44]()
        }
        opcodes[0x6D] = { // RETI
            self.opcode_tables[self.id_opcode_table][0x4D]()
        }
        opcodes[0x6E] = { // IM 0
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x6F] = { // RLD
            self.current_instruction.caption = "rld"
        }
        opcodes[0x70] = { // IN _,(C)
            self.current_instruction.caption = "in (c)"
        }
        opcodes[0x71] = { // OUT (C),_
            self.current_instruction.caption = "out (c)"
        }
        opcodes[0x72] = { // SBC HL,SP
            self.current_instruction.caption = "sbc hl,sp"
        }
        opcodes[0x73] = { // LD (&0000),SP
            self.current_instruction.caption = "ld (%@),sp"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x74] = { // NEG
            self.opcode_tables[self.id_opcode_table][0x44]()
        }
        opcodes[0x75] = { // RETN
            self.opcode_tables[self.id_opcode_table][0x45]()
        }
        opcodes[0x76] = { // IM 1
            self.opcode_tables[self.id_opcode_table][0x56]()
        }
        opcodes[0x77] = { // NOP
            self.current_instruction.caption = "nop"
        }
        opcodes[0x78] = { // IN A,(C)
            self.current_instruction.caption = "in a,(c)"
        }
        opcodes[0x79] = { // OUT (C),A
            self.current_instruction.caption = "out (c),a"
        }
        opcodes[0x7A] = { // ADC HL,SP
            self.current_instruction.caption = "adc hl,sp"
        }
        opcodes[0x7B] = { // LD SP,(&0000)
            self.current_instruction.caption = "ld sp,(%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x7C] = { // NEG
            self.opcode_tables[self.id_opcode_table][0x44]()
        }
        opcodes[0x7D] = { // RETI
            self.opcode_tables[self.id_opcode_table][0x4D]()
        }
        opcodes[0x7E] = { // IM 2
            self.opcode_tables[self.id_opcode_table][0x5E]()
        }
        opcodes[0x7F] = { // RLD
            self.current_instruction.caption = "rld"
        }
        opcodes[0xA0] = { // LDI
            self.current_instruction.caption = "ldi"
        }
        opcodes[0xA1] = { // CPI
            self.current_instruction.caption = "cpi"
        }
        opcodes[0xA2] = { // INI
            self.current_instruction.caption = "ini"
        }
        opcodes[0xA3] = { // OUTI
            self.current_instruction.caption = "outi"
        }
        opcodes[0xA8] = { // LDD
            self.current_instruction.caption = "ldd"
        }
        opcodes[0xA9] = { // CPD
            self.current_instruction.caption = "cpd"
        }
        opcodes[0xAA] = { // IND
            self.current_instruction.caption = "ind"
        }
        opcodes[0xAB] = { // OUTD
            self.current_instruction.caption = "outd"
        }
        opcodes[0xB0] = { // LDIR
            self.current_instruction.caption = "ldir"
        }
        opcodes[0xB1] = { // CPIR
            self.current_instruction.caption = "cpir"
        }
        opcodes[0xB2] = { // INIR
            self.current_instruction.caption = "inir"
        }
        opcodes[0xB3] = { // OTIR
            self.current_instruction.caption = "otir"
        }
        opcodes[0xB8] = { // LDDR
            self.current_instruction.caption = "lddr"
        }
        opcodes[0xB9] = { // CPDR
            self.current_instruction.caption = "cpdr"
        }
        opcodes[0xBA] = { // INDR
            self.current_instruction.caption = "indr"
        }
        opcodes[0xBB] = { // OTDR
            self.current_instruction.caption = "otdr"
        }
    }
}
