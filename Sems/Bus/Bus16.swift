//
//  Bus.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 1/5/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

final class Bus16 : BusBase {
    private var paged_components : [BusComponentBase]
    private var clock: Clock
    
    init(clock: Clock) {
        self.clock = clock
        
        let dummy_component = BusComponent(base_address: 0x0000, block_size: 0x0000)
        paged_components = Array(repeating: dummy_component, count: 64)
        
        super.init(base_address: 0x0000, block_size: 0x10000)
    }
    
    override func addBusComponent(_ bus_component: BusComponentBase) {
        super.addBusComponent(bus_component)

        for component in self.bus_components {
            let start = Int(component.getBaseAddress() / 1024)
            let end = start + component.getBlockSize() / 1024 - 1
            
            for i in start...end {
                paged_components[i] = component
            }
        }
    }
    
    override func write(_ address: UInt16, value: UInt8) {
        let index_component = Int(address) / 1024
        paged_components[index_component].write(address, value: value)
        
        clock.add(tCycles: 3)
        
        super.write(address, value: value)
    }
    
    override func read(_ address: UInt16) -> UInt8 {
        let _ = super.read(address)
        let index_component = (Int(address) & 0xFFFF) / 1024
        
        let data = paged_components[index_component].read(address)
        
        clock.add(tCycles: 3)
        
        return data
    }
    
    override func dumpFromAddress(_ fromAddress: Int, count: Int) -> [UInt8] {
        var index_component = (fromAddress & 0xFFFF) / 1024
        var address = fromAddress
        var result = [UInt8]()
        
        while result.count < count {
            result = result + paged_components[index_component].dumpFromAddress(address, count: count - result.count)
            index_component += 1
            address += result.count
        }
        
        return result
    }
}
