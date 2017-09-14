//
//  ControlUnit_opcodes_ddcb.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 22/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

// t_cycle = 12 ((DD)4, (CB)4, (Op)4,...)

extension Z80 {
    func initOpcodeTableXXCB(_ opcodes: inout OpcodeTable) {
        opcodes[0x00] = { // rlc (xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.b = self.aluCall(data, 1, ulaOp: .rlc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x01] = { // rlc (xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.c = self.aluCall(data, 1, ulaOp: .rlc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x02] = { // rlc (xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.d = self.aluCall(data, 1, ulaOp: .rlc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x03] = { // rlc (xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.e = self.aluCall(data, 1, ulaOp: .rlc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x04] = { // rlc (xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.h = self.aluCall(data, 1, ulaOp: .rlc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x05] = { // rlc (xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.l = self.aluCall(data, 1, ulaOp: .rlc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x06] = { // RLC (xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.dataBus.write(address, value: self.aluCall(self.dataBus.read(address), 1, ulaOp: .rlc, ignoreCarry: false))
        }
        opcodes[0x07] = { // rlc (xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.a = self.aluCall(data, 1, ulaOp: .rlc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x08] = { // rrc (xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            let data = self.dataBus.read(address)
            self.regs.b = self.aluCall(data, 1, ulaOp: .rrc, ignoreCarry: false)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x09] = { // rrc (xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.c = self.aluCall(data, 1, ulaOp: .rrc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x0A] = { // rrc (xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            let data = self.dataBus.read(address)
            self.regs.d = self.aluCall(data, 1, ulaOp: .rrc, ignoreCarry: false)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x0B] = { // rrc (xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.e = self.aluCall(data, 1, ulaOp: .rrc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x0C] = { // rrc (xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.h = self.aluCall(data, 1, ulaOp: .rrc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x0D] = { // rrc (xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.l = self.aluCall(data, 1, ulaOp: .rrc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x0E] = { // RRC (xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.aluCall(data, 1, ulaOp: .rrc, ignoreCarry: false))
        }
        opcodes[0x0F] = { // rrc (xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.a = self.aluCall(data, 1, ulaOp: .rrc, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x10] = { // rl (xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.b = self.aluCall(data, 1, ulaOp: .rl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x11] = { // rl (xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.c = self.aluCall(data, 1, ulaOp: .rl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x12] = { // rl (xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.d = self.aluCall(data, 1, ulaOp: .rl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x13] = { // rl (xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.e = self.aluCall(data, 1, ulaOp: .rl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x14] = { // rl (xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            let data = self.dataBus.read(address)
            self.regs.h = self.aluCall(data, 1, ulaOp: .rl, ignoreCarry: false)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x15] = { // rl (xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.l = self.aluCall(data, 1, ulaOp: .rl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x16] = { // RL (xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.aluCall(data, 1, ulaOp: .rl, ignoreCarry: false))
        }
        opcodes[0x17] = { // rl (xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.a = self.aluCall(data, 1, ulaOp: .rl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x18] = { // rr (xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.b = self.aluCall(data, 1, ulaOp: .rr, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x19] = { // rr (xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.c = self.aluCall(data, 1, ulaOp: .rr, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x1A] = { // rr (xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.d = self.aluCall(data, 1, ulaOp: .rr, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x1B] = { // rr (xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.e = self.aluCall(data, 1, ulaOp: .rr, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x1C] = { // rr (xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.h = self.aluCall(data, 1, ulaOp: .rr, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x1D] = { // rr (xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.l = self.aluCall(data, 1, ulaOp: .rr, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x1E] = { // RLC (xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.aluCall(data, 1, ulaOp: .rr, ignoreCarry: false))
        }
        opcodes[0x1F] = { // rr (xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.a = self.aluCall(data, 1, ulaOp: .rr, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x20] = { // sla (xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.b = self.aluCall(data, 1, ulaOp: .sla, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x21] = { // sla (xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.c = self.aluCall(data, 1, ulaOp: .sla, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x22] = { // sla (xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.d = self.aluCall(data, 1, ulaOp: .sla, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x23] = { // sla (xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.e = self.aluCall(data, 1, ulaOp: .sla, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x24] = { // sla (xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.h = self.aluCall(data, 1, ulaOp: .sla, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x25] = { // sla (xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.l = self.aluCall(data, 1, ulaOp: .sla, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x26] = { // SLA (xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.aluCall(data, 1, ulaOp: .sla, ignoreCarry: false))
        }
        opcodes[0x27] = { // sla (xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.a = self.aluCall(data, 1, ulaOp: .sla, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x28] = { // sra (xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.b = self.aluCall(data, 1, ulaOp: .sra, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x29] = { // sra (xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.c = self.aluCall(data, 1, ulaOp: .sra, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x2A] = { // sra (xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.d = self.aluCall(data, 1, ulaOp: .sra, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x2B] = { // sra (xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.e = self.aluCall(data, 1, ulaOp: .sra, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x2C] = { // sra (xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.h = self.aluCall(data, 1, ulaOp: .sra, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x2D] = { // sra (xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.l = self.aluCall(data, 1, ulaOp: .sra, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x2E] = { // SRA (xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.aluCall(data, 1, ulaOp: .sra, ignoreCarry: false))
        }
        opcodes[0x2F] = { // sra (xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.a = self.aluCall(data, 1, ulaOp: .sra, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x30] = { // sls (xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.b = self.aluCall(data, 1, ulaOp: .sls, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x31] = { // sls (xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.c = self.aluCall(data, 1, ulaOp: .sls, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x32] = { // sls (xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.d = self.aluCall(data, 1, ulaOp: .sls, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x33] = { // sls (xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.e = self.aluCall(data, 1, ulaOp: .sls, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x34] = { // sls (xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.h = self.aluCall(data, 1, ulaOp: .sls, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x35] = { // sls (xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.l = self.aluCall(data, 1, ulaOp: .sls, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x36] = { // SLS (xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.aluCall(data, 1, ulaOp: .sls, ignoreCarry: false))
        }
        opcodes[0x37] = { // sls (xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.a = self.aluCall(data, 1, ulaOp: .sls, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x38] = { // srl (xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.b = self.aluCall(data, 1, ulaOp: .srl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x39] = { // srl (xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.c = self.aluCall(data, 1, ulaOp: .srl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x3A] = { // srl (xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.d = self.aluCall(data, 1, ulaOp: .srl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x3B] = { // srl (xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.e = self.aluCall(data, 1, ulaOp: .srl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x3C] = { // srl (xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.h = self.aluCall(data, 1, ulaOp: .srl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x3D] = { // srl (xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.l = self.aluCall(data, 1, ulaOp: .srl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x3E] = { // SRL (xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.aluCall(data, 1, ulaOp: .srl, ignoreCarry: false))
        }
        opcodes[0x3F] = { // srl (xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let data = self.dataBus.read(address)
            self.regs.a = self.aluCall(data, 1, ulaOp: .srl, ignoreCarry: false)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x40] = { // bit 0,(xx+0) -> b
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x41] = { // bit 0,(xx+0) -> c
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x42] = { // bit 0,(xx+0) -> d
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x43] = { // bit 0,(xx+0) -> e
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x44] = { // bit 0,(xx+0) -> h
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x45] = { // bit 0,(xx+0) -> l
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x46] = { // BIT 0,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let _ = self.aluCall(self.dataBus.read(address), 0, ulaOp: .bit, ignoreCarry: false)
            self.clock.add(tCycles: 1)
        }
        opcodes[0x47] = { // bit 0,(xx+0) -> a
            self.opcode_tables[self.id_opcode_table][0x46]()
        }
        opcodes[0x48] = { // bit 1,(xx+0) -> b
            self.opcode_tables[self.id_opcode_table][0x4E]()
        }
        opcodes[0x49] = { // bit 1,(xx+0) -> c
            self.opcode_tables[self.id_opcode_table][0x4E]()
        }
        opcodes[0x4A] = { // bit 1,(xx+0) -> d
            self.opcode_tables[self.id_opcode_table][0x4E]()
        }
        opcodes[0x4B] = { // bit 1,(xx+0) -> e
            self.opcode_tables[self.id_opcode_table][0x4E]()
        }
        opcodes[0x4C] = { // bit 1,(xx+0) -> h
            self.opcode_tables[self.id_opcode_table][0x4E]()
        }
        opcodes[0x4D] = { // bit 1,(xx+0) -> l
            self.opcode_tables[self.id_opcode_table][0x4E]()
        }
        opcodes[0x4E] = { // BIT 1,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let _ = self.aluCall(self.dataBus.read(address), 1, ulaOp: .bit, ignoreCarry: false)
            self.clock.add(tCycles: 1)
        }
        opcodes[0x4F] = { // bit 1,(xx+0) -> a
            self.opcode_tables[self.id_opcode_table][0x4E]()
        }
        opcodes[0x50] = { // bit 2,(xx+0) -> b
            self.opcode_tables[self.id_opcode_table][0x56]()
        }
        opcodes[0x51] = { // bit 2,(xx+0) -> c
            self.opcode_tables[self.id_opcode_table][0x56]()
        }
        opcodes[0x52] = { // bit 2,(xx+0) -> d
            self.opcode_tables[self.id_opcode_table][0x56]()
        }
        opcodes[0x53] = { // bit 2,(xx+0) -> e
            self.opcode_tables[self.id_opcode_table][0x56]()
        }
        opcodes[0x54] = { // bit 2,(xx+0) -> h
            self.opcode_tables[self.id_opcode_table][0x56]()
        }
        opcodes[0x55] = { // bit 2,(xx+0) -> l
            self.opcode_tables[self.id_opcode_table][0x56]()
        }
        opcodes[0x56] = { // BIT 2,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let _ = self.aluCall(self.dataBus.read(address), 2, ulaOp: .bit, ignoreCarry: false)
            self.clock.add(tCycles: 1)
        }
        opcodes[0x57] = { // bit 2,(xx+0) -> a
            self.opcode_tables[self.id_opcode_table][0x56]()
        }
        opcodes[0x58] = { // bit 3,(xx+0) -> b
            self.opcode_tables[self.id_opcode_table][0x5E]()
        }
        opcodes[0x59] = { // bit 3,(xx+0) -> c
            self.opcode_tables[self.id_opcode_table][0x5E]()
        }
        opcodes[0x5A] = { // bit 3,(xx+0) -> d
            self.opcode_tables[self.id_opcode_table][0x5E]()
        }
        opcodes[0x5B] = { // bit 3,(xx+0) -> e
            self.opcode_tables[self.id_opcode_table][0x5E]()
        }
        opcodes[0x5C] = { // bit 3,(xx+0) -> h
            self.opcode_tables[self.id_opcode_table][0x5E]()
        }
        opcodes[0x5D] = { // bit 3,(xx+0) -> l
            self.opcode_tables[self.id_opcode_table][0x5E]()
        }
        opcodes[0x5E] = { // BIT 3,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let _ = self.aluCall(self.dataBus.read(address), 3, ulaOp: .bit, ignoreCarry: false)
            self.clock.add(tCycles: 1)
        }
        opcodes[0x5F] = { // bit 3,(xx+0) -> a
            self.opcode_tables[self.id_opcode_table][0x5E]()
        }
        opcodes[0x60] = { // bit 4,(xx+0) -> b
            self.opcode_tables[self.id_opcode_table][0x66]()
        }
        opcodes[0x61] = { // bit 4,(xx+0) -> c
            self.opcode_tables[self.id_opcode_table][0x66]()
        }
        opcodes[0x62] = { // bit 4,(xx+0) -> d
            self.opcode_tables[self.id_opcode_table][0x66]()
        }
        opcodes[0x63] = { // bit 4,(xx+0) -> e
            self.opcode_tables[self.id_opcode_table][0x66]()
        }
        opcodes[0x64] = { // bit 4,(xx+0) -> h
            self.opcode_tables[self.id_opcode_table][0x66]()
        }
        opcodes[0x65] = { // bit 4,(xx+0) -> l
            self.opcode_tables[self.id_opcode_table][0x66]()
        }
        opcodes[0x66] = { // BIT 4,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let _ = self.aluCall(self.dataBus.read(address), 4, ulaOp: .bit, ignoreCarry: false)
            self.clock.add(tCycles: 1)
        }
        opcodes[0x67] = { // bit 4,(xx+0) -> a
            self.opcode_tables[self.id_opcode_table][0x66]()
        }
        opcodes[0x68] = { // bit 5,(xx+0) -> b
            self.opcode_tables[self.id_opcode_table][0x6E]()
        }
        opcodes[0x69] = { // bit 5,(xx+0) -> c
            self.opcode_tables[self.id_opcode_table][0x6E]()
        }
        opcodes[0x6A] = { // bit 5,(xx+0) -> d
            self.opcode_tables[self.id_opcode_table][0x6E]()
        }
        opcodes[0x6B] = { // bit 5,(xx+0) -> e
            self.opcode_tables[self.id_opcode_table][0x6E]()
        }
        opcodes[0x6C] = { // bit 5,(xx+0) -> h
            self.opcode_tables[self.id_opcode_table][0x6E]()
        }
        opcodes[0x6D] = { // bit 5,(xx+0) -> l
            self.opcode_tables[self.id_opcode_table][0x6E]()
        }
        opcodes[0x6E] = { // BIT 5,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let _ = self.aluCall(self.dataBus.read(address), 5, ulaOp: .bit, ignoreCarry: false)
            self.clock.add(tCycles: 1)
        }
        opcodes[0x6F] = { // bit 5,(xx+0) -> a
            self.opcode_tables[self.id_opcode_table][0x6E]()
        }
        opcodes[0x70] = { // bit 6,(xx+0) -> b
            self.opcode_tables[self.id_opcode_table][0x76]()
        }
        opcodes[0x71] = { // bit 6,(xx+0) -> c
            self.opcode_tables[self.id_opcode_table][0x76]()
        }
        opcodes[0x72] = { // bit 6,(xx+0) -> d
            self.opcode_tables[self.id_opcode_table][0x76]()
        }
        opcodes[0x73] = { // bit 6,(xx+0) -> e
            self.opcode_tables[self.id_opcode_table][0x76]()
        }
        opcodes[0x74] = { // bit 6,(xx+0) -> h
            self.opcode_tables[self.id_opcode_table][0x76]()
        }
        opcodes[0x75] = { // bit 6,(xx+0) -> l
            self.opcode_tables[self.id_opcode_table][0x76]()
        }
        opcodes[0x76] = { // BIT 6,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let _ = self.aluCall(self.dataBus.read(address), 6, ulaOp: .bit, ignoreCarry: false)
            self.clock.add(tCycles: 1)
        }
        opcodes[0x77] = { // bit 6,(xx+0) -> a
            self.opcode_tables[self.id_opcode_table][0x76]()
        }
        opcodes[0x78] = { // bit 7,(xx+0) -> b
            self.opcode_tables[self.id_opcode_table][0x7E]()
        }
        opcodes[0x79] = { // bit 7,(xx+0) -> c
            self.opcode_tables[self.id_opcode_table][0x7E]()
        }
        opcodes[0x7A] = { // bit 7,(xx+0) -> d
            self.opcode_tables[self.id_opcode_table][0x7E]()
        }
        opcodes[0x7B] = { // bit 7,(xx+0) -> e
            self.opcode_tables[self.id_opcode_table][0x7E]()
        }
        opcodes[0x7C] = { // bit 7,(xx+0) -> h
            self.opcode_tables[self.id_opcode_table][0x7E]()
        }
        opcodes[0x7D] = { // bit 7,(xx+0) -> l
            self.opcode_tables[self.id_opcode_table][0x7E]()
        }
        opcodes[0x7E] = { // BIT 7,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            let _ = self.aluCall(self.dataBus.read(address), 7, ulaOp: .bit, ignoreCarry: false)
            self.clock.add(tCycles: 1)
        }
        opcodes[0x7F] = { // bit 7,(xx+0) -> a
            self.opcode_tables[self.id_opcode_table][0x7E]()
        }
        opcodes[0x80] = { // res 0,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.resetBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x81] = { // res 0,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.resetBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x82] = { // res 0,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.resetBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x83] = { // res 0,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.resetBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x84] = { // res 0,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.resetBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x85] = { // res 0,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.resetBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x86] = { // RES 0,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.resetBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0x87] = { // res 0,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.resetBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x88] = { // res 1,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.resetBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x89] = { // res 1,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.resetBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x8A] = { // res 1,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.resetBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x8B] = { // res 1,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.resetBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x8C] = { // res 1,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.resetBit(1)
            self.clock.add(tCycles: 2)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x8D] = { // res 1,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.resetBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x8E] = { // RES 1,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.resetBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0x8F] = { // res 1,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.resetBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x90] = { // res 2,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.resetBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x91] = { // res 2,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.resetBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x92] = { // res 2,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.resetBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x93] = { // res 2,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.resetBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x94] = { // res 2,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.resetBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x95] = { // res 2,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.resetBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x96] = { // RES 2,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.resetBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0x97] = { // res 2,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.resetBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0x98] = { // res 3,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.resetBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0x99] = { // res 3,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.resetBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0x9A] = { // res 3,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.resetBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0x9B] = { // res 3,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.resetBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0x9C] = { // res 3,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.resetBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0x9D] = { // res 3,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.resetBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0x9E] = { // RES 3,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.resetBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0x9F] = { // res 3,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.resetBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xA0] = { // res 4,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.resetBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xA1] = { // res 4,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.resetBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xA2] = { // res 4,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.resetBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xA3] = { // res 4,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.resetBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xA4] = { // res 4,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.resetBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xA5] = { // res 4,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.resetBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xA6] = { // RES 4,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.resetBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xA7] = { // res 4,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.resetBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xA8] = { // res 5,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.resetBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xA9] = { // res 5,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.resetBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xAA] = { // res 5,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.resetBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xAB] = { // res 5,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.resetBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xAC] = { // res 5,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.resetBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xAD] = { // res 5,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.resetBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xAE] = { // RES 5,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.resetBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xAF] = { // res 5,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.resetBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xB0] = { // res 6,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.resetBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xB1] = { // res 6,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.resetBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xB2] = { // res 6,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.resetBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xB3] = { // res 6,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.resetBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xB4] = { // res 6,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.resetBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xB5] = { // res 6,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.resetBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xB6] = { // RES 6,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.resetBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xB7] = { // res 6,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.resetBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xB8] = { // res 7,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.resetBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xB9] = { // res 7,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.resetBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xBA] = { // res 7,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.resetBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xBB] = { // res 7,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.resetBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xBC] = { // res 7,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.resetBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xBD] = { // res 7,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.resetBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xBE] = { // RES 7,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.resetBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xBF] = { // res 7,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.resetBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xC0] = { // set 0,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.setBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xC1] = { // set 0,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.setBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xC2] = { // set 0,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.setBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xC3] = { // set 0,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.setBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xC4] = { // set 0,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.setBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xC5] = { // set 0,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.setBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xC6] = { // set 0,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.setBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xC7] = { // set 0,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.setBit(0)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xC8] = { // set 1,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.setBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xC9] = { // set 1,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.setBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xCA] = { // set 1,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.setBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xCB] = { // set 1,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.setBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xCC] = { // set 1,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.setBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xCD] = { // set 1,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.setBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xCE] = { // set 1,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.setBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xCF] = { // set 1,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.setBit(1)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xD0] = { // set 2,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.setBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xD1] = { // set 2,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.setBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xD2] = { // set 2,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.setBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xD3] = { // set 2,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.setBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xD4] = { // set 2,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.setBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xD5] = { // set 2,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.setBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xD6] = { // set 2,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.setBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xD7] = { // set 2,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.setBit(2)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xD8] = { // set 3,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.setBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xD9] = { // set 3,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.setBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xDA] = { // set 3,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.setBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xDB] = { // set 3,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.setBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xDC] = { // set 3,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.setBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xDD] = { // set 3,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.setBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xDE] = { // set 3,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.setBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xDF] = { // set 3,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.setBit(3)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xE0] = { // set 4,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.setBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xE1] = { // set 4,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.setBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xE2] = { // set 4,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.setBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xE3] = { // set 4,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.setBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xE4] = { // set 4,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.setBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xE5] = { // set 4,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.setBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xE6] = { // set 4,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.setBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xE7] = { // set 4,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.setBit(4)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xE8] = { // set 5,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.setBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xE9] = { // set 5,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.setBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xEA] = { // set 5,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.setBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xEB] = { // set 5,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.setBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xEC] = { // set 5,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.setBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xED] = { // set 5,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.setBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xEE] = { // set 5,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.setBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xEF] = { // set 5,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.setBit(5)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xF0] = { // set 6,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.setBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xF1] = { // set 6,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.setBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xF2] = { // set 6,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.setBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xF3] = { // set 6,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.setBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xF4] = { // set 6,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.setBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xF5] = { // set 6,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.setBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xF6] = { // set 6,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.setBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xF7] = { // set 6,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.setBit(6)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }
        opcodes[0xF8] = { // set 7,(xx+0) -> b
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.b = self.dataBus.read(address)
            self.regs.b.setBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.b)
        }
        opcodes[0xF9] = { // set 7,(xx+0) -> c
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.c = self.dataBus.read(address)
            self.regs.c.setBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.c)
        }
        opcodes[0xFA] = { // set 7,(xx+0) -> d
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.d = self.dataBus.read(address)
            self.regs.d.setBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.d)
        }
        opcodes[0xFB] = { // set 7,(xx+0) -> e
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.e = self.dataBus.read(address)
            self.regs.e.setBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.e)
        }
        opcodes[0xFC] = { // set 7,(xx+0) -> h
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.h = self.dataBus.read(address)
            self.regs.h.setBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.h)
        }
        opcodes[0xFD] = { // set 7,(xx+0) -> l
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.l = self.dataBus.read(address)
            self.regs.l.setBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.l)
        }
        opcodes[0xFE] = { // set 7,(xx+0)
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            var data = self.dataBus.read(address)
            data.setBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0xFF] = { // set 7,(xx+0) -> a
            self.clock.sub(tCycles: 1)
            let displ = self.dataBus.read(self.regs.pc &- 2)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 2)
            self.regs.a = self.dataBus.read(address)
            self.regs.a.setBit(7)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: self.regs.a)
        }

    }
}
