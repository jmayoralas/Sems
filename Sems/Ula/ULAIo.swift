//
//  UlaIO.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 9/6/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

final class ULAIo : BusComponent {
    let ulaDelegate: InternalUlaOperationDelegate
    
    init(delegate: InternalUlaOperationDelegate) {
        self.ulaDelegate = delegate
        super.init(base_address: 0xFE, block_size: 1)
    }
    
    override func read(_ address: UInt16) -> UInt8 {
        return ulaDelegate.ioRead(address)
    }
    
    override func write(_ address: UInt16, value: UInt8) {
        ulaDelegate.ioWrite(address, value: value)
    }
}
