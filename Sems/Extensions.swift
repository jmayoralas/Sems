//
//  Extensions.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 2/11/18.
//  Copyright © 2018 LomoCorp. All rights reserved.
//

import Foundation

extension UInt16 {
    var high: UInt8 {
        return UInt8(self >> 8)
    }
    
    var low: UInt8 {
        return UInt8(self & 0x00FF)
    }
}

extension UInt8 {
    func bit(_ index: Int) -> Int {
        return (Int(self) >> index) & 0x01
    }
    
    func hexStr() -> String {
        return (String(NSString(format:"%02X", self)))
    }
    
    mutating func bit(_ index: Int, newVal: Int) {
        if newVal == 1 { self.setBit(index) } else { self.resetBit(index) }
    }
    
    mutating func setBit(_ index: Int) {
        self = self | UInt8(1 << index)
    }
    
    mutating func resetBit(_ index: Int) {
        self = self & ~UInt8(1 << index)
    }
}
