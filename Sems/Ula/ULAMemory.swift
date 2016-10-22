//
//  UlaMemory.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 9/6/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

final class ULAMemory : Ram {
    let ulaDelegate: InternalUlaOperationDelegate
    
    init(delegate: InternalUlaOperationDelegate) {
        self.ulaDelegate = delegate
        super.init(base_address: 0x4000, block_size: 0x4000)
    }
    
    override func write(_ address: UInt16, value: UInt8) {
        super.write(address, value: value)
        self.ulaDelegate.memoryWrite(address, value: value)
    }
    
    override func read(_ address: UInt16) -> UInt8 {
        self.ulaDelegate.memoryRead()
        return super.read(address)
    }
}
