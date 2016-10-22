//
//  BusComponentBase.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 30/4/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//
// Inspired by EfePuntoMarcos ( https://efepuntomarcos.wordpress.com ) as seen on his great tutorial
//
// Hazte un Spectrum ( https://efepuntomarcos.wordpress.com/2012/08/27/hazte-un-spectrum-1-parte/ )

import Foundation

protocol BusComponentBase: class {
    var base_address : UInt16 { get set }
    var block_size : Int { get set }
    
    func getBaseAddress() -> UInt16
    func getBlockSize() -> Int
    func read(_ address: UInt16) -> UInt8
    func write(_ address: UInt16, value: UInt8)
    func dumpFromAddress(_ fromAddress: Int, count: Int) -> [UInt8]
}

extension BusComponentBase {
    func getBaseAddress() -> UInt16 {
        return self.base_address
    }
    
    func getBlockSize() -> Int {
        return self.block_size
    }
}
