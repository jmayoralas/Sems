//
//  ControlUnit_opcodes_cb.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 21/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

// t_cycle = 8 ((CB)4, (Op)4)
extension Disassembler {
    func initOpcodeTableCB(_ opcodes: inout OpcodeTable) {
        opcodes[0x00] = { // RLC B
            self.current_instruction.caption = "rlc b"
        }
        opcodes[0x01] = { // RLC C
            self.current_instruction.caption = "rlc c"
        }
        opcodes[0x02] = { // RLC D
            self.current_instruction.caption = "rlc d"
        }
        opcodes[0x03] = { // RLC E
            self.current_instruction.caption = "rlc e"
        }
        opcodes[0x04] = { // RLC H
            self.current_instruction.caption = "rlc h"
        }
        opcodes[0x05] = { // RLC L
            self.current_instruction.caption = "rlc l"
        }
        opcodes[0x06] = { // RLC (HL)
            self.current_instruction.caption = "rlc (hl)"
        }
        opcodes[0x07] = { // RLC A
            self.current_instruction.caption = "rlc a"
        }
        opcodes[0x08] = { // RRC B
            self.current_instruction.caption = "rrc b"
        }
        opcodes[0x09] = { // RRC C
            self.current_instruction.caption = "rrc c"
        }
        opcodes[0x0A] = { // RRC D
            self.current_instruction.caption = "rrc d"
        }
        opcodes[0x0B] = { // RRC E
            self.current_instruction.caption = "rrc e"
        }
        opcodes[0x0C] = { // RRC H
            self.current_instruction.caption = "rrc h"
        }
        opcodes[0x0D] = { // RRC L
            self.current_instruction.caption = "rrc l"
        }
        opcodes[0x0E] = { // RRC (HL)
            self.current_instruction.caption = "rrc (hl)"
        }
        opcodes[0x0F] = { // RRC A
            self.current_instruction.caption = "rrc a"
        }
        opcodes[0x10] = { // RL B
            self.current_instruction.caption = "rl b"
        }
        opcodes[0x11] = { // RL C
            self.current_instruction.caption = "rl c"
        }
        opcodes[0x12] = { // RL D
            self.current_instruction.caption = "rl d"
        }
        opcodes[0x13] = { // RL E
            self.current_instruction.caption = "rl e"
        }
        opcodes[0x14] = { // RL H
            self.current_instruction.caption = "rl h"
        }
        opcodes[0x15] = { // RL L
            self.current_instruction.caption = "rl l"
        }
        opcodes[0x16] = { // RL (HL)
            self.current_instruction.caption = "rl (hl)"
        }
        opcodes[0x17] = { // RL A
            self.current_instruction.caption = "rl a"
        }
        opcodes[0x18] = { // RR B
            self.current_instruction.caption = "rr b"
        }
        opcodes[0x19] = { // RR C
            self.current_instruction.caption = "rr c"
        }
        opcodes[0x1A] = { // RR D
            self.current_instruction.caption = "rr d"
        }
        opcodes[0x1B] = { // RR E
            self.current_instruction.caption = "rr e"
        }
        opcodes[0x1C] = { // RR H
            self.current_instruction.caption = "rr h"
        }
        opcodes[0x1D] = { // RR L
            self.current_instruction.caption = "rr l"
        }
        opcodes[0x1E] = { // RR (HL)
            self.current_instruction.caption = "rr (hl)"
        }
        opcodes[0x1F] = { // RR A
            self.current_instruction.caption = "rr a"
        }
        opcodes[0x20] = { // SLA B
            self.current_instruction.caption = "sla b"
        }
        opcodes[0x21] = { // SLA C
            self.current_instruction.caption = "sla c"
        }
        opcodes[0x22] = { // SLA D
            self.current_instruction.caption = "sla d"
        }
        opcodes[0x23] = { // SLA E
            self.current_instruction.caption = "sla e"
        }
        opcodes[0x24] = { // SLA H
            self.current_instruction.caption = "sla h"
        }
        opcodes[0x25] = { // SLA L
            self.current_instruction.caption = "sla l"
        }
        opcodes[0x26] = { // SLA (HL)
            self.current_instruction.caption = "sla (hl)"
        }
        opcodes[0x27] = { // SLA A
            self.current_instruction.caption = "sla a"
        }
        opcodes[0x28] = { // SRA B
            self.current_instruction.caption = "sra b"
        }
        opcodes[0x29] = { // SRA C
            self.current_instruction.caption = "sra c"
        }
        opcodes[0x2A] = { // SRA D
            self.current_instruction.caption = "sra d"
        }
        opcodes[0x2B] = { // SRA E
            self.current_instruction.caption = "sra e"
        }
        opcodes[0x2C] = { // SRA H
            self.current_instruction.caption = "sra h"
        }
        opcodes[0x2D] = { // SRA L
            self.current_instruction.caption = "sra l"
        }
        opcodes[0x2E] = { // SRA (HL)
            self.current_instruction.caption = "sra (hl)"
        }
        opcodes[0x2F] = { // SRA A
            self.current_instruction.caption = "sra a"
        }
        opcodes[0x30] = { // SLS B
            self.current_instruction.caption = "sls b"
        }
        opcodes[0x31] = { // SLS C
            self.current_instruction.caption = "sls c"
        }
        opcodes[0x32] = { // SLS D
            self.current_instruction.caption = "sls d"
        }
        opcodes[0x33] = { // SLS E
            self.current_instruction.caption = "sls e"
        }
        opcodes[0x34] = { // SLS H
            self.current_instruction.caption = "sls h"
        }
        opcodes[0x35] = { // SLS L
            self.current_instruction.caption = "sls l"
        }
        opcodes[0x36] = { // SLS (HL)
            self.current_instruction.caption = "sls (hl)"
        }
        opcodes[0x37] = { // SLS A
            self.current_instruction.caption = "sls a"
        }
        opcodes[0x38] = { // SRL B
            self.current_instruction.caption = "srl b"
        }
        opcodes[0x39] = { // SRL C
            self.current_instruction.caption = "srl c"
        }
        opcodes[0x3A] = { // SRL D
            self.current_instruction.caption = "srl d"
        }
        opcodes[0x3B] = { // SRL E
            self.current_instruction.caption = "srl e"
        }
        opcodes[0x3C] = { // SRL H
            self.current_instruction.caption = "srl h"
        }
        opcodes[0x3D] = { // SRL L
            self.current_instruction.caption = "srl l"
        }
        opcodes[0x3E] = { // SRL (HL)
            self.current_instruction.caption = "srl (hl)"
        }
        opcodes[0x3F] = { // SRL A
            self.current_instruction.caption = "srl a"
        }
        opcodes[0x40] = { // BIT 0,B
            self.current_instruction.caption = "bit 0,b"
        }
        opcodes[0x41] = { // BIT 0,C
            self.current_instruction.caption = "bit 0,c"
        }
        opcodes[0x42] = { // BIT 0,D
            self.current_instruction.caption = "bit 0,d"
        }
        opcodes[0x43] = { // BIT 0,E
            self.current_instruction.caption = "bit 0,e"
        }
        opcodes[0x44] = { // BIT 0,H
            self.current_instruction.caption = "bit 0,h"
        }
        opcodes[0x45] = { // BIT 0,L
            self.current_instruction.caption = "bit 0,l"
        }
        opcodes[0x46] = { // BIT 0,(HL)
            self.current_instruction.caption = "bit 0,(hl)"
        }
        opcodes[0x47] = { // BIT 0,A
            self.current_instruction.caption = "bit 0,a"
        }
        opcodes[0x48] = { // BIT 1,B
            self.current_instruction.caption = "bit 1,b"
        }
        opcodes[0x49] = { // BIT 1,C
            self.current_instruction.caption = "bit 1,c"
        }
        opcodes[0x4A] = { // BIT 1,D
            self.current_instruction.caption = "bit 1,d"
        }
        opcodes[0x4B] = { // BIT 1,E
            self.current_instruction.caption = "bit 1,e"
        }
        opcodes[0x4C] = { // BIT 1,H
            self.current_instruction.caption = "bit 1,h"
        }
        opcodes[0x4D] = { // BIT 1,L
            self.current_instruction.caption = "bit 1,l"
        }
        opcodes[0x4E] = { // BIT 1,(HL)
            self.current_instruction.caption = "bit 1,(hl)"
        }
        opcodes[0x4F] = { // BIT 1,A
            self.current_instruction.caption = "bit 1,a"
        }
        opcodes[0x50] = { // BIT 2,B
            self.current_instruction.caption = "bit 2,b"
        }
        opcodes[0x51] = { // BIT 2,C
            self.current_instruction.caption = "bit 2,c"
        }
        opcodes[0x52] = { // BIT 2,D
            self.current_instruction.caption = "bit 2,d"
        }
        opcodes[0x53] = { // BIT 2,E
            self.current_instruction.caption = "bit 2,e"
        }
        opcodes[0x54] = { // BIT 2,H
            self.current_instruction.caption = "bit 2,h"
        }
        opcodes[0x55] = { // BIT 2,L
            self.current_instruction.caption = "bit 2,l"
        }
        opcodes[0x56] = { // BIT 2,(HL)
            self.current_instruction.caption = "bit 2,(hl)"
        }
        opcodes[0x57] = { // BIT 2,A
            self.current_instruction.caption = "bit 2,a"
        }
        opcodes[0x58] = { // BIT 3,B
            self.current_instruction.caption = "bit 3,b"
        }
        opcodes[0x59] = { // BIT 3,C
            self.current_instruction.caption = "bit 3,c"
        }
        opcodes[0x5A] = { // BIT 3,D
            self.current_instruction.caption = "bit 3,d"
        }
        opcodes[0x5B] = { // BIT 3,E
            self.current_instruction.caption = "bit 3,e"
        }
        opcodes[0x5C] = { // BIT 3,H
            self.current_instruction.caption = "bit 3,h"
        }
        opcodes[0x5D] = { // BIT 3,L
            self.current_instruction.caption = "bit 3,l"
        }
        opcodes[0x5E] = { // BIT 3,(HL)
            self.current_instruction.caption = "bit 3,(hl)"
        }
        opcodes[0x5F] = { // BIT 3,A
            self.current_instruction.caption = "bit 3,a"
        }
        opcodes[0x60] = { // BIT 4,B
            self.current_instruction.caption = "bit 4,b"
        }
        opcodes[0x61] = { // BIT 4,C
            self.current_instruction.caption = "bit 4,c"
        }
        opcodes[0x62] = { // BIT 4,D
            self.current_instruction.caption = "bit 4,d"
        }
        opcodes[0x63] = { // BIT 4,E
            self.current_instruction.caption = "bit 4,e"
        }
        opcodes[0x64] = { // BIT 4,H
            self.current_instruction.caption = "bit 4,h"
        }
        opcodes[0x65] = { // BIT 4,L
            self.current_instruction.caption = "bit 4,l"
        }
        opcodes[0x66] = { // BIT 4,(HL)
            self.current_instruction.caption = "bit 4,(hl)"
        }
        opcodes[0x67] = { // BIT 4,A
            self.current_instruction.caption = "bit 4,a"
        }
        opcodes[0x68] = { // BIT 5,B
            self.current_instruction.caption = "bit 5,b"
        }
        opcodes[0x69] = { // BIT 5,C
            self.current_instruction.caption = "bit 5,c"
        }
        opcodes[0x6A] = { // BIT 5,D
            self.current_instruction.caption = "bit 5,d"
        }
        opcodes[0x6B] = { // BIT 5,E
            self.current_instruction.caption = "bit 5,e"
        }
        opcodes[0x6C] = { // BIT 5,H
            self.current_instruction.caption = "bit 5,h"
        }
        opcodes[0x6D] = { // BIT 5,L
            self.current_instruction.caption = "bit 5,l"
        }
        opcodes[0x6E] = { // BIT 5,(HL)
            self.current_instruction.caption = "bit 5,(hl)"
        }
        opcodes[0x6F] = { // BIT 5,A
            self.current_instruction.caption = "bit 5,a"
        }
        opcodes[0x70] = { // BIT 6,B
            self.current_instruction.caption = "bit 6,b"
        }
        opcodes[0x71] = { // BIT 6,C
            self.current_instruction.caption = "bit 6,c"
        }
        opcodes[0x72] = { // BIT 6,D
            self.current_instruction.caption = "bit 6,d"
        }
        opcodes[0x73] = { // BIT 6,E
            self.current_instruction.caption = "bit 6,e"
        }
        opcodes[0x74] = { // BIT 6,H
            self.current_instruction.caption = "bit 6,h"
        }
        opcodes[0x75] = { // BIT 6,L
            self.current_instruction.caption = "bit 6,l"
        }
        opcodes[0x76] = { // BIT 6,(HL)
            self.current_instruction.caption = "bit 6,(hl)"
        }
        opcodes[0x77] = { // BIT 6,A
            self.current_instruction.caption = "bit 6,a"
        }
        opcodes[0x78] = { // BIT 7,B
            self.current_instruction.caption = "bit 7,b"
        }
        opcodes[0x79] = { // BIT 7,C
            self.current_instruction.caption = "bit 7,c"
        }
        opcodes[0x7A] = { // BIT 7,D
            self.current_instruction.caption = "bit 7,d"
        }
        opcodes[0x7B] = { // BIT 7,E
            self.current_instruction.caption = "bit 7,e"
        }
        opcodes[0x7C] = { // BIT 7,H
            self.current_instruction.caption = "bit 7,h"
        }
        opcodes[0x7D] = { // BIT 7,L
            self.current_instruction.caption = "bit 7,l"
        }
        opcodes[0x7E] = { // BIT 7,(HL)
            self.current_instruction.caption = "bit 7,(hl)"
        }
        opcodes[0x7F] = { // BIT 7,A
            self.current_instruction.caption = "bit 7,a"
        }
        opcodes[0x80] = { // RES 0,B
            self.current_instruction.caption = "res 0,b"
        }
        opcodes[0x81] = { // RES 0,C
            self.current_instruction.caption = "res 0,c"
        }
        opcodes[0x82] = { // RES 0,D
            self.current_instruction.caption = "res 0,d"
        }
        opcodes[0x83] = { // RES 0,E
            self.current_instruction.caption = "res 0,e"
        }
        opcodes[0x84] = { // RES 0,H
            self.current_instruction.caption = "res 0,h"
        }
        opcodes[0x85] = { // RES 0,L
            self.current_instruction.caption = "res 0,l"
        }
        opcodes[0x86] = { // RES 0,(HL)
            self.current_instruction.caption = "res 0,(hl)"
        }
        opcodes[0x87] = { // RES 0,A
            self.current_instruction.caption = "res 0,a"
        }
        opcodes[0x88] = { // RES 1,B
            self.current_instruction.caption = "res 1,b"
        }
        opcodes[0x89] = { // RES 1,C
            self.current_instruction.caption = "res 1,c"
        }
        opcodes[0x8A] = { // RES 1,D
            self.current_instruction.caption = "res 1,d"
        }
        opcodes[0x8B] = { // RES 1,E
            self.current_instruction.caption = "res 1,e"
        }
        opcodes[0x8C] = { // RES 1,H
            self.current_instruction.caption = "res 1,h"
        }
        opcodes[0x8D] = { // RES 1,L
            self.current_instruction.caption = "res 1,l"
        }
        opcodes[0x8E] = { // RES 1,(HL)
            self.current_instruction.caption = "res 1,(hl)"
        }
        opcodes[0x8F] = { // RES 1,A
            self.current_instruction.caption = "res 1,a"
        }
        opcodes[0x90] = { // RES 2,B
            self.current_instruction.caption = "res 2,b"
        }
        opcodes[0x91] = { // RES 2,C
            self.current_instruction.caption = "res 2,c"
        }
        opcodes[0x92] = { // RES 2,D
            self.current_instruction.caption = "res 2,d"
        }
        opcodes[0x93] = { // RES 2,E
            self.current_instruction.caption = "res 2,e"
        }
        opcodes[0x94] = { // RES 2,H
            self.current_instruction.caption = "res 2,h"
        }
        opcodes[0x95] = { // RES 2,L
            self.current_instruction.caption = "res 2,l"
        }
        opcodes[0x96] = { // RES 2,(HL)
            self.current_instruction.caption = "res 2,(hl)"
        }
        opcodes[0x97] = { // RES 2,A
            self.current_instruction.caption = "res 2,a"
        }
        opcodes[0x98] = { // RES 3,B
            self.current_instruction.caption = "res 3,b"
        }
        opcodes[0x99] = { // RES 3,C
            self.current_instruction.caption = "res 3,c"
        }
        opcodes[0x9A] = { // RES 3,D
            self.current_instruction.caption = "res 3,d"
        }
        opcodes[0x9B] = { // RES 3,E
            self.current_instruction.caption = "res 3,e"
        }
        opcodes[0x9C] = { // RES 3,H
            self.current_instruction.caption = "res 3,h"
        }
        opcodes[0x9D] = { // RES 3,L
            self.current_instruction.caption = "res 3,l"
        }
        opcodes[0x9E] = { // RES 3,(HL)
            self.current_instruction.caption = "res 3,(hl)"
        }
        opcodes[0x9F] = { // RES 3,A
            self.current_instruction.caption = "res 3,a"
        }
        opcodes[0xA0] = { // RES 4,B
            self.current_instruction.caption = "res 4,b"
        }
        opcodes[0xA1] = { // RES 4,C
            self.current_instruction.caption = "res 4,c"
        }
        opcodes[0xA2] = { // RES 4,D
            self.current_instruction.caption = "res 4,d"
        }
        opcodes[0xA3] = { // RES 4,E
            self.current_instruction.caption = "res 4,e"
        }
        opcodes[0xA4] = { // RES 4,H
            self.current_instruction.caption = "res 4,h"
        }
        opcodes[0xA5] = { // RES 4,L
            self.current_instruction.caption = "res 4,l"
        }
        opcodes[0xA6] = { // RES 4,(HL)
            self.current_instruction.caption = "res 4,(hl)"
        }
        opcodes[0xA7] = { // RES 4,A
            self.current_instruction.caption = "res 4,a"
        }
        opcodes[0xA8] = { // RES 5,B
            self.current_instruction.caption = "res 5,b"
        }
        opcodes[0xA9] = { // RES 5,C
            self.current_instruction.caption = "res 5,c"
        }
        opcodes[0xAA] = { // RES 5,D
            self.current_instruction.caption = "res 5,d"
        }
        opcodes[0xAB] = { // RES 5,E
            self.current_instruction.caption = "res 5,e"
        }
        opcodes[0xAC] = { // RES 5,H
            self.current_instruction.caption = "res 5,h"
        }
        opcodes[0xAD] = { // RES 5,L
            self.current_instruction.caption = "res 5,l"
        }
        opcodes[0xAE] = { // RES 5,(HL)
            self.current_instruction.caption = "res 5,(hl)"
        }
        opcodes[0xAF] = { // RES 5,A
            self.current_instruction.caption = "res 5,a"
        }
        opcodes[0xB0] = { // RES 6,B
            self.current_instruction.caption = "res 6,b"
        }
        opcodes[0xB1] = { // RES 6,C
            self.current_instruction.caption = "res 6,c"
        }
        opcodes[0xB2] = { // RES 6,D
            self.current_instruction.caption = "res 6,d"
        }
        opcodes[0xB3] = { // RES 6,E
            self.current_instruction.caption = "res 6,e"
        }
        opcodes[0xB4] = { // RES 6,H
            self.current_instruction.caption = "res 6,h"
        }
        opcodes[0xB5] = { // RES 6,L
            self.current_instruction.caption = "res 6,l"
        }
        opcodes[0xB6] = { // RES 6,(HL)
            self.current_instruction.caption = "res 6,(hl)"
        }
        opcodes[0xB7] = { // RES 6,A
            self.current_instruction.caption = "res 6,a"
        }
        opcodes[0xB8] = { // RES 7,B
            self.current_instruction.caption = "res 7,b"
        }
        opcodes[0xB9] = { // RES 7,C
            self.current_instruction.caption = "res 7,c"
        }
        opcodes[0xBA] = { // RES 7,D
            self.current_instruction.caption = "res 7,d"
        }
        opcodes[0xBB] = { // RES 7,E
            self.current_instruction.caption = "res 7,e"
        }
        opcodes[0xBC] = { // RES 7,H
            self.current_instruction.caption = "res 7,h"
        }
        opcodes[0xBD] = { // RES 7,L
            self.current_instruction.caption = "res 7,l"
        }
        opcodes[0xBE] = { // RES 7,(HL)
            self.current_instruction.caption = "res 7,(hl)"
        }
        opcodes[0xBF] = { // RES 7,A
            self.current_instruction.caption = "res 7,a"
        }
        opcodes[0xC0] = { // SET 0,B
            self.current_instruction.caption = "set 0,b"
        }
        opcodes[0xC1] = { // SET 0,C
            self.current_instruction.caption = "set 0,c"
        }
        opcodes[0xC2] = { // SET 0,D
            self.current_instruction.caption = "set 0,d"
        }
        opcodes[0xC3] = { // SET 0,E
            self.current_instruction.caption = "set 0,e"
        }
        opcodes[0xC4] = { // SET 0,H
            self.current_instruction.caption = "set 0,h"
        }
        opcodes[0xC5] = { // SET 0,L
            self.current_instruction.caption = "set 0,l"
        }
        opcodes[0xC6] = { // SET 0,(HL)
            self.current_instruction.caption = "set 0,(hl)"
        }
        opcodes[0xC7] = { // SET 0,A
            self.current_instruction.caption = "set 0,a"
        }
        opcodes[0xC8] = { // SET 1,B
            self.current_instruction.caption = "set 1,b"
        }
        opcodes[0xC9] = { // SET 1,C
            self.current_instruction.caption = "set 1,c"
        }
        opcodes[0xCA] = { // SET 1,D
            self.current_instruction.caption = "set 1,d"
        }
        opcodes[0xCB] = { // SET 1,E
            self.current_instruction.caption = "set 1,e"
        }
        opcodes[0xCC] = { // SET 1,H
            self.current_instruction.caption = "set 1,h"
        }
        opcodes[0xCD] = { // SET 1,L
            self.current_instruction.caption = "set 1,l"
        }
        opcodes[0xCE] = { // SET 1,(HL)
            self.current_instruction.caption = "set 1,(hl)"
        }
        opcodes[0xCF] = { // SET 1,A
            self.current_instruction.caption = "set 1,a"
        }
        opcodes[0xD0] = { // SET 2,B
            self.current_instruction.caption = "set 2,b"
        }
        opcodes[0xD1] = { // SET 2,C
            self.current_instruction.caption = "set 2,c"
        }
        opcodes[0xD2] = { // SET 2,D
            self.current_instruction.caption = "set 2,d"
        }
        opcodes[0xD3] = { // SET 2,E
            self.current_instruction.caption = "set 2,e"
        }
        opcodes[0xD4] = { // SET 2,H
            self.current_instruction.caption = "set 2,h"
        }
        opcodes[0xD5] = { // SET 2,L
            self.current_instruction.caption = "set 2,l"
        }
        opcodes[0xD6] = { // SET 2,(HL)
            self.current_instruction.caption = "set 2,(hl)"
        }
        opcodes[0xD7] = { // SET 2,A
            self.current_instruction.caption = "set 2,a"
        }
        opcodes[0xD8] = { // SET 3,B
            self.current_instruction.caption = "set 3,b"
        }
        opcodes[0xD9] = { // SET 3,C
            self.current_instruction.caption = "set 3,c"
        }
        opcodes[0xDA] = { // SET 3,D
            self.current_instruction.caption = "set 3,d"
        }
        opcodes[0xDB] = { // SET 3,E
            self.current_instruction.caption = "set 3,e"
        }
        opcodes[0xDC] = { // SET 3,H
            self.current_instruction.caption = "set 3,h"
        }
        opcodes[0xDD] = { // SET 3,L
            self.current_instruction.caption = "set 3,l"
        }
        opcodes[0xDE] = { // SET 3,(HL)
            self.current_instruction.caption = "set 3,(hl)"
        }
        opcodes[0xDF] = { // SET 3,A
            self.current_instruction.caption = "set 3,a"
        }
        opcodes[0xE0] = { // SET 4,B
            self.current_instruction.caption = "set 4,b"
        }
        opcodes[0xE1] = { // SET 4,C
            self.current_instruction.caption = "set 4,c"
        }
        opcodes[0xE2] = { // SET 4,D
            self.current_instruction.caption = "set 4,d"
        }
        opcodes[0xE3] = { // SET 4,E
            self.current_instruction.caption = "set 4,e"
        }
        opcodes[0xE4] = { // SET 4,H
            self.current_instruction.caption = "set 4,h"
        }
        opcodes[0xE5] = { // SET 4,L
            self.current_instruction.caption = "set 4,l"
        }
        opcodes[0xE6] = { // SET 4,(HL)
            self.current_instruction.caption = "set 4,(hl)"
        }
        opcodes[0xE7] = { // SET 4,A
            self.current_instruction.caption = "set 4,a"
        }
        opcodes[0xE8] = { // SET 5,B
            self.current_instruction.caption = "set 5,b"
        }
        opcodes[0xE9] = { // SET 5,C
            self.current_instruction.caption = "set 5,c"
        }
        opcodes[0xEA] = { // SET 5,D
            self.current_instruction.caption = "set 5,d"
        }
        opcodes[0xEB] = { // SET 5,E
            self.current_instruction.caption = "set 5,e"
        }
        opcodes[0xEC] = { // SET 5,H
            self.current_instruction.caption = "set 5,h"
        }
        opcodes[0xED] = { // SET 5,L
            self.current_instruction.caption = "set 5,l"
        }
        opcodes[0xEE] = { // SET 5,(HL)
            self.current_instruction.caption = "set 5,(hl)"
        }
        opcodes[0xEF] = { // SET 5,A
            self.current_instruction.caption = "set 5,a"
        }
        opcodes[0xF0] = { // SET 6,B
            self.current_instruction.caption = "set 6,b"
        }
        opcodes[0xF1] = { // SET 6,C
            self.current_instruction.caption = "set 6,c"
        }
        opcodes[0xF2] = { // SET 6,D
            self.current_instruction.caption = "set 6,d"
        }
        opcodes[0xF3] = { // SET 6,E
            self.current_instruction.caption = "set 6,e"
        }
        opcodes[0xF4] = { // SET 6,H
            self.current_instruction.caption = "set 6,h"
        }
        opcodes[0xF5] = { // SET 6,L
            self.current_instruction.caption = "set 6,l"
        }
        opcodes[0xF6] = { // SET 6,(HL)
            self.current_instruction.caption = "set 6,(hl)"
        }
        opcodes[0xF7] = { // SET 6,A
            self.current_instruction.caption = "set 6,a"
        }
        opcodes[0xF8] = { // SET 7,B
            self.current_instruction.caption = "set 7,b"
        }
        opcodes[0xF9] = { // SET 7,C
            self.current_instruction.caption = "set 7,c"
        }
        opcodes[0xFA] = { // SET 7,D
            self.current_instruction.caption = "set 7,d"
        }
        opcodes[0xFB] = { // SET 7,E
            self.current_instruction.caption = "set 7,e"
        }
        opcodes[0xFC] = { // SET 7,H
            self.current_instruction.caption = "set 7,h"
        }
        opcodes[0xFD] = { // SET 7,L
            self.current_instruction.caption = "set 7,l"
        }
        opcodes[0xFE] = { // SET 7,(HL)
            self.current_instruction.caption = "set 7,(hl)"
        }
        opcodes[0xFF] = { // SET 7,A
            self.current_instruction.caption = "set 7,a"
        }
    }
}
