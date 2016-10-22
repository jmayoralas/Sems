//
//  types.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 6/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

public struct Registers {
    // Instruction Registers
    public var ir: UInt8 = 0xFF
    public var ir_: UInt8 = 0xFF
    
    // Main Register Set
    // accumulator
    public var a: UInt8 = 0xFF
    public var b: UInt8 = 0xFF
    public var d: UInt8 = 0xFF
    public var h: UInt8 = 0xFF
    
    // flags
    public var f: UInt8 = 0xFF
    public var c: UInt8 = 0xFF
    public var e: UInt8 = 0xFF
    public var l: UInt8 = 0xFF
    
    // Interrupt Vector
    public var i: UInt8 = 0xFF
    
    // Memory Refresh
    public var r: UInt8 = 0xFF
    
    // Index Registers
    public var ixh: UInt8 = 0xFF
    public var ixl: UInt8 = 0xFF
    public var iyh: UInt8 = 0xFF
    public var iyl: UInt8 = 0xFF
    public var xxh: UInt8 = 0xFF
    public var xxl: UInt8 = 0xFF

    // 16 bit registers
    // primary
    var af: UInt16 {
        get {
            return UInt16(Int(Int(self.a) * 0x100) + Int(self.f))
        }
        set(newValue) {
            self.a = newValue.high
            self.f = newValue.low
        }
    }

    var bc: UInt16 {
        get {
            return UInt16(Int(Int(self.b) * 0x100) + Int(self.c))
        }
        set(newValue) {
            self.b = newValue.high
            self.c = newValue.low
        }
    }

    var hl: UInt16 {
        get {
            return UInt16(Int(Int(self.h) * 0x100) + Int(self.l))
        }
        set(newValue) {
            self.h = newValue.high
            self.l = newValue.low
        }
    }

    var de: UInt16 {
        get {
            return UInt16(Int(Int(self.d) * 0x100) + Int(self.e))
        }
        set(newValue) {
            self.d = newValue.high
            self.e = newValue.low
        }
    }
    
    // Alternate Register Set
    // accumulator
    public var af_: UInt16 = 0xFFFF
    public var bc_: UInt16 = 0xFFFF
    public var de_: UInt16 = 0xFFFF
    public var hl_: UInt16 = 0xFFFF
    
    // index
    var xx: UInt16 {
        get {
            return UInt16(Int(Int(self.xxh) * 0x100) + Int(self.xxl))
        }
        set(newValue) {
            self.xxh = newValue.high
            self.xxl = newValue.low
        }
    }
    
    var ix: UInt16 {
        get {
            return UInt16(Int(Int(self.ixh) * 0x100) + Int(self.ixl))
        }
        set(newValue) {
            self.ixh = newValue.high
            self.ixl = newValue.low
        }
    }
    
    var iy: UInt16 {
        get {
            return UInt16(Int(Int(self.iyh) * 0x100) + Int(self.iyl))
        }
        set(newValue) {
            self.iyh = newValue.high
            self.iyl = newValue.low
        }
    }
    
    // Stack Pointer
    public var sp: UInt16 = 0xFFFF
    
    // Program Counter
    public var pc: UInt16 = 0
    
    // Internal software-controlled interrupt enable
    public var IFF1 : Bool = false
    public var IFF2 : Bool = false

    public var int_mode : Int = 0
    
    // undocumented register for flag affection of scf/ccf opcodes
    public var q : UInt8 = 0
}

enum UlaOp {
    case add, adc, cp, sub, sbc, and, or, xor, rlc, rrc, rl, rr, sla, sra, sll, srl, sls, bit
}

public enum Z80Error : Error {
    case zeroBytesReadFromMemory
    case zeroBytesWriteToMemory
}

let S = 7
let Z = 6
let H = 4
let PV = 2
let N = 1
let C = 0

// id opcode table
let table_NONE = 0
let table_XX = 1
let table_CB = 2
let table_XXCB = 3
let table_ED = 4
