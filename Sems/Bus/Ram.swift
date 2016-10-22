//
//  Ram.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 1/5/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

protocol MemoryProtocol : class, BusComponentBase {
    var buffer: [UInt8] { get set }
}

extension MemoryProtocol {
    func dumpFromAddress(_ fromAddress: Int, count: Int) -> [UInt8] {
        let topAddress = Int(self.base_address) + self.block_size - 1
        
        let myFromAddress = (fromAddress < 0 ? 0 : fromAddress) - Int(self.base_address)
        var myToAddress = fromAddress + (count > buffer.count ? buffer.count : count) - 1 - Int(self.base_address)
        myToAddress = myToAddress > topAddress ? topAddress : myToAddress
        
        return Array(buffer[myFromAddress...myToAddress])
    }
}

class Ram : MemoryProtocol {
    var buffer : [UInt8]
    var base_address: UInt16
    var block_size: Int
    
    init(base_address: UInt16, block_size: Int) {
        self.base_address = base_address
        self.block_size = block_size
        buffer = Array(repeating: 0x00, count: block_size)
    }
    
    func write(_ address: UInt16, value: UInt8) {
        buffer[Int(address) - Int(self.base_address)] = value
    }
    
    func read(_ address: UInt16) -> UInt8 {
        return buffer[Int(address) - Int(base_address)]
    }
}
