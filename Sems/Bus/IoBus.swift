//
//  IoBus.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 21/9/17.
//  Copyright © 2017 Jose Luis Fernandez-Mayoralas. All rights reserved.
//

import Foundation

final class IoBus: BusBase {
    private var io_components: [BusComponentBase]
    private var clock: Clock
    
    init(clock: Clock) {
        self.clock = clock
        io_components = Array(repeating: BusComponent(base_address: 0x0000, block_size: 0x0000), count: 0x100)
        
        super.init(base_address: 0x0000, block_size: 0x100)
    }
    
    override func addBusComponent(_ bus_component: BusComponentBase) {
        // only asign non ula bus components to odd ports
        if bus_component.getBaseAddress() & 0x01 == 1 {
            io_components[Int(bus_component.getBaseAddress())] = bus_component
        } else {
            if bus_component is ULAIo {
                // even ports belongs to ULA
                for i in 0..<0x100 {
                    if (i & 0x01) == 0 {
                        io_components[i] = bus_component
                    }
                }
            }
        }
        super.addBusComponent(bus_component)
    }
    
    override func write(_ address: UInt16, value: UInt8) {
        clock.applyIOContention(address: address)
        
        // port addressed by low byte of address
        io_components[Int(address & 0x00FF)].write(address, value: value)
        
        super.write(address, value: value)
    }
    
    override func read(_ address: UInt16) -> UInt8 {
        clock.applyIOContention(address: address)
        
        let _ = super.read(address)
        
        // port addressed by low byte of address
        last_data = io_components[Int(address & 0x00FF)].read(address)
        
        return last_data
    }
}
