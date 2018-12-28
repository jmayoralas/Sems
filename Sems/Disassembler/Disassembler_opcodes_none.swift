//
//  cu_opcodes_none.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 15/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

// t_cycle = 4 ((Op)4)
extension Disassembler {
    func initOpcodeTableNONE(_ opcodes: inout OpcodeTable) {
        opcodes[0x00] = { // NOP
            self.current_instruction.caption = "nop"
        }
        opcodes[0x01] = { // LD BC,&0000
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.current_instruction.caption = "ld bc,%@"
            
            self.pc = self.pc &+ 2
        }
        opcodes[0x02] = { // LD (BC),A
            self.current_instruction.caption = "ld (bc),a"
        }
        opcodes[0x03] = { // INC BC
            self.current_instruction.caption = "inc bc"
        }
        opcodes[0x04] = { // INC B
            self.current_instruction.caption = "inc b"
        }
        opcodes[0x05] = { // DEC B
            self.current_instruction.caption = "dec b"
        }
        opcodes[0x06] = { // LD B,N
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.caption = "ld b,%@"
            self.pc = self.pc &+ 1
        }
        opcodes[0x07] = { // RLCA
            self.current_instruction.caption = "rlca"
        }
        opcodes[0x08] = { // EX AF,AF'
            self.current_instruction.caption = "ex af,af'"
        }
        opcodes[0x09] = { // ADD HL,BC
            self.current_instruction.caption = "add hl,bc"
        }
        opcodes[0x0A] = { // LD A,(BC)
            self.current_instruction.caption = "ld a,(bc)"
        }
        opcodes[0x0B] = { // DEC BC
            self.current_instruction.caption = "dec bc"
        }
        opcodes[0x0C] = { // INC C
            self.current_instruction.caption = "inc c"
        }
        opcodes[0x0D] = { // DEC C
            self.current_instruction.caption = "dec c"
        }
        opcodes[0x0E] = { // LD C,N
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.caption = "ld c,%@"
            self.pc = self.pc &+ 1
        }
        opcodes[0x0F] = { // RRCA
            self.current_instruction.caption = "rrca"
        }
        opcodes[0x10] = { // DJNZ N
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.caption = "djnz %@"
            self.pc = self.pc &+ 1
        }
        opcodes[0x11] = { // LD DE,&0000
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.current_instruction.caption = "ld de,%@"
            
            self.pc = self.pc &+ 2
        }
        opcodes[0x12] = { // LD (DE),A
            self.current_instruction.caption = "ld (de),a"
        }
        opcodes[0x13] = { // INC DE
            self.current_instruction.caption = "inc de"
        }
        opcodes[0x14] = { // INC D
            self.current_instruction.caption = "inc d"
        }
        opcodes[0x15] = { // DEC D
            self.current_instruction.caption = "dec d"
        }
        opcodes[0x16] = { // LD D,&00
            self.current_instruction.caption = "ld d,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x17] = { // RLA
            self.current_instruction.caption = "rla"
        }
        opcodes[0x18] = { // JR &00
            self.current_instruction.caption = "jr %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x19] = { // ADD HL,DE
            self.current_instruction.caption = "add hl,de"
        }
        opcodes[0x1A] = { // LD A,(DE)
            self.current_instruction.caption = "ld a,(de)"
        }
        opcodes[0x1B] = { // DEC DE
            self.current_instruction.caption = "dec de"
        }
        opcodes[0x1C] = { // INC E
            self.current_instruction.caption = "inc e"
        }
        opcodes[0x1D] = { // DEC E
            self.current_instruction.caption = "dec e"
        }
        opcodes[0x1E] = { // LD E,&00
            self.current_instruction.caption = "ld e,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x1F] = { // RRA
            self.current_instruction.caption = "rra"
        }
        opcodes[0x20] = { // JR NZ &00
            self.current_instruction.caption = "jr nz %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x21] = { // LD HL,&0000
            self.current_instruction.caption = "ld hl,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0x22] = { // LD (&0000),HL
            self.current_instruction.caption = "ld (%@),hl"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0x23] = { // INC HL
            self.current_instruction.caption = "inc hl"
        }
        opcodes[0x24] = { // INC H
            self.current_instruction.caption = "inc h"
        }
        opcodes[0x25] = { // DEC H
            self.current_instruction.caption = "dec h"
        }
        opcodes[0x26] = { // LD H,&00
            self.current_instruction.caption = "ld h,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x27] = { // DAA
            self.current_instruction.caption = "daa"
        }
        opcodes[0x28] = { // JR Z &00
            self.current_instruction.caption = "jr z %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x29] = { // ADD HL,HL
            self.current_instruction.caption = "add hl,hl"
        }
        opcodes[0x2A] = { // LD HL,(&0000)
            self.current_instruction.caption = "ld hl,(%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0x2B] = { // DEC HL
            self.current_instruction.caption = "dec hl"
        }
        opcodes[0x2C] = { // INC L
            self.current_instruction.caption = "inc l"
        }
        opcodes[0x2D] = { // DEC L
            self.current_instruction.caption = "dec l"
        }
        opcodes[0x2E] = { // LD L,&00
            self.current_instruction.caption = "ld l,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x2F] = { // CPL
            self.current_instruction.caption = "cpl"
        }
        opcodes[0x30] = { // JR NC &00
            self.current_instruction.caption = "jr nc %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x31] = { // LD SP,&0000
            self.current_instruction.caption = "ld sp,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0x32] = { // LD (&0000),A
            self.current_instruction.caption = "ld (%@),a"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0x33] = { // INC SP
            self.current_instruction.caption = "inc sp"
        }
        opcodes[0x34] = { // INC (HL)
            self.current_instruction.caption = "inc (hl)"
        }
        opcodes[0x35] = { // DEC (HL)
            self.current_instruction.caption = "dec (hl)"
        }
        opcodes[0x36] = { // LD (HL),&00
            self.current_instruction.caption = "ld (hl),%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x37] = { // SCF
            self.current_instruction.caption = "scf"
        }
        opcodes[0x38] = { // JR C &00
            self.current_instruction.caption = "jr c %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x39] = { // ADD HL,SP
            self.current_instruction.caption = "add hl,sp"
        }
        opcodes[0x3A] = { // LD A,(&0000)
            self.current_instruction.caption = "ld a,(%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0x3B] = { // DEC SP
            self.current_instruction.caption = "dec sp"
        }
        opcodes[0x3C] = { // INC A
            self.current_instruction.caption = "inc a"
        }
        opcodes[0x3D] = { // DEC A
            self.current_instruction.caption = "dec a"
        }
        opcodes[0x3E] = { // LD A,&00
            self.current_instruction.caption = "ld a,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0x3F] = { // CCF
            self.current_instruction.caption = "ccf"
        }
        opcodes[0x40] = { // LD B,B
            self.current_instruction.caption = "ld b,b"
        }
        opcodes[0x41] = { // LD B,C
            self.current_instruction.caption = "ld b,c"
        }
        opcodes[0x42] = { // LD B,D
            self.current_instruction.caption = "ld b,d"
        }
        opcodes[0x43] = { // LD B,E
            self.current_instruction.caption = "ld b,e"
        }
        opcodes[0x44] = { // LD B,H
            self.current_instruction.caption = "ld b,h"
        }
        opcodes[0x45] = { // LD B,L
            self.current_instruction.caption = "ld b,l"
        }
        opcodes[0x46] = { // LD B,(HL)
            self.current_instruction.caption = "ld b,(hl)"
        }
        opcodes[0x47] = { // LD B,A
            self.current_instruction.caption = "ld b,a"
        }
        opcodes[0x48] = { // LD C,B
            self.current_instruction.caption = "ld c,b"
        }
        opcodes[0x49] = { // LD C,C
            self.current_instruction.caption = "ld c,c"
        }
        opcodes[0x4A] = { // LD C,D
            self.current_instruction.caption = "ld c,d"
        }
        opcodes[0x4B] = { // LD C,E
            self.current_instruction.caption = "ld c,e"
        }
        opcodes[0x4C] = { // LD C,H
            self.current_instruction.caption = "ld c,h"
        }
        opcodes[0x4D] = { // LD C,L
            self.current_instruction.caption = "ld c,l"
        }
        opcodes[0x4E] = { // LD C,(HL)
            self.current_instruction.caption = "ld c,(hl)"
        }
        opcodes[0x4F] = { // LD C,A
            self.current_instruction.caption = "ld c,a"
        }
        opcodes[0x50] = { // LD D,B
            self.current_instruction.caption = "ld d,b"
        }
        opcodes[0x51] = { // LD D,C
            self.current_instruction.caption = "ld d,c"
        }
        opcodes[0x52] = { // LD D,D
            self.current_instruction.caption = "ld d,d"
        }
        opcodes[0x53] = { // LD D,E
            self.current_instruction.caption = "ld d,e"
        }
        opcodes[0x54] = { // LD D,H
            self.current_instruction.caption = "ld d,h"
        }
        opcodes[0x55] = { // LD D,L
            self.current_instruction.caption = "ld d,l"
        }
        opcodes[0x56] = { // LD D,(HL)
            self.current_instruction.caption = "ld d,(hl)"
        }
        opcodes[0x57] = { // LD D,A
            self.current_instruction.caption = "ld d,a"
        }
        opcodes[0x58] = { // LD E,B
            self.current_instruction.caption = "ld e,b"
        }
        opcodes[0x59] = { // LD E,C
            self.current_instruction.caption = "ld e,c"
        }
        opcodes[0x5A] = { // LD E,D
            self.current_instruction.caption = "ld e,d"
        }
        opcodes[0x5B] = { // LD E,E
            self.current_instruction.caption = "ld e,e"
        }
        opcodes[0x5C] = { // LD E,H
            self.current_instruction.caption = "ld e,h"
        }
        opcodes[0x5D] = { // LD E,L
            self.current_instruction.caption = "ld e,l"
        }
        opcodes[0x5E] = { // LD E,(HL)
            self.current_instruction.caption = "ld e,(hl)"
        }
        opcodes[0x5F] = { // LD E,A
            self.current_instruction.caption = "ld e,a"
        }
        opcodes[0x60] = { // LD H,B
            self.current_instruction.caption = "ld h,b"
        }
        opcodes[0x61] = { // LD H,C
            self.current_instruction.caption = "ld h,c"
        }
        opcodes[0x62] = { // LD H,D
            self.current_instruction.caption = "ld h,d"
        }
        opcodes[0x63] = { // LD H,E
            self.current_instruction.caption = "ld h,e"
        }
        opcodes[0x64] = { // LD H,H
            self.current_instruction.caption = "ld h,h"
        }
        opcodes[0x65] = { // LD H,L
            self.current_instruction.caption = "ld h,l"
        }
        opcodes[0x66] = { // LD H,(HL)
            self.current_instruction.caption = "ld h,(hl)"
        }
        opcodes[0x67] = { // LD H,A
            self.current_instruction.caption = "ld h,a"
        }
        opcodes[0x68] = { // LD L,B
            self.current_instruction.caption = "ld l,b"
        }
        opcodes[0x69] = { // LD L,C
            self.current_instruction.caption = "ld l,c"
        }
        opcodes[0x6A] = { // LD L,D
            self.current_instruction.caption = "ld l,d"
        }
        opcodes[0x6B] = { // LD L,E
            self.current_instruction.caption = "ld l,e"
        }
        opcodes[0x6C] = { // LD L,H
            self.current_instruction.caption = "ld l,h"
        }
        opcodes[0x6D] = { // LD L,L
            self.current_instruction.caption = "ld l,l"
        }
        opcodes[0x6E] = { // LD L,(HL)
            self.current_instruction.caption = "ld l,(hl)"
        }
        opcodes[0x6F] = { // LD L,A
            self.current_instruction.caption = "ld l,a"
        }
        opcodes[0x70] = { // LD (HL),B
            self.current_instruction.caption = "ld (hl),b"
        }
        opcodes[0x71] = { // LD (HL),C
            self.current_instruction.caption = "ld (hl),c"
        }
        opcodes[0x72] = { // LD (HL),D
            self.current_instruction.caption = "ld (hl),d"
        }
        opcodes[0x73] = { // LD (HL),E
            self.current_instruction.caption = "ld (hl),e"
        }
        opcodes[0x74] = { // LD (HL),H
            self.current_instruction.caption = "ld (hl),h"
        }
        opcodes[0x75] = { // LD (HL),L
            self.current_instruction.caption = "ld (hl),l"
        }
        opcodes[0x76] = { // HALT
            self.current_instruction.caption = "halt"
        }
        opcodes[0x77] = { // LD (HL),A
            self.current_instruction.caption = "ld (hl),a"
        }
        opcodes[0x78] = { // LD A,B
            self.current_instruction.caption = "ld a,b"
        }
        opcodes[0x79] = { // LD A,C
            self.current_instruction.caption = "ld a,c"
        }
        opcodes[0x7A] = { // LD A,D
            self.current_instruction.caption = "ld a,d"
        }
        opcodes[0x7B] = { // LD A,E
            self.current_instruction.caption = "ld a,e"
        }
        opcodes[0x7C] = { // LD A,H
            self.current_instruction.caption = "ld a,h"
        }
        opcodes[0x7D] = { // LD A,L
            self.current_instruction.caption = "ld a,l"
        }
        opcodes[0x7E] = { // LD A,(HL)
            self.current_instruction.caption = "ld a,(hl)"
        }
        opcodes[0x7F] = { // LD A,A
            self.current_instruction.caption = "ld a,a"
        }
        opcodes[0x80] = { // ADD A,B
            self.current_instruction.caption = "add a,b"
        }
        opcodes[0x81] = { // ADD A,C
            self.current_instruction.caption = "add a,c"
        }
        opcodes[0x82] = { // ADD A,D
            self.current_instruction.caption = "add a,d"
        }
        opcodes[0x83] = { // ADD A,E
            self.current_instruction.caption = "add a,e"
        }
        opcodes[0x84] = { // ADD A,H
            self.current_instruction.caption = "add a,h"
        }
        opcodes[0x85] = { // ADD A,L
            self.current_instruction.caption = "add a,l"
        }
        opcodes[0x86] = { // ADD A,(HL)
            self.current_instruction.caption = "add a,(hl)"
        }
        opcodes[0x87] = { // ADD A,A
            self.current_instruction.caption = "add a,a"
        }
        opcodes[0x88] = { // ADC A,B
            self.current_instruction.caption = "adc a,b"
        }
        opcodes[0x89] = { // ADC A,C
            self.current_instruction.caption = "adc a,c"
        }
        opcodes[0x8A] = { // ADC A,D
            self.current_instruction.caption = "adc a,d"
        }
        opcodes[0x8B] = { // ADC A,E
            self.current_instruction.caption = "adc a,e"
        }
        opcodes[0x8C] = { // ADC A,H
            self.current_instruction.caption = "adc a,h"
        }
        opcodes[0x8D] = { // ADC A,L
            self.current_instruction.caption = "adc a,l"
        }
        opcodes[0x8E] = { // ADC A,(HL)
            self.current_instruction.caption = "adc a,(hl)"
        }
        opcodes[0x8F] = { // ADC A,A
            self.current_instruction.caption = "adc a,a"
        }
        opcodes[0x90] = { // SUB A,B
            self.current_instruction.caption = "sub a,b"
        }
        opcodes[0x91] = { // SUB A,C
            self.current_instruction.caption = "sub a,c"
        }
        opcodes[0x92] = { // SUB A,D
            self.current_instruction.caption = "sub a,d"
        }
        opcodes[0x93] = { // SUB A,E
            self.current_instruction.caption = "sub a,e"
        }
        opcodes[0x94] = { // SUB A,H
            self.current_instruction.caption = "sub a,h"
        }
        opcodes[0x95] = { // SUB A,L
            self.current_instruction.caption = "sub a,l"
        }
        opcodes[0x96] = { // SUB A,(HL)
            self.current_instruction.caption = "sub a,(hl)"
        }
        opcodes[0x97] = { // SUB A,A
            self.current_instruction.caption = "sub a,a"
        }
        opcodes[0x98] = { // SBC A,B
            self.current_instruction.caption = "sbc a,b"
        }
        opcodes[0x99] = { // SBC A,C
            self.current_instruction.caption = "sbc a,c"
        }
        opcodes[0x9A] = { // SBC A,D
            self.current_instruction.caption = "sbc a,d"
        }
        opcodes[0x9B] = { // SBC A,E
            self.current_instruction.caption = "sbc a,e"
        }
        opcodes[0x9C] = { // SBC A,H
            self.current_instruction.caption = "sbc a,h"
        }
        opcodes[0x9D] = { // SBC A,L
            self.current_instruction.caption = "sbc a,l"
        }
        opcodes[0x9E] = { // SBC A,(HL)
            self.current_instruction.caption = "sbc a,(hl)"
        }
        opcodes[0x9F] = { // SBC A,A
            self.current_instruction.caption = "sbc a,a"
        }
        opcodes[0xA0] = { // AND B
            self.current_instruction.caption = "and b"
        }
        opcodes[0xA1] = { // AND C
            self.current_instruction.caption = "and c"
        }
        opcodes[0xA2] = { // AND D
            self.current_instruction.caption = "and d"
        }
        opcodes[0xA3] = { // AND E
            self.current_instruction.caption = "and e"
        }
        opcodes[0xA4] = { // AND H
            self.current_instruction.caption = "and h"
        }
        opcodes[0xA5] = { // AND L
            self.current_instruction.caption = "and l"
        }
        opcodes[0xA6] = { // AND (HL)
            self.current_instruction.caption = "and (hl)"
        }
        opcodes[0xA7] = { // AND A
            self.current_instruction.caption = "and a"
        }
        opcodes[0xA8] = { // XOR B
            self.current_instruction.caption = "xor b"
        }
        opcodes[0xA9] = { // XOR C
            self.current_instruction.caption = "xor c"
        }
        opcodes[0xAA] = { // XOR D
            self.current_instruction.caption = "xor d"
        }
        opcodes[0xAB] = { // XOR E
            self.current_instruction.caption = "xor e"
        }
        opcodes[0xAC] = { // XOR H
            self.current_instruction.caption = "xor h"
        }
        opcodes[0xAD] = { // XOR L
            self.current_instruction.caption = "xor l"
        }
        opcodes[0xAE] = { // XOR (HL)
            self.current_instruction.caption = "xor (hl)"
        }
        opcodes[0xAF] = { // XOR A
            self.current_instruction.caption = "xor a"
        }
        opcodes[0xB0] = { // OR B
            self.current_instruction.caption = "or b"
        }
        opcodes[0xB1] = { // OR C
            self.current_instruction.caption = "or c"
        }
        opcodes[0xB2] = { // OR D
            self.current_instruction.caption = "or d"
        }
        opcodes[0xB3] = { // OR E
            self.current_instruction.caption = "or e"
        }
        opcodes[0xB4] = { // OR H
            self.current_instruction.caption = "or h"
        }
        opcodes[0xB5] = { // OR L
            self.current_instruction.caption = "or l"
        }
        opcodes[0xB6] = { // OR (HL)
            self.current_instruction.caption = "or (hl)"
        }
        opcodes[0xB7] = { // OR A
            self.current_instruction.caption = "or a"
        }
        opcodes[0xB8] = { // CP B
            self.current_instruction.caption = "cp b"
        }
        opcodes[0xB9] = { // CP C
            self.current_instruction.caption = "cp c"
        }
        opcodes[0xBA] = { // CP D
            self.current_instruction.caption = "cp d"
        }
        opcodes[0xBB] = { // CP E
            self.current_instruction.caption = "cp e"
        }
        opcodes[0xBC] = { // CP H
            self.current_instruction.caption = "cp h"
        }
        opcodes[0xBD] = { // CP L
            self.current_instruction.caption = "cp l"
        }
        opcodes[0xBE] = { // CP (HL)
            self.current_instruction.caption = "cp (hl)"
        }
        opcodes[0xBF] = { // CP A
            self.current_instruction.caption = "cp a"
        }
        opcodes[0xC0] = { // RET NZ
            self.current_instruction.caption = "ret nz"
        }
        opcodes[0xC1] = { // POP BC
            self.current_instruction.caption = "pop bc"
        }
        opcodes[0xC2] = { // JP NZ &0000
            self.current_instruction.caption = "jp nz %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xC3] = { // JP &0000
            self.current_instruction.caption = "jp %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2

        }
        opcodes[0xC4] = { // CALL NZ &0000
            self.current_instruction.caption = "call nz %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2

        }
        opcodes[0xC5] = { // PUSH BC
            self.current_instruction.caption = "push bc"
        }
        opcodes[0xC6] = { // ADD A,&00
            self.current_instruction.caption = "add a,&@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xC7] = { // RST &00
            self.current_instruction.caption = "rst %@"
            self.current_instruction.addParam(param: 0)
        }
        opcodes[0xC8] = { // RET Z
            self.current_instruction.caption = "ret z"
        }
        opcodes[0xC9] = { // RET
            self.current_instruction.caption = "ret"
        }
        opcodes[0xCA] = { // JP Z &0000
            self.current_instruction.caption = "jp z %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2

        }
        opcodes[0xCB] = { // PREFIX *** CB ***
            self.id_opcode_table = table_CB
            self.processInstruction()
            self.id_opcode_table = table_NONE
        }
        opcodes[0xCC] = { // CALL Z &0000
            self.current_instruction.caption = "call z %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2

        }
        opcodes[0xCD] = { // CALL &0000
            self.current_instruction.caption = "call %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2

        }
        opcodes[0xCE] = { // ADC A,&00
            self.current_instruction.caption = "adc a,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xCF] = { // RST &08
            self.current_instruction.addParam(param: 0x08)
            self.current_instruction.caption = "rst %@"
        }
        opcodes[0xD0] = { // RET NC
            self.current_instruction.caption = "ret nc"
        }
        opcodes[0xD1] = { // POP DE
            self.current_instruction.caption = "pop de"
        }
        opcodes[0xD2] = { // JP NC &0000
            self.current_instruction.caption = "jp nc %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xD3] = { // OUT (&00), A
            self.current_instruction.caption = "out (%@),a"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xD4] = { // CALL NC &0000
            self.current_instruction.caption = "call nc %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xD5] = { // PUSH DE
            self.current_instruction.caption = "push de"
        }
        opcodes[0xD6] = { // SUB A,&00
            self.current_instruction.caption = "sub a,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xD7] = { // RST &10
            self.current_instruction.addParam(param: 0x10)
            self.current_instruction.caption = "rst %@"
        }
        opcodes[0xD8] = { // RET C
            self.current_instruction.caption = "ret c"
        }
        opcodes[0xD9] = { // EXX
            self.current_instruction.caption = "exx"
            
        }
        opcodes[0xDA] = { // JP C &0000
            self.current_instruction.caption = "jp c %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xDB] = { // IN A,(&00)
            self.current_instruction.caption = "in a,(%@)"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xDC] = { // CALL C &0000
            self.current_instruction.caption = "call c %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xDD] = { // PREFIX *** DD ***
            self.id_opcode_table = table_XX
            self.xx_reg = "ix"
            self.processInstruction()
            self.id_opcode_table = table_NONE
        }
        opcodes[0xDE] = { // SBC A,&00
            self.current_instruction.caption = "sbc a,%@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xDF] = { // RST &18
            self.current_instruction.addParam(param: 0x18)
            self.current_instruction.caption = "rst %@"
        }
        opcodes[0xE0] = { // RET PO
            self.current_instruction.caption = "ret po"
        }
        opcodes[0xE1] = { // POP HL
            self.current_instruction.caption = "pop hl"
        }
        opcodes[0xE2] = { // JP PO &0000
            self.current_instruction.caption = "jp po %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xE3] = { // EX (SP), HL
            self.current_instruction.caption = "ex (sp),hl"
        }
        opcodes[0xE4] = { // CALL PO &0000
            self.current_instruction.caption = "call po %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xE5] = { // PUSH HL
            self.current_instruction.caption = "push hl"
        }
        opcodes[0xE6] = { // AND &00
            self.current_instruction.caption = "and %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xE7] = { // RST &20
            self.current_instruction.addParam(param: 0x20)
            self.current_instruction.caption = "rst %@"
        }
        opcodes[0xE8] = { // RET PE
            self.current_instruction.caption = "ret pe"
        }
        opcodes[0xE9] = { // JP (HL)
            self.current_instruction.caption = "jp (hl)"
        }
        opcodes[0xEA] = { // JP PE &0000
            self.current_instruction.caption = "jp pe %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xEB] = { // EX DE, HL
            self.current_instruction.caption = "ex de,hl"
        }
        opcodes[0xEC] = { // CALL PE &0000
            self.current_instruction.caption = "call pe %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xED] = { // PREFIX *** ED ***
            self.id_opcode_table = table_ED
            self.processInstruction()
            self.id_opcode_table = table_NONE
        }
        opcodes[0xEE] = { // XOR &00
            self.current_instruction.caption = "xor %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xEF] = { // RST &28
            self.current_instruction.addParam(param: 0x28)
            self.current_instruction.caption = "rst %@"
        }
        opcodes[0xF0] = { // RET P
            self.current_instruction.caption = "ret p"
        }
        opcodes[0xF1] = { // POP AF
            self.current_instruction.caption = "pop af"
        }
        opcodes[0xF2] = { // JP P &0000
            self.current_instruction.caption = "jp p %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xF3] = { // DI
            self.current_instruction.caption = "di"
        }
        opcodes[0xF4] = { // CALL P &0000
            self.current_instruction.caption = "call p %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xF5] = { // PUSH AF
            self.current_instruction.caption = "push af"
        }
        opcodes[0xF6] = { // OR &00
            self.current_instruction.caption = "or %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xF7] = { // RST &30
            self.current_instruction.addParam(param: 0x30)
            self.current_instruction.caption = "rst %@"
        }
        opcodes[0xF8] = { // RET M
            self.current_instruction.caption = "ret m"
        }
        opcodes[0xF9] = { // LD SP, HL
            self.current_instruction.caption = "ld sp,hl"
        }
        opcodes[0xFA] = { // JP M &0000
            self.current_instruction.caption = "jp m %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xFB] = { // EI
            self.current_instruction.caption = "ei"
        }
        opcodes[0xFC] = { // CALL M &0000
            self.current_instruction.caption = "call m %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.current_instruction.addParam(param: self.dataRead(self.pc &+ 1))
            self.pc = self.pc &+ 2
        }
        opcodes[0xFD] = { // PREFIX *** FD ***
            self.id_opcode_table = table_XX
            self.processInstruction()
            self.id_opcode_table = table_NONE
        }
        opcodes[0xFE] = { // CP &00
            self.current_instruction.caption = "cp %@"
            self.current_instruction.addParam(param: self.dataRead(self.pc))
            self.pc = self.pc &+ 1
        }
        opcodes[0xFF] = { // RST &38
            self.current_instruction.addParam(param: 0x38)
            self.current_instruction.caption = "rst %@"
        }
    }
}

