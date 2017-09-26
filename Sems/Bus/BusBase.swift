//
//  BusBase.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 21/9/17.
//  Copyright © 2017 Jose Luis Fernandez-Mayoralas. All rights reserved.
//

import Foundation

class BusBase : BusComponent {
    var lastAddress: UInt16 = 0xFFFF
    
    var bus_components = [BusComponentBase]()
    var last_data: UInt8 = 0xFF
    
    func addBusComponent(_ bus_component: BusComponentBase) {
        bus_components.append(bus_component)
    }
    
    func deleteBusComponent(_ bus_component: BusComponentBase) {
        
    }
    
    override func write(_ address: UInt16, value: UInt8) {
        self.lastAddress = address
        super.write(address, value: value)
    }
    
    override func read(_ address: UInt16) -> UInt8 {
        self.lastAddress = address
        return super.read(address)
    }
}
