//
//  Clock.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 8/10/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

final class Clock {
    var frameTCycles: Int = 0
    var tCycles: Int = 0
    
    private var contentionDelayTable = [Int](repeatElement(0, count: 128))

    init() {
        initContentionTable()
    }
    
    func applyContention() {
        frameTCycles += getContentionDelay(tCycle: frameTCycles)
    }
    
    private func initContentionTable() {
        var delay = 7
        
        for i in 0 ..< contentionDelayTable.count {
            delay -= 1
            
            if delay >= 0 {
                contentionDelayTable[i] = delay
            } else {
                delay = 7
            }
            
        }
    }
    
    private func getContentionDelay(tCycle: Int) -> Int {
        var delay = 0
        
        if 14335 <= tCycle && tCycle < 57344 {
            let index = (tCycle - ((tCycle + 1) / kTicsPerLine) * kTicsPerLine) + 1
            delay = index < 128 ? contentionDelayTable[index] : 0
        }
        
        return delay
    }
}
