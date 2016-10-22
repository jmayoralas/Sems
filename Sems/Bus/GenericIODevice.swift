//
//  GenericIODevice.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 23/5/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

final class GenericIODevice: BusComponent {
    override func read(_ address: UInt16) -> UInt8 {
        return 0x01
    }
}
