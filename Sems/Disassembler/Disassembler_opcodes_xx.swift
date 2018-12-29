//
//  cu_opcodes_dd.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 15/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

// t_cycle = 8 ((DD)4, (Op)4)
extension Disassembler {
    func initOpcodeTableXX(_ opcodes: inout OpcodeTable) {
        opcodes[0x09] = { // ADD xx,BC
            self.current_instruction.caption = String(format: "add %@,bc", self.xx_reg)
        }
        opcodes[0x19] = { // ADD xx,DE
            self.current_instruction.caption = String(format: "add %@,de", self.xx_reg)
        }
        opcodes[0x21] = { // LD xx,&0000
            self.current_instruction.caption = "ld " + self.xx_reg + ",%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x22] = { // LD (&0000),xx
            self.current_instruction.caption = "ld (%@)," + self.xx_reg
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x23] = { // INC xx
            self.current_instruction.caption = "inc " + self.xx_reg
        }
        opcodes[0x24] = { // INC xxH
            self.current_instruction.caption = "inc " + self.xx_reg + "h"
        }
        opcodes[0x25] = { // DEC xxH
            self.current_instruction.caption = "dec " + self.xx_reg + "h"
        }
        opcodes[0x26] = { // LD xxH,&00
            self.current_instruction.caption = "ld " + self.xx_reg + "h,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x29] = { // ADD xx,xx
            self.current_instruction.caption = "add " + self.xx_reg + "," + self.xx_reg
        }
        opcodes[0x2A] = { // LD xx,(&0000)
            self.current_instruction.caption = "ld " + self.xx_reg + ",(%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x2B] = { // DEC xx
            self.current_instruction.caption = "dec " + self.xx_reg
        }
        opcodes[0x2C] = { // INC xxL
            self.current_instruction.caption = "inc " + self.xx_reg + "l"
        }
        opcodes[0x2D] = { // DEC xxL
            self.current_instruction.caption = "dec " + self.xx_reg + "l"
        }
        opcodes[0x2E] = { // LD xxL,&00
            self.current_instruction.caption = "ld " + self.xx_reg + "l,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x34] = { // INC (xx+0)
            self.current_instruction.caption = "inc (" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x35] = { // DEC (xx+0)
            self.current_instruction.caption = "dec (" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x36] = { // LD (xx+0),&00
            self.current_instruction.caption = "ld (" + self.xx_reg + "+%@),%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc &+= 2
        }
        opcodes[0x39] = { // ADD xx,SP
            self.current_instruction.caption = "add " + self.xx_reg + ",sp"
        }
        opcodes[0x44] = { // LD B,xxH
            self.current_instruction.caption = "ld b," + self.xx_reg + "h"
        }
        opcodes[0x45] = { // LD B,xxL
            self.current_instruction.caption = "ld b," + self.xx_reg + "l"
        }
        opcodes[0x46] = { // LD B,(xx+0)
            self.current_instruction.caption = "ld b,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x4C] = { // LD C,xxH
            self.current_instruction.caption = "ld c," + self.xx_reg + "h"
        }
        opcodes[0x4D] = { // LD C,xxL
            self.current_instruction.caption = "ld c," + self.xx_reg + "l"
        }
        opcodes[0x4E] = { // LD C,(xx+0)
            self.current_instruction.caption = "ld c,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x54] = { // LD D,xxH
            self.current_instruction.caption = "ld d," + self.xx_reg + "h"
        }
        opcodes[0x55] = { // LD D,xxL
            self.current_instruction.caption = "ld d," + self.xx_reg + "l"
        }
        opcodes[0x56] = { // LD D,(xx+0)
            self.current_instruction.caption = "ld d,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x5C] = { // LD E,xxH
            self.current_instruction.caption = "ld e," + self.xx_reg + "h"
        }
        opcodes[0x5D] = { // LD E,xxL
            self.current_instruction.caption = "ld e," + self.xx_reg + "l"
        }
        opcodes[0x5E] = { // LD E,(xx+0)
            self.current_instruction.caption = "ld e,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x60] = { // LD xxH,B
            self.current_instruction.caption = "ld " + self.xx_reg + "h,b"
        }
        opcodes[0x61] = { // LD xxH,C
            self.current_instruction.caption = "ld " + self.xx_reg + "h,c"
        }
        opcodes[0x62] = { // LD xxH,D
            self.current_instruction.caption = "ld " + self.xx_reg + "h,d"
        }
        opcodes[0x63] = { // LD xxH,E
            self.current_instruction.caption = "ld " + self.xx_reg + "h,e"
        }
        opcodes[0x64] = { // LD xxH,xxH
            self.current_instruction.caption = "ld " + self.xx_reg + "h," + self.xx_reg + "h"
        }
        opcodes[0x65] = { // LD xxH,xxL
            self.current_instruction.caption = "ld " + self.xx_reg + "h," + self.xx_reg + "l"
        }
        opcodes[0x66] = { // LD H,(xx+0)
            self.current_instruction.caption = "ld h,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x67] = { // LD xxH,A
            self.current_instruction.caption = "ld " + self.xx_reg + "h,a"
        }
        opcodes[0x68] = { // LD xxL,B
            self.current_instruction.caption = "ld " + self.xx_reg + "l,b"
        }
        opcodes[0x69] = { // LD xxL,C
            self.current_instruction.caption = "ld " + self.xx_reg + "l,c"
        }
        opcodes[0x6A] = { // LD xxL,D
            self.current_instruction.caption = "ld " + self.xx_reg + "l,d"
        }
        opcodes[0x6B] = { // LD xxL,E
            self.current_instruction.caption = "ld " + self.xx_reg + "l,e"
        }
        opcodes[0x6C] = { // LD xxL,xxH
            self.current_instruction.caption = "ld " + self.xx_reg + "l," + self.xx_reg + "h"
        }
        opcodes[0x6D] = { // LD xxL,xxL
            self.current_instruction.caption = "ld " + self.xx_reg + "l," + self.xx_reg + "l"
        }
        opcodes[0x6E] = { // LD L,(xx+0)
            self.current_instruction.caption = "ld l,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x6F] = { // LD xxL,A
            self.current_instruction.caption = "ld " + self.xx_reg + "l,a"
        }
        opcodes[0x70] = { // LD (xx+0),B
            self.current_instruction.caption = "ld (" + self.xx_reg + "+%@),b"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x71] = { // LD (xx+0),C
            self.current_instruction.caption = "ld (" + self.xx_reg + "+%@),c"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x72] = { // LD (xx+0),D
            self.current_instruction.caption = "ld (" + self.xx_reg + "+%@),d"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x73] = { // LD (xx+0),E
            self.current_instruction.caption = "ld (" + self.xx_reg + "+%@),e"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x74] = { // LD (xx+0),H
            self.current_instruction.caption = "ld (" + self.xx_reg + "+%@),h"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x75] = { // LD (xx+0),L
            self.current_instruction.caption = "ld (" + self.xx_reg + "+%@),l"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x77] = { // LD (xx+0),A
            self.current_instruction.caption = "ld (" + self.xx_reg + "+%@),a"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x7C] = { // LD A,xxH
            self.current_instruction.caption = "ld a," + self.xx_reg + "h"
        }
        opcodes[0x7D] = { // LD A,xxL
            self.current_instruction.caption = "ld a," + self.xx_reg + "l"
        }
        opcodes[0x7E] = { // LD A,(xx+0)
            self.current_instruction.caption = "ld a,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x84] = { // ADD A,xxH
            self.current_instruction.caption = "add a," + self.xx_reg + "h"
        }
        opcodes[0x85] = { // ADD A,xxL
            self.current_instruction.caption = "add a," + self.xx_reg + "l"
        }
        opcodes[0x86] = { // ADD A,(xx+0)
            self.current_instruction.caption = "add a,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x8C] = { // ADC A,xxH
            self.current_instruction.caption = "adc a," + self.xx_reg + "h"
        }
        opcodes[0x8D] = { // ADC A,xxL
            self.current_instruction.caption = "adc a," + self.xx_reg + "l"
        }
        opcodes[0x8E] = { // ADC A,(xx+0)
            self.current_instruction.caption = "adc a,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x94] = { // SUB A,xxH
            self.current_instruction.caption = "sub a," + self.xx_reg + "h"
        }
        opcodes[0x95] = { // SUB A,xxL
            self.current_instruction.caption = "sub a," + self.xx_reg + "l"
        }
        opcodes[0x96] = { // SUB A,(xx+0)
            self.current_instruction.caption = "sub a,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0x9C] = { // SBC A,xxH
            self.current_instruction.caption = "sbc a," + self.xx_reg + "h"
        }
        opcodes[0x9D] = { // SBC A,xxL
            self.current_instruction.caption = "sbc a," + self.xx_reg + "l"
        }
        opcodes[0x9E] = { // SBC A,(xx+0)
            self.current_instruction.caption = "sbc a,(" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0xA4] = { // AND xxH
            self.current_instruction.caption = "and " + self.xx_reg + "h"
        }
        opcodes[0xA5] = { // AND xxL
            self.current_instruction.caption = "and " + self.xx_reg + "l"
        }
        opcodes[0xA6] = { // AND (xx+0)
            self.current_instruction.caption = "and (" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0xAC] = { // XOR xxH
            self.current_instruction.caption = "xor " + self.xx_reg + "h"
        }
        opcodes[0xAD] = { // XOR xxL
            self.current_instruction.caption = "xor " + self.xx_reg + "l"
        }
        opcodes[0xAE] = { // XOR (xx+0)
            self.current_instruction.caption = "xor (" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0xB4] = { // OR xxH
            self.current_instruction.caption = "or " + self.xx_reg + "h"
        }
        opcodes[0xB5] = { // OR xxL
            self.current_instruction.caption = "or " + self.xx_reg + "l"
        }
        opcodes[0xB6] = { // OR (xx+0)
            self.current_instruction.caption = "or (" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0xBC] = { // CP xxH
            self.current_instruction.caption = "cp " + self.xx_reg + "h"
        }
        opcodes[0xBD] = { // CP xxL
            self.current_instruction.caption = "cp " + self.xx_reg + "l"
        }
        opcodes[0xBE] = { // CP (xx+0)
            self.current_instruction.caption = "cp (" + self.xx_reg + "+%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc &+= 1
        }
        opcodes[0xCB] = {
            self.id_opcode_table = table_XXCB
            self.current_instruction.addOpcodeByte(byte: self.dataRead(self.pc))
            self.pc &+= 1
            self.processInstruction()
            self.id_opcode_table = table_NONE
        }
        opcodes[0xE1] = { // POP xx
            self.current_instruction.caption = "pop " + self.xx_reg
        }
        opcodes[0xE3] = { // EX (SP), xx
            self.current_instruction.caption = "ex (sp)," + self.xx_reg
        }
        opcodes[0xE5] = { // PUSH xx
            self.current_instruction.caption = "push " + self.xx_reg
        }
        opcodes[0xE9] = { // JP (xx)
            self.current_instruction.caption = "jp (" + self.xx_reg + ")"
        }
        opcodes[0xF9] = { // LD SP,xx
            self.current_instruction.caption = "ld sp," + self.xx_reg
        }
    }
 }
