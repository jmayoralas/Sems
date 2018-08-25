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
/*
        opcodes[0x09] = { // ADD xx,BC
            self.clock.add(tCycles: 7)
            self.regs.xx = self.aluCall16(self.regs.xx, self.regs.bc, ulaOp: .add)
        }
        opcodes[0x19] = { // ADD xx,DE
            self.clock.add(tCycles: 7)
            self.regs.xx = self.aluCall16(self.regs.xx, self.regs.de, ulaOp: .add)
        }
        opcodes[0x21] = { // LD xx,&0000
            self.regs.xx = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            self.regs.pc = self.regs.pc &+ 2
        }
        opcodes[0x22] = { // LD (&0000),xx
            let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            self.dataBus.write(address, value: self.regs.xxl)
            self.dataBus.write(address &+ 1, value: self.regs.xxh)
            self.regs.pc = self.regs.pc &+ 2
        }
        opcodes[0x23] = { // INC xx
            self.clock.add(tCycles: 2)
            self.regs.xx = self.regs.xx &+ 1
        }
        opcodes[0x24] = { // INC xxH
            self.regs.xxh = self.aluCall(self.regs.xxh, 1, ulaOp: .add, ignoreCarry: true)
        }
        opcodes[0x25] = { // DEC xxH
            self.regs.xxh = self.aluCall(self.regs.xxh, 1, ulaOp: .sub, ignoreCarry: true)
        }
        opcodes[0x26] = { // LD xxH,&00
            self.regs.xxh = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x29] = { // ADD xx,xx
            self.clock.add(tCycles: 7)
            self.regs.xx = self.aluCall16(self.regs.xx, self.regs.xx, ulaOp: .add)
        }
        opcodes[0x2A] = { // LD xx,(&0000)
            let address = self.addressFromPair(self.dataBus.read(self.regs.pc &+ 1), self.dataBus.read(self.regs.pc))
            self.regs.xx = self.addressFromPair(self.dataBus.read(address &+ 1), self.dataBus.read(address))
            self.regs.pc = self.regs.pc &+ 2
        }
        opcodes[0x2B] = { // DEC xx
            self.clock.add(tCycles: 2)
            self.regs.xx = self.regs.xx &- 1
        }
        opcodes[0x2C] = { // INC xxL
            self.regs.xxl = self.aluCall(self.regs.xxl, 1, ulaOp: .add, ignoreCarry: true)
        }
        opcodes[0x2D] = { // DEC xxL
            self.regs.xxl = self.aluCall(self.regs.xxl, 1, ulaOp: .sub, ignoreCarry: true)
        }
        opcodes[0x2E] = { // LD xxL,&00
            self.regs.xxl = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x34] = { // INC (xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            let data = self.aluCall(self.dataBus.read(address), 1, ulaOp: .add, ignoreCarry: true)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0x35] = { // DEC (xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            self.regs.pc = self.regs.pc &+ 1
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            let data = self.aluCall(self.dataBus.read(address), 1, ulaOp: .sub, ignoreCarry: true)
            self.clock.add(tCycles: 1)
            self.dataBus.write(address, value: data)
        }
        opcodes[0x36] = { // LD (xx+0),&00
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            let data = self.dataBus.read(self.regs.pc &+ 1)
            self.clock.add(tCycles: 2)
            self.dataBus.write(address, value: data)
            self.regs.pc = self.regs.pc &+ 2
        }
        opcodes[0x39] = { // ADD xx,SP
            self.clock.add(tCycles: 7)
            self.regs.xx = self.aluCall16(self.regs.xx, self.regs.sp, ulaOp: .add)
        }
        opcodes[0x44] = { // LD B,xxH
            self.regs.b = self.regs.xxh
        }
        opcodes[0x45] = { // LD B,xxL
            self.regs.b = self.regs.xxl
        }
        opcodes[0x46] = { // LD B,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.b = self.dataBus.read(address)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x4C] = { // LD C,xxH
            self.regs.c = self.regs.xxh
        }
        opcodes[0x4D] = { // LD C,xxL
            self.regs.c = self.regs.xxl
        }
        opcodes[0x4E] = { // LD C,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.c = self.dataBus.read(address)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x54] = { // LD D,xxH
            self.regs.d = self.regs.xxh
        }
        opcodes[0x55] = { // LD D,xxL
            self.regs.d = self.regs.xxl
        }
        opcodes[0x56] = { // LD D,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.d = self.dataBus.read(address)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x5C] = { // LD E,xxH
            self.regs.e = self.regs.xxh
        }
        opcodes[0x5D] = { // LD E,xxL
            self.regs.e = self.regs.xxl
        }
        opcodes[0x5E] = { // LD E,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.e = self.dataBus.read(address)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x60] = { // LD xxH,B
            self.regs.xxh = self.regs.b
        }
        opcodes[0x61] = { // LD xxH,C
            self.regs.xxh = self.regs.c
        }
        opcodes[0x62] = { // LD xxH,D
            self.regs.xxh = self.regs.d
        }
        opcodes[0x63] = { // LD xxH,E
            self.regs.xxh = self.regs.e
        }
        opcodes[0x64] = { // LD xxH,xxH
            self.regs.xxh = self.regs.xxh
        }
        opcodes[0x65] = { // LD xxH,xxL
            self.regs.xxh = self.regs.xxl
        }
        opcodes[0x66] = { // LD H,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.h = self.dataBus.read(address)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x67] = { // LD xxH,A
            self.regs.xxh = self.regs.a
        }
        opcodes[0x68] = { // LD xxL,B
            self.regs.xxl = self.regs.b
        }
        opcodes[0x69] = { // LD xxL,C
            self.regs.xxl = self.regs.c
        }
        opcodes[0x6A] = { // LD xxL,D
            self.regs.xxl = self.regs.d
        }
        opcodes[0x6B] = { // LD xxL,E
            self.regs.xxl = self.regs.e
        }
        opcodes[0x6C] = { // LD xxL,xxH
            self.regs.xxl = self.regs.xxh
        }
        opcodes[0x6D] = { // LD xxL,xxL
            self.regs.xxl = self.regs.xxl
        }
        opcodes[0x6E] = { // LD L,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.l = self.dataBus.read(address)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x6F] = { // LD xxL,A
            self.regs.xxl = self.regs.a
        }
        opcodes[0x70] = { // LD (xx+0),B
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.dataBus.write(address, value: self.regs.b)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x71] = { // LD (xx+0),C
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.dataBus.write(address, value: self.regs.c)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x72] = { // LD (xx+0),D
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.dataBus.write(address, value: self.regs.d)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x73] = { // LD (xx+0),E
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.dataBus.write(address, value: self.regs.e)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x74] = { // LD (xx+0),H
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.dataBus.write(address, value: self.regs.h)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x75] = { // LD (xx+0),L
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.dataBus.write(address, value: self.regs.l)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x77] = { // LD (xx+0),A
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.dataBus.write(address, value: self.regs.a)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x7C] = { // LD A,xxH
            self.regs.a = self.regs.xxh
        }
        opcodes[0x7D] = { // LD A,xxL
            self.regs.a = self.regs.xxl
        }
        opcodes[0x7E] = { // LD A,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.a = self.dataBus.read(address)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x84] = { // ADD A,xxH
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxh, ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x85] = { // ADD A,xxL
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxl, ulaOp: .add, ignoreCarry: false)
        }
        opcodes[0x86] = { // ADD A,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(address), ulaOp: .add, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x8C] = { // ADC A,xxH
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxh, ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x8D] = { // ADC A,xxL
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxl, ulaOp: .adc, ignoreCarry: false)
        }
        opcodes[0x8E] = { // ADC A,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(address), ulaOp: .adc, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x94] = { // SUB A,xxH
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxh, ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x95] = { // SUB A,xxL
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxl, ulaOp: .sub, ignoreCarry: false)
        }
        opcodes[0x96] = { // SUB A,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(address), ulaOp: .sub, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0x9C] = { // SBC A,xxH
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxh, ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0x9D] = { // SBC A,xxL
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxl, ulaOp: .sbc, ignoreCarry: false)
        }
        opcodes[0x9E] = { // SBC A,(xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(address), ulaOp: .sbc, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xA4] = { // AND xxH
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxh, ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA5] = { // AND xxL
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxl, ulaOp: .and, ignoreCarry: false)
        }
        opcodes[0xA6] = { // AND (xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(address), ulaOp: .and, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xAC] = { // XOR xxH
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxh, ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xAD] = { // XOR xxL
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxl, ulaOp: .xor, ignoreCarry: false)
        }
        opcodes[0xAE] = { // XOR (xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(address), ulaOp: .xor, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xB4] = { // OR xxH
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxh, ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB5] = { // OR xxL
            self.regs.a = self.aluCall(self.regs.a, self.regs.xxl, ulaOp: .or, ignoreCarry: false)
        }
        opcodes[0xB6] = { // OR (xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            self.regs.a = self.aluCall(self.regs.a, self.dataBus.read(address), ulaOp: .or, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xBC] = { // CP xxH
            let _ = self.aluCall(self.regs.a, self.regs.xxh, ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xBD] = { // CP xxL
            let _ = self.aluCall(self.regs.a, self.regs.xxl, ulaOp: .cp, ignoreCarry: false)
        }
        opcodes[0xBE] = { // CP (xx+0)
            let displ = self.dataBus.read(self.regs.pc)
            let address = self.addRelative(displacement: displ, toAddress: self.regs.xx)
            self.clock.add(tCycles: 5)
            let _ = self.aluCall(self.regs.a, self.dataBus.read(address), ulaOp: .cp, ignoreCarry: false)
            self.regs.pc = self.regs.pc &+ 1
        }
        opcodes[0xCB] = {
            self.id_opcode_table = table_XXCB
            self.regs.pc = self.regs.pc &+ 1
            self.processInstruction()
        }
        opcodes[0xE1] = { // POP xx
            self.regs.xxl = self.dataBus.read(self.regs.sp)
            self.regs.xxh = self.dataBus.read(self.regs.sp &+ 1)
            self.regs.sp = self.regs.sp &+ 2
        }
        opcodes[0xE3] = { // EX (SP), xx
            let lsb = self.dataBus.read(self.regs.sp)
            let msb = self.dataBus.read(self.regs.sp &+ 1)
            self.clock.add(tCycles: 1)
            
            let data = self.addressFromPair(msb, lsb)
            self.dataBus.write(self.regs.sp, value: self.regs.xxl)
            self.dataBus.write(self.regs.sp &+ 1, value: self.regs.xxh)
            self.clock.add(tCycles: 2)

            self.regs.xx = data
        }
        opcodes[0xE5] = { // PUSH xx
            self.clock.add(tCycles: 1)
            self.dataBus.write(self.regs.sp &- 1, value: self.regs.xxh)
            self.dataBus.write(self.regs.sp &- 2, value: self.regs.xxl)
            self.regs.sp = self.regs.sp &- 2
        }
        opcodes[0xE9] = { // JP (xx)
            self.regs.pc = self.regs.xx
        }
        opcodes[0xF9] = { // LD SP,xx
            self.clock.add(tCycles: 2)
            self.regs.sp = self.regs.xx
        }
*/
    }
 }
