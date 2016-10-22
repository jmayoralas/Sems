//
//  extensions.swift
//  			
//
//  Created by Jose Luis Fernandez-Mayoralas on 11/9/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation

public extension UInt16 {
    func hexStr() -> String {
        return (String(NSString(format:"%04X", self)))
    }
    
    var high: UInt8 {
        return UInt8(self / 0x100)
    }
    
    var low: UInt8 {
        return UInt8(self % 0x100)
    }
}

public extension UInt8 {
    var parity: Int {
        return Int(self & 1 + self >> 1 & 1 + self >> 2 & 1 + self >> 3 & 1 + self >> 4 & 1 + self >> 5 & 1 + self >> 6 & 1 + self >> 7 & 1) & 1
    }

    var comp2: Int {
        return self > 0x7F ? Int(Int(self) - 0xFF - 1) : Int(self)
    }
    
    func hexStr() -> String {
        return (String(NSString(format:"%02X", self)))
    }
    
    var binStr: String {
        var result = String(self, radix: 2)
        if result.characters.count < 8 {
            for _ in 0 ... 7 - result.characters.count {
                result.insert("0", at: result.startIndex)
            }
        }
        return result
    }
    
    mutating func bit(_ index: Int, newVal: Int) {
        if newVal == 1 { self.setBit(index) } else { self.resetBit(index) }
    }
    
    func bit(_ index: Int) -> Int {
        return (Int(self) >> index) & 0x01
    }
    
    mutating func setBit(_ index: Int) {
        self = self | UInt8(1 << index)
    }
    
    mutating func resetBit(_ index: Int) {
        self = self & ~UInt8(1 << index)
    }
    
    var high: UInt8 {
        return self & 0b11110000
    }
    
    var low: UInt8 {
        return self & 0b00001111
    }
}

public extension String {
    var binaryToDecimal: Int {
        return Int(strtoul(self, nil, 2))
    }
}
