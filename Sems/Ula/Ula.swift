//
//  Ula.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 12/5/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

protocol InternalUlaOperationDelegate {
    func memoryRead()
    func memoryWrite(_ address: UInt16, value: UInt8)
    func ioWrite(_ address: UInt16, value: UInt8)
    func ioRead(_ address: UInt16) -> UInt8
}

final class Ula: InternalUlaOperationDelegate {
    var memory: ULAMemory!
    var io: ULAIo!
    
    var screen: VmScreen
    
    let clock: Clock
    
    private var borderColor: PixelData = kWhiteColor
    
    private var newFrame = true
    private var lineTCycles: Int = 0
    private var screenLine: Int = 1
    
    private var frames: Int = 0
    
    private var key_buffer = [UInt8](repeatElement(0xFF, count: 8))
    
    private var audioStreamer: AudioStreamer!
    
    private var ioData: UInt8 = 0
    
    private var audioEnabled = true
    
    private var tapeLevel: Int = 0
    
    private var contentionDelayTable = [Int](repeatElement(0, count: 128))
    
    init(screen: VmScreen, clock: Clock) {
        self.screen = screen
        self.clock = clock
        
        self.audioStreamer = AudioStreamer()
        
        self.memory = ULAMemory(delegate: self)
        self.io = ULAIo(delegate: self)
        
        self.screen.memory = memory
        
        self.initContentionTable()
    }
    
    func step() {
        if newFrame {
            newFrame = false
            screen.beginFrame()
        }
        
        self.clock.frameTCycles += self.clock.tCycles
        self.lineTCycles += self.clock.tCycles
        
        self.screen.step(tCycle: self.clock.frameTCycles)
        
        if audioEnabled {
            // sample ioData plus tape signal to compute new audio data
            var signal = self.ioData
            signal.bit(6, newVal: self.tapeLevel)
            
            self.audioStreamer.updateSample(tCycle: self.clock.frameTCycles, value: signal)
        }

        if self.lineTCycles > kTicsPerLine {
            self.screen.updateBorder(line: screenLine, color: borderColor)
            
            self.screenLine += 1
            self.lineTCycles -= kTicsPerLine
            
            if self.screenLine > kScreenLines {
                self.frameCompleted()
                self.screenLine = 1
            }
        }
    }
    
    func toggleAudio() {
        self.audioEnabled = !self.audioEnabled
        if !self.audioEnabled {
            self.audioStreamer.stop()
        }
    }
    
    func setTapeLevel(value: Int) {
        self.tapeLevel = value
    }
    
    // MARK: Keyboard management
    func keyDown(address: UInt8, value: UInt8) {
        for i in 0 ..< 8 {
            if (Int(address) >> i) & 0x01 == 0 {
                key_buffer[i] = key_buffer[i] & value
            }
        }
    }
    
    func keyUp(address: UInt8, value: UInt8) {
        for i in 0 ..< 8 {
            if (Int(address) >> i) & 0x01 == 0 {
                key_buffer[i] = key_buffer[i] | ~value
            }
        }
    }
    
    // MARK: Screen management
    private func frameCompleted() {
        if self.audioEnabled {
            self.audioStreamer.endFrame()
        }
        
        self.frames += 1
        
        if self.frames > 16 {
            self.screen.flashState = !screen.flashState
            self.screen.updateFlashing()
            self.frames = 0
        }
        
        self.newFrame = true
        self.clock.frameTCycles -= kTicsPerFrame
    }
    
    // MARK: InternalUlaOperation delegate
    func memoryRead() {
        self.clock.tCycles += self.getContentionDelay(tCycle: self.clock.frameTCycles - 1)
    }
    
    func memoryWrite(_ address: UInt16, value: UInt8) {
        self.clock.tCycles += self.getContentionDelay(tCycle: self.clock.frameTCycles - 1)
    }
    
    func ioRead(_ address: UInt16) -> UInt8 {
        var dataReturned: UInt8 = 0b10111111
        dataReturned.bit(6, newVal: self.tapeLevel)
        
        for i in 0 ..< 8 {
            if (Int(address.high) >> i) & 0x01 == 0 {
                dataReturned = dataReturned & key_buffer[i]
            }
        }
        return dataReturned
    }
    
    func ioWrite(_ address: UInt16, value: UInt8)  {
        self.ioData = value
        
        // get the border color from value
        borderColor = colorTable[Int(value) & 0x07]
    }
    
    private func getContentionDelay(tCycle: Int) -> Int {
        var delay = 0
        
        if 14335 <= tCycle && tCycle < 57344 {
            let index: Int = (tCycle - ((tCycle + 1) / kTicsPerLine) * kTicsPerLine) + 1
            delay = index < 128 ? self.contentionDelayTable[index] : 0
        }
        
        return delay
    }
    
    private func initContentionTable() {
        var delay = 7
        
        for i in 0 ..< self.contentionDelayTable.count {
            delay -= 1
            
            if delay >= 0 {
                self.contentionDelayTable[i] = delay
            } else {
                delay = 7
            }
            
        }
    }
}
