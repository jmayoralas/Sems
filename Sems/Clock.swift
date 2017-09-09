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
    private var contentionTCycles: Int = 0

    init() {
        initContentionTable()
    }

    func add(tCycles: Int) {
        self.tCycles += tCycles
        self.frameTCycles += tCycles
    }
    
    func applyContention() {
        applyContention(frameTCycles: frameTCycles)
    }
    
    func applyIOContention(address: UInt16) {
        var contentionCount = 0
        
        if 0x40 <= address.high && address.high <= 0x7F {
            if address & 1 == 1 {
                // C:1 C:1 C:1 C:1
                contentionCount = 4
            } else {
                // C:1 C:3
                contentionCount = 2
            }
        } else {
            if address & 1 == 0 {
                // N:1 C:3
                contentionCount = 1
            }
        }
        
        guard contentionCount > 0 else {
            return
        }
        
        var frameTCycles = self.frameTCycles
        
        for _ in 1...contentionCount {
            frameTCycles += getContentionDelay(tCycle: frameTCycles)
        }
        
        frameTCycles += getContentionDelay(tCycle: frameTCycles)
        contentionTCycles += frameTCycles - self.frameTCycles
     }
    
    func isContentionInProgress() -> Bool {
        guard contentionTCycles > 0 else {
            return false
        }
        
        contentionTCycles -= 1
        add(tCycles: 1)
        
        return true
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
    
    private func applyContention(frameTCycles: Int) {
        contentionTCycles += getContentionDelay(tCycle: frameTCycles)
    }
}
