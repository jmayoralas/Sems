//
//  BusComponent.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 1/5/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

class BusComponent : BusComponentBase {
    var base_address : UInt16
    var block_size : Int
    
    init(base_address: UInt16, block_size: Int) {
        self.base_address = base_address
        self.block_size = block_size
    }
    
    // high impedance read
    func read() -> UInt8 {
        return 0xFF
    }
    
    func read(_ address: UInt16) -> UInt8 {
        return read()
    }
    
    func write(_ address: UInt16, value: UInt8) {
    }
    
    func dumpFromAddress(_ fromAddress: Int, count: Int) -> [UInt8] {
        return Array(repeating: UInt8(0xFF), count: count)
    }
}
