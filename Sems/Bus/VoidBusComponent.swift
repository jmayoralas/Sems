//
//  VoidBusComponent.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 21/9/17.
//  Copyright © 2017 Jose Luis Fernandez-Mayoralas. All rights reserved.
//

import Foundation

final class VoidBusComponent : BusComponent {
    var clock: Clock
    var screen: VmScreen
    
    init(base_address: UInt16, block_size: Int, clock: Clock, screen: VmScreen) {
        self.clock = clock
        self.screen = screen
        
        super.init(base_address: base_address, block_size: block_size)
    }
    
    override func read(_ address: UInt16) -> UInt8 {
        return screen.getFloatData(tCycle: clock.frameTCycles)
    }
}
