//
//  ControlUnit_opcodes_cb.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 21/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

// t_cycle = 8 ((CB)4, (Op)4)
extension Z80 {
    func initOpcodeTableCB(_ opcodes: inout OpcodeTable) {
        opcodes[0x00] = { // RLC B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .rlc, ignoreCarry: false)
        }
        opcodes[0x01] = { // RLC C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .rlc, ignoreCarry: false)
        }
        opcodes[0x02] = { // RLC D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .rlc, ignoreCarry: false)
        }
        opcodes[0x03] = { // RLC E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .rlc, ignoreCarry: false)
        }
        opcodes[0x04] = { // RLC H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .rlc, ignoreCarry: false)
        }
        opcodes[0x05] = { // RLC L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .rlc, ignoreCarry: false)
        }
        opcodes[0x06] = { // RLC (HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .rlc, ignoreCarry: false)
            self.dataBus.write(self.regs.hl, value: data)
        }
        
        opcodes[0x07] = { // RLC A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .rlc, ignoreCarry: false)
        }
        opcodes[0x08] = { // RRC B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .rrc, ignoreCarry: false)
        }
        opcodes[0x09] = { // RRC C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .rrc, ignoreCarry: false)
        }
        opcodes[0x0A] = { // RRC D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .rrc, ignoreCarry: false)
        }
        opcodes[0x0B] = { // RRC E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .rrc, ignoreCarry: false)
        }
        opcodes[0x0C] = { // RRC H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .rrc, ignoreCarry: false)
        }
        opcodes[0x0D] = { // RRC L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .rrc, ignoreCarry: false)
        }
        opcodes[0x0E] = { // RRC (HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .rrc, ignoreCarry: false)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x0F] = { // RRC A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .rrc, ignoreCarry: false)
        }
        opcodes[0x10] = { // RL B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .rl, ignoreCarry: false)
        }
        opcodes[0x11] = { // RL C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .rl, ignoreCarry: false)
        }
        opcodes[0x12] = { // RL D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .rl, ignoreCarry: false)
        }
        opcodes[0x13] = { // RL E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .rl, ignoreCarry: false)
        }
        opcodes[0x14] = { // RL H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .rl, ignoreCarry: false)
        }
        opcodes[0x15] = { // RL L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .rl, ignoreCarry: false)
        }
        opcodes[0x16] = { // RL (HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .rl, ignoreCarry: false)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x17] = { // RL A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .rl, ignoreCarry: false)
        }
        opcodes[0x18] = { // RR B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .rr, ignoreCarry: false)
        }
        opcodes[0x19] = { // RR C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .rr, ignoreCarry: false)
        }
        opcodes[0x1A] = { // RR D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .rr, ignoreCarry: false)
        }
        opcodes[0x1B] = { // RR E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .rr, ignoreCarry: false)
        }
        opcodes[0x1C] = { // RR H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .rr, ignoreCarry: false)
        }
        opcodes[0x1D] = { // RR L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .rr, ignoreCarry: false)
        }
        opcodes[0x1E] = { // RR (HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .rr, ignoreCarry: false)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x1F] = { // RR A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .rr, ignoreCarry: false)
        }
        opcodes[0x20] = { // SLA B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .sla, ignoreCarry: false)
        }
        opcodes[0x21] = { // SLA C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .sla, ignoreCarry: false)
        }
        opcodes[0x22] = { // SLA D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .sla, ignoreCarry: false)
        }
        opcodes[0x23] = { // SLA E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .sla, ignoreCarry: false)
        }
        opcodes[0x24] = { // SLA H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .sla, ignoreCarry: false)
        }
        opcodes[0x25] = { // SLA L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .sla, ignoreCarry: false)
        }
        opcodes[0x26] = { // SLA (HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .sla, ignoreCarry: false)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x27] = { // SLA A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .sla, ignoreCarry: false)
        }
        opcodes[0x28] = { // SRA B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .sra, ignoreCarry: false)
        }
        opcodes[0x29] = { // SRA C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .sra, ignoreCarry: false)
        }
        opcodes[0x2A] = { // SRA D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .sra, ignoreCarry: false)
        }
        opcodes[0x2B] = { // SRA E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .sra, ignoreCarry: false)
        }
        opcodes[0x2C] = { // SRA H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .sra, ignoreCarry: false)
        }
        opcodes[0x2D] = { // SRA L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .sra, ignoreCarry: false)
        }
        opcodes[0x2E] = { // SRA (HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .sra, ignoreCarry: false)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x2F] = { // SRA A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .sra, ignoreCarry: false)
        }
        opcodes[0x30] = { // SLS B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .sls, ignoreCarry: false)
        }
        opcodes[0x31] = { // SLS C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .sls, ignoreCarry: false)
        }
        opcodes[0x32] = { // SLS D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .sls, ignoreCarry: false)
        }
        opcodes[0x33] = { // SLS E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .sls, ignoreCarry: false)
        }
        opcodes[0x34] = { // SLS H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .sls, ignoreCarry: false)
        }
        opcodes[0x35] = { // SLS L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .sls, ignoreCarry: false)
        }
        opcodes[0x36] = { // SLS (HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .sls, ignoreCarry: false)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x37] = { // SLS A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .sls, ignoreCarry: false)
        }
        opcodes[0x38] = { // SRL B
            self.regs.b = self.aluCall(self.regs.b, 1, ulaOp: .srl, ignoreCarry: false)
        }
        opcodes[0x39] = { // SRL C
            self.regs.c = self.aluCall(self.regs.c, 1, ulaOp: .srl, ignoreCarry: false)
        }
        opcodes[0x3A] = { // SRL D
            self.regs.d = self.aluCall(self.regs.d, 1, ulaOp: .srl, ignoreCarry: false)
        }
        opcodes[0x3B] = { // SRL E
            self.regs.e = self.aluCall(self.regs.e, 1, ulaOp: .srl, ignoreCarry: false)
        }
        opcodes[0x3C] = { // SRL H
            self.regs.h = self.aluCall(self.regs.h, 1, ulaOp: .srl, ignoreCarry: false)
        }
        opcodes[0x3D] = { // SRL L
            self.regs.l = self.aluCall(self.regs.l, 1, ulaOp: .srl, ignoreCarry: false)
        }
        opcodes[0x3E] = { // SRL (HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data = self.aluCall(data, 1, ulaOp: .srl, ignoreCarry: false)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x3F] = { // SRL A
            self.regs.a = self.aluCall(self.regs.a, 1, ulaOp: .srl, ignoreCarry: false)
        }
        opcodes[0x40] = { // BIT 0,B
            let _ = self.aluCall(self.regs.b, 0, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x41] = { // BIT 0,C
            let _ = self.aluCall(self.regs.c, 0, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x42] = { // BIT 0,D
            let _ = self.aluCall(self.regs.d, 0, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x43] = { // BIT 0,E
            let _ = self.aluCall(self.regs.e, 0, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x44] = { // BIT 0,H
            let _ = self.aluCall(self.regs.h, 0, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x45] = { // BIT 0,L
            let _ = self.aluCall(self.regs.l, 0, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x46] = { // BIT 0,(HL)
            self.clock.add(tCycles: 1)
            let _ = self.aluCall(self.dataBus.read(self.regs.hl), 0, ulaOp: .bit, ignoreCarry: false)
            
            self.regs.f.bit(3, newVal: self.regs.hl.high.bit(3))
            self.regs.f.bit(5, newVal: self.regs.hl.high.bit(5))
        }
        opcodes[0x47] = { // BIT 0,A
            let _ = self.aluCall(self.regs.a, 0, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x48] = { // BIT 1,B
            let _ = self.aluCall(self.regs.b, 1, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x49] = { // BIT 1,C
            let _ = self.aluCall(self.regs.c, 1, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x4A] = { // BIT 1,D
            let _ = self.aluCall(self.regs.d, 1, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x4B] = { // BIT 1,E
            let _ = self.aluCall(self.regs.e, 1, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x4C] = { // BIT 1,H
            let _ = self.aluCall(self.regs.h, 1, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x4D] = { // BIT 1,L
            let _ = self.aluCall(self.regs.l, 1, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x4E] = { // BIT 1,(HL)
            self.clock.add(tCycles: 1)
            let _ = self.aluCall(self.dataBus.read(self.regs.hl), 1, ulaOp: .bit, ignoreCarry: false)
            
            self.regs.f.bit(3, newVal: self.regs.hl.high.bit(3))
            self.regs.f.bit(5, newVal: self.regs.hl.high.bit(5))
        }
        opcodes[0x4F] = { // BIT 1,A
            let _ = self.aluCall(self.regs.a, 1, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x50] = { // BIT 2,B
            let _ = self.aluCall(self.regs.b, 2, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x51] = { // BIT 2,C
            let _ = self.aluCall(self.regs.c, 2, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x52] = { // BIT 2,D
            let _ = self.aluCall(self.regs.d, 2, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x53] = { // BIT 2,E
            let _ = self.aluCall(self.regs.e, 2, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x54] = { // BIT 2,H
            let _ = self.aluCall(self.regs.h, 2, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x55] = { // BIT 2,L
            let _ = self.aluCall(self.regs.l, 2, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x56] = { // BIT 2,(HL)
            self.clock.add(tCycles: 1)
            let _ = self.aluCall(self.dataBus.read(self.regs.hl), 2, ulaOp: .bit, ignoreCarry: false)
            
            self.regs.f.bit(3, newVal: self.regs.hl.high.bit(3))
            self.regs.f.bit(5, newVal: self.regs.hl.high.bit(5))
        }
        opcodes[0x57] = { // BIT 2,A
            let _ = self.aluCall(self.regs.a, 2, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x58] = { // BIT 3,B
            let _ = self.aluCall(self.regs.b, 3, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x59] = { // BIT 3,C
            let _ = self.aluCall(self.regs.c, 3, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x5A] = { // BIT 3,D
            let _ = self.aluCall(self.regs.d, 3, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x5B] = { // BIT 3,E
            let _ = self.aluCall(self.regs.e, 3, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x5C] = { // BIT 3,H
            let _ = self.aluCall(self.regs.h, 3, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x5D] = { // BIT 3,L
            let _ = self.aluCall(self.regs.l, 3, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x5E] = { // BIT 3,(HL)
            self.clock.add(tCycles: 1)
            let _ = self.aluCall(self.dataBus.read(self.regs.hl), 3, ulaOp: .bit, ignoreCarry: false)
            
            self.regs.f.bit(3, newVal: self.regs.hl.high.bit(3))
            self.regs.f.bit(5, newVal: self.regs.hl.high.bit(5))
        }
        opcodes[0x5F] = { // BIT 3,A
            let _ = self.aluCall(self.regs.a, 3, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x60] = { // BIT 4,B
            let _ = self.aluCall(self.regs.b, 4, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x61] = { // BIT 4,C
            let _ = self.aluCall(self.regs.c, 4, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x62] = { // BIT 4,D
            let _ = self.aluCall(self.regs.d, 4, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x63] = { // BIT 4,E
            let _ = self.aluCall(self.regs.e, 4, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x64] = { // BIT 4,H
            let _ = self.aluCall(self.regs.h, 4, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x65] = { // BIT 4,L
            let _ = self.aluCall(self.regs.l, 4, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x66] = { // BIT 4,(HL)
            self.clock.add(tCycles: 1)
            let _ = self.aluCall(self.dataBus.read(self.regs.hl), 4, ulaOp: .bit, ignoreCarry: false)
            
            self.regs.f.bit(3, newVal: self.regs.hl.high.bit(3))
            self.regs.f.bit(5, newVal: self.regs.hl.high.bit(5))
        }
        opcodes[0x67] = { // BIT 4,A
            let _ = self.aluCall(self.regs.a, 4, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x68] = { // BIT 5,B
            let _ = self.aluCall(self.regs.b, 5, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x69] = { // BIT 5,C
            let _ = self.aluCall(self.regs.c, 5, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x6A] = { // BIT 5,D
            let _ = self.aluCall(self.regs.d, 5, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x6B] = { // BIT 5,E
            let _ = self.aluCall(self.regs.e, 5, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x6C] = { // BIT 5,H
            let _ = self.aluCall(self.regs.h, 5, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x6D] = { // BIT 5,L
            let _ = self.aluCall(self.regs.l, 5, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x6E] = { // BIT 5,(HL)
            self.clock.add(tCycles: 1)
            let _ = self.aluCall(self.dataBus.read(self.regs.hl), 5, ulaOp: .bit, ignoreCarry: false)
            
            self.regs.f.bit(3, newVal: self.regs.hl.high.bit(3))
            self.regs.f.bit(5, newVal: self.regs.hl.high.bit(5))
        }
        opcodes[0x6F] = { // BIT 5,A
            let _ = self.aluCall(self.regs.a, 5, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x70] = { // BIT 6,B
            let _ = self.aluCall(self.regs.b, 6, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x71] = { // BIT 6,C
            let _ = self.aluCall(self.regs.c, 6, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x72] = { // BIT 6,D
            let _ = self.aluCall(self.regs.d, 6, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x73] = { // BIT 6,E
            let _ = self.aluCall(self.regs.e, 6, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x74] = { // BIT 6,H
            let _ = self.aluCall(self.regs.h, 6, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x75] = { // BIT 6,L
            let _ = self.aluCall(self.regs.l, 6, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x76] = { // BIT 6,(HL)
            self.clock.add(tCycles: 1)
            let _ = self.aluCall(self.dataBus.read(self.regs.hl), 6, ulaOp: .bit, ignoreCarry: false)
            
            self.regs.f.bit(3, newVal: self.regs.hl.high.bit(3))
            self.regs.f.bit(5, newVal: self.regs.hl.high.bit(5))
        }
        opcodes[0x77] = { // BIT 6,A
            let _ = self.aluCall(self.regs.a, 6, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x78] = { // BIT 7,B
            let _ = self.aluCall(self.regs.b, 7, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x79] = { // BIT 7,C
            let _ = self.aluCall(self.regs.c, 7, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x7A] = { // BIT 7,D
            let _ = self.aluCall(self.regs.d, 7, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x7B] = { // BIT 7,E
            let _ = self.aluCall(self.regs.e, 7, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x7C] = { // BIT 7,H
            let _ = self.aluCall(self.regs.h, 7, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x7D] = { // BIT 7,L
            let _ = self.aluCall(self.regs.l, 7, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x7E] = { // BIT 7,(HL)
            self.clock.add(tCycles: 1)
            let _ = self.aluCall(self.dataBus.read(self.regs.hl), 7, ulaOp: .bit, ignoreCarry: false)
            
            self.regs.f.bit(3, newVal: self.regs.hl.high.bit(3))
            self.regs.f.bit(5, newVal: self.regs.hl.high.bit(5))
        }
        opcodes[0x7F] = { // BIT 7,A
            let _ = self.aluCall(self.regs.a, 7, ulaOp: .bit, ignoreCarry: false)
        }
        opcodes[0x80] = { // RES 0,B
            self.regs.b.resetBit(0)
        }
        opcodes[0x81] = { // RES 0,C
            self.regs.c.resetBit(0)
        }
        opcodes[0x82] = { // RES 0,D
            self.regs.d.resetBit(0)
        }
        opcodes[0x83] = { // RES 0,E
            self.regs.e.resetBit(0)
        }
        opcodes[0x84] = { // RES 0,H
            self.regs.h.resetBit(0)
        }
        opcodes[0x85] = { // RES 0,L
            self.regs.l.resetBit(0)
        }
        opcodes[0x86] = { // RES 0,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.resetBit(0)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x87] = { // RES 0,A
            self.regs.a.resetBit(0)
        }
        opcodes[0x88] = { // RES 1,B
            self.regs.b.resetBit(1)
        }
        opcodes[0x89] = { // RES 1,C
            self.regs.c.resetBit(1)
        }
        opcodes[0x8A] = { // RES 1,D
            self.regs.d.resetBit(1)
        }
        opcodes[0x8B] = { // RES 1,E
            self.regs.e.resetBit(1)
        }
        opcodes[0x8C] = { // RES 1,H
            self.regs.h.resetBit(1)
        }
        opcodes[0x8D] = { // RES 1,L
            self.regs.l.resetBit(1)
        }
        opcodes[0x8E] = { // RES 1,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.resetBit(1)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x8F] = { // RES 1,A
            self.regs.a.resetBit(1)
        }
        opcodes[0x90] = { // RES 2,B
            self.regs.b.resetBit(2)
        }
        opcodes[0x91] = { // RES 2,C
            self.regs.c.resetBit(2)
        }
        opcodes[0x92] = { // RES 2,D
            self.regs.d.resetBit(2)
        }
        opcodes[0x93] = { // RES 2,E
            self.regs.e.resetBit(2)
        }
        opcodes[0x94] = { // RES 2,H
            self.regs.h.resetBit(2)
        }
        opcodes[0x95] = { // RES 2,L
            self.regs.l.resetBit(2)
        }
        opcodes[0x96] = { // RES 2,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.resetBit(2)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x97] = { // RES 2,A
            self.regs.a.resetBit(2)
        }
        opcodes[0x98] = { // RES 3,B
            self.regs.b.resetBit(3)
        }
        opcodes[0x99] = { // RES 3,C
            self.regs.c.resetBit(3)
        }
        opcodes[0x9A] = { // RES 3,D
            self.regs.d.resetBit(3)
        }
        opcodes[0x9B] = { // RES 3,E
            self.regs.e.resetBit(3)
        }
        opcodes[0x9C] = { // RES 3,H
            self.regs.h.resetBit(3)
        }
        opcodes[0x9D] = { // RES 3,L
            self.regs.l.resetBit(3)
        }
        opcodes[0x9E] = { // RES 3,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.resetBit(3)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0x9F] = { // RES 3,A
            self.regs.a.resetBit(3)
        }
        opcodes[0xA0] = { // RES 4,B
            self.regs.b.resetBit(4)
        }
        opcodes[0xA1] = { // RES 4,C
            self.regs.c.resetBit(4)
        }
        opcodes[0xA2] = { // RES 4,D
            self.regs.d.resetBit(4)
        }
        opcodes[0xA3] = { // RES 4,E
            self.regs.e.resetBit(4)
        }
        opcodes[0xA4] = { // RES 4,H
            self.regs.h.resetBit(4)
        }
        opcodes[0xA5] = { // RES 4,L
            self.regs.l.resetBit(4)
        }
        opcodes[0xA6] = { // RES 4,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.resetBit(4)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xA7] = { // RES 4,A
            self.regs.a.resetBit(4)
        }
        opcodes[0xA8] = { // RES 5,B
            self.regs.b.resetBit(5)
        }
        opcodes[0xA9] = { // RES 5,C
            self.regs.c.resetBit(5)
        }
        opcodes[0xAA] = { // RES 5,D
            self.regs.d.resetBit(5)
        }
        opcodes[0xAB] = { // RES 5,E
            self.regs.e.resetBit(5)
        }
        opcodes[0xAC] = { // RES 5,H
            self.regs.h.resetBit(5)
        }
        opcodes[0xAD] = { // RES 5,L
            self.regs.l.resetBit(5)
        }
        opcodes[0xAE] = { // RES 5,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.resetBit(5)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xAF] = { // RES 5,A
            self.regs.a.resetBit(5)
        }
        opcodes[0xB0] = { // RES 6,B
            self.regs.b.resetBit(6)
        }
        opcodes[0xB1] = { // RES 6,C
            self.regs.c.resetBit(6)
        }
        opcodes[0xB2] = { // RES 6,D
            self.regs.d.resetBit(6)
        }
        opcodes[0xB3] = { // RES 6,E
            self.regs.e.resetBit(6)
        }
        opcodes[0xB4] = { // RES 6,H
            self.regs.h.resetBit(6)
        }
        opcodes[0xB5] = { // RES 6,L
            self.regs.l.resetBit(6)
        }
        opcodes[0xB6] = { // RES 6,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.resetBit(6)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xB7] = { // RES 6,A
            self.regs.a.resetBit(6)
        }
        opcodes[0xB8] = { // RES 7,B
            self.regs.b.resetBit(7)
        }
        opcodes[0xB9] = { // RES 7,C
            self.regs.c.resetBit(7)
        }
        opcodes[0xBA] = { // RES 7,D
            self.regs.d.resetBit(7)
        }
        opcodes[0xBB] = { // RES 7,E
            self.regs.e.resetBit(7)
        }
        opcodes[0xBC] = { // RES 7,H
            self.regs.h.resetBit(7)
        }
        opcodes[0xBD] = { // RES 7,L
            self.regs.l.resetBit(7)
        }
        opcodes[0xBE] = { // RES 7,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.resetBit(7)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xBF] = { // RES 7,A
            self.regs.a.resetBit(7)
        }
        opcodes[0xC0] = { // SET 0,B
            self.regs.b.setBit(0)
        }
        opcodes[0xC1] = { // SET 0,C
            self.regs.c.setBit(0)
        }
        opcodes[0xC2] = { // SET 0,D
            self.regs.d.setBit(0)
        }
        opcodes[0xC3] = { // SET 0,E
            self.regs.e.setBit(0)
        }
        opcodes[0xC4] = { // SET 0,H
            self.regs.h.setBit(0)
        }
        opcodes[0xC5] = { // SET 0,L
            self.regs.l.setBit(0)
        }
        opcodes[0xC6] = { // SET 0,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.setBit(0)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xC7] = { // SET 0,A
            self.regs.a.setBit(0)
        }
        opcodes[0xC8] = { // SET 1,B
            self.regs.b.setBit(1)
        }
        opcodes[0xC9] = { // SET 1,C
            self.regs.c.setBit(1)
        }
        opcodes[0xCA] = { // SET 1,D
            self.regs.d.setBit(1)
        }
        opcodes[0xCB] = { // SET 1,E
            self.regs.e.setBit(1)
        }
        opcodes[0xCC] = { // SET 1,H
            self.regs.h.setBit(1)
        }
        opcodes[0xCD] = { // SET 1,L
            self.regs.l.setBit(1)
        }
        opcodes[0xCE] = { // SET 1,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.setBit(1)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xCF] = { // SET 1,A
            self.regs.a.setBit(1)
        }
        opcodes[0xD0] = { // SET 2,B
            self.regs.b.setBit(2)
        }
        opcodes[0xD1] = { // SET 2,C
            self.regs.c.setBit(2)
        }
        opcodes[0xD2] = { // SET 2,D
            self.regs.d.setBit(2)
        }
        opcodes[0xD3] = { // SET 2,E
            self.regs.e.setBit(2)
        }
        opcodes[0xD4] = { // SET 2,H
            self.regs.h.setBit(2)
        }
        opcodes[0xD5] = { // SET 2,L
            self.regs.l.setBit(2)
        }
        opcodes[0xD6] = { // SET 2,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.setBit(2)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xD7] = { // SET 2,A
            self.regs.a.setBit(2)
        }
        opcodes[0xD8] = { // SET 3,B
            self.regs.b.setBit(3)
        }
        opcodes[0xD9] = { // SET 3,C
            self.regs.c.setBit(3)
        }
        opcodes[0xDA] = { // SET 3,D
            self.regs.d.setBit(3)
        }
        opcodes[0xDB] = { // SET 3,E
            self.regs.e.setBit(3)
        }
        opcodes[0xDC] = { // SET 3,H
            self.regs.h.setBit(3)
        }
        opcodes[0xDD] = { // SET 3,L
            self.regs.l.setBit(3)
        }
        opcodes[0xDE] = { // SET 3,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.setBit(3)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xDF] = { // SET 3,A
            self.regs.a.setBit(3)
        }
        opcodes[0xE0] = { // SET 4,B
            self.regs.b.setBit(4)
        }
        opcodes[0xE1] = { // SET 4,C
            self.regs.c.setBit(4)
        }
        opcodes[0xE2] = { // SET 4,D
            self.regs.d.setBit(4)
        }
        opcodes[0xE3] = { // SET 4,E
            self.regs.e.setBit(4)
        }
        opcodes[0xE4] = { // SET 4,H
            self.regs.h.setBit(4)
        }
        opcodes[0xE5] = { // SET 4,L
            self.regs.l.setBit(4)
        }
        opcodes[0xE6] = { // SET 4,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.setBit(4)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xE7] = { // SET 4,A
            self.regs.a.setBit(4)
        }
        opcodes[0xE8] = { // SET 5,B
            self.regs.b.setBit(5)
        }
        opcodes[0xE9] = { // SET 5,C
            self.regs.c.setBit(5)
        }
        opcodes[0xEA] = { // SET 5,D
            self.regs.d.setBit(5)
        }
        opcodes[0xEB] = { // SET 5,E
            self.regs.e.setBit(5)
        }
        opcodes[0xEC] = { // SET 5,H
            self.regs.h.setBit(5)
        }
        opcodes[0xED] = { // SET 5,L
            self.regs.l.setBit(5)
        }
        opcodes[0xEE] = { // SET 5,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.setBit(5)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xEF] = { // SET 5,A
            self.regs.a.setBit(5)
        }
        opcodes[0xF0] = { // SET 6,B
            self.regs.b.setBit(6)
        }
        opcodes[0xF1] = { // SET 6,C
            self.regs.c.setBit(6)
        }
        opcodes[0xF2] = { // SET 6,D
            self.regs.d.setBit(6)
        }
        opcodes[0xF3] = { // SET 6,E
            self.regs.e.setBit(6)
        }
        opcodes[0xF4] = { // SET 6,H
            self.regs.h.setBit(6)
        }
        opcodes[0xF5] = { // SET 6,L
            self.regs.l.setBit(6)
        }
        opcodes[0xF6] = { // SET 6,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.setBit(6)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xF7] = { // SET 6,A
            self.regs.a.setBit(6)
        }
        opcodes[0xF8] = { // SET 7,B
            self.regs.b.setBit(7)
        }
        opcodes[0xF9] = { // SET 7,C
            self.regs.c.setBit(7)
        }
        opcodes[0xFA] = { // SET 7,D
            self.regs.d.setBit(7)
        }
        opcodes[0xFB] = { // SET 7,E
            self.regs.e.setBit(7)
        }
        opcodes[0xFC] = { // SET 7,H
            self.regs.h.setBit(7)
        }
        opcodes[0xFD] = { // SET 7,L
            self.regs.l.setBit(7)
        }
        opcodes[0xFE] = { // SET 7,(HL)
            self.clock.add(tCycles: 1)
            var data = self.dataBus.read(self.regs.hl)
            data.setBit(7)
            self.dataBus.write(self.regs.hl, value: data)
        }
        opcodes[0xFF] = { // SET 7,A
            self.regs.a.setBit(7)
        }
    }
}
