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
    var contentionTCycles: Int = 0
    
    private var contentionDelayTable = [Int](repeatElement(0, count: 128))

    init() {
        initContentionTable()
    }

    func add(tCycles: Int) {
        self.tCycles += tCycles
        self.frameTCycles += tCycles
    }

    func sub(tCycles: Int) {
        self.tCycles -= tCycles
        self.frameTCycles -= tCycles
    }

    func reset() {
        tCycles = 0
        contentionTCycles = 0
    }
    
    func applyContention() {
        add(tCycles: getContentionDelay(tCycle: frameTCycles))
    }
    
    func applyIOContention(address: UInt16) {
        if 0x40 <= address.high && address.high <= 0x7F {
            if address & 1 == 1 {
                // C:1 C:1 C:1 C:1
                add(tCycles: getContentionDelay(tCycle: frameTCycles) + 1)
                add(tCycles: getContentionDelay(tCycle: frameTCycles) + 1)
                add(tCycles: getContentionDelay(tCycle: frameTCycles) + 1)
                add(tCycles: getContentionDelay(tCycle: frameTCycles) + 1)
            } else {
                // C:1 C:3
                add(tCycles: getContentionDelay(tCycle: frameTCycles) + 1)
                add(tCycles: getContentionDelay(tCycle: frameTCycles) + 3)
            }
        } else {
            if address & 1 == 0 {
                // N:1 C:3
                add(tCycles: 1)
                add(tCycles: getContentionDelay(tCycle: frameTCycles) + 3)
            } else {
                // no contention
                add(tCycles: 4)
            }
        }
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

        contentionTCycles += delay
        return delay
    }
}
