//
//  Clock.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 8/10/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation
import JMZeta80

final class Clock: SystemClock {
    var frameTCycles: Int = 0
    var cycles: Int = 0
    var contentionTCycles: Int = 0
    
    private var contentionDelayTable = [Int](repeatElement(0, count: 128))

    init() {
        initContentionTable()
    }

    func add(tCycles: Int) {
        add(cycles: tCycles)
    }
    
    func add(cycles: Int) {
        self.cycles += cycles
        self.frameTCycles += cycles
    }
    
    func add(address: UInt16, cycles: Int) {
        if address & 0xC000 == 0x4000 {
            for _ in 1...cycles {
                self.add(cycles: getContentionDelay(tCycle: frameTCycles) + 1)
            }
        } else {
            self.add(cycles: cycles)
        }
        
    }

    func sub(cycles: Int) {
        self.cycles -= cycles
        self.frameTCycles -= cycles
    }

    func getCycles() -> Int {
        return self.cycles
    }

    func reset() {
        cycles = 0
        contentionTCycles = 0
    }
    
    func applyContention() {
        add(cycles: getContentionDelay(tCycle: frameTCycles))
    }
    
    func applyIOContention(address: UInt16) {
        if 0x40 <= address.high && address.high <= 0x7F {
            if address & 1 == 1 {
                // C:1 C:1 C:1 C:1
                add(cycles: getContentionDelay(tCycle: frameTCycles) + 1)
                add(cycles: getContentionDelay(tCycle: frameTCycles) + 1)
                add(cycles: getContentionDelay(tCycle: frameTCycles) + 1)
                add(cycles: getContentionDelay(tCycle: frameTCycles) + 1)
            } else {
                // C:1 C:3
                add(cycles: getContentionDelay(tCycle: frameTCycles) + 1)
                add(cycles: getContentionDelay(tCycle: frameTCycles) + 3)
            }
        } else {
            if address & 1 == 0 {
                // N:1 C:3
                add(cycles: 1)
                add(cycles: getContentionDelay(tCycle: frameTCycles) + 3)
            } else {
                // no contention
                add(cycles: 4)
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
        
        if FIRST_CONTENDED_TSTATE <= tCycle && tCycle < LAST_CONTENDED_TSTATE {
            let index = (tCycle - ((tCycle + 1) / SCANLINE_TSTATES) * SCANLINE_TSTATES) + 1
            delay = index < 128 ? contentionDelayTable[index] : 0
        }

        contentionTCycles += delay
        return delay
    }
}
