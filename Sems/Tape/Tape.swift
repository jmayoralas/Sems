//
//  Tape.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 26/8/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

private enum TapeStatus {
    case sendingPulses
    case sendingData
    case pause
}
private let kTStatesPerMilliSecond = 3500

private typealias AfterPulsesCallback = () -> Void

final class Tape {
    
    var tapeAvailable: Bool = false
    var isPlaying: Bool = false
    
    private let clock: Clock
    private let ula: Ula
    private let loader: TapeLoader
    
    private var status = TapeStatus.sendingData
    
    private var lastLevel = TapeLevel.off
    
    private var tCycle: Int = 0

    private var tapeBlockToSend: TapeBlock!
    private var indexTapeBlockPart: Int = 0
    private var indexByteToSend: Int = 0
    
    private var leadingToneDurationTStates: Int = 0
    private var pulsesCount: Int = 0
    private var tStatesWait: Int = 0
    private var pulses: [Pulse]?
    private var indexPulse: Int = 0
    private var afterPulsesCallback: AfterPulsesCallback?
    
    init(ula: Ula) {
        self.ula = ula
        self.loader = TapeLoader()
        self.clock = self.ula.clock
    }
    
    func open(path: String) throws {
        if self.tapeAvailable {
            loader.close()
            self.tapeAvailable = false
        }
        
        try loader.open(path: path)
        self.tapeAvailable = true
    }
    
    func getBlockDirectory() throws -> [TapeBlock] {
        return try self.loader.getBlockDirectory()
    }
    
    func close() {
        self.loader.close()
        self.tapeAvailable = false
    }
    
    func rewind() {
        self.loader.rewind()
    }
    
    func setCurrentBlock(index: Int) throws {
        try self.loader.setCurrentBlock(index: index)
    }
    
    func blockRequested() throws -> [UInt8]? {
        if self.loader.eof {
            self.loader.rewind()
        }
        
        var tapeBlock: TapeBlock?
        
        var data = [UInt8]()
        
        while !self.loader.eof && data.count == 0  {
            tapeBlock = try self.loader.readBlock()
            
            if let block = tapeBlock {
                for part in block.parts {
                    if part.type == .Data {
                        data.append(contentsOf: (part as! TapeBlockPartData).data)
                    }
                }
            }
        }
        
        return data.count == 0 ? nil : data
    }
    
    func start() throws {
        guard self.tapeAvailable else {
            throw TapeLoaderError.NoTapeOpened
        }
        
        guard !self.loader.eof else {
            throw TapeLoaderError.EndOfTape
        }
        if self.isPlaying {
            self.stop()
        }
        
        self.isPlaying = true
        self.status = .sendingData
        self.tCycle = 0
        
        self.lastLevel = .off
        self.ula.setTapeLevel(value: self.lastLevel.rawValue)
    }
    
    func stop() {
        self.lastLevel = .off
        self.ula.setTapeLevel(value: self.lastLevel.rawValue)
        self.isPlaying = false
    }
    
    func step() {
        guard self.isPlaying else {
            return
        }
        
        clock.sub(cycles: clock.contentionTCycles)
        self.tCycle += clock.getCycles()
        
        switch self.status {
        case .sendingPulses:
            self.sendPulses()
            
        case .pause:
            self.pause(tCycle: tCycle)
            
        case .sendingData:
            self.sendData()
        }
    }
    
    private func pause(tCycle: Int) {
        guard let pauseValue = self.tapeBlockToSend.pauseAfterBlock else {
            self.status = .sendingData
            return
        }
        
        guard pauseValue > 0 else {
            self.status = .sendingData
            return
        }
        
        if self.tCycle - tCycle == 0 {
            self.lastLevel = self.lastLevel == .off ? .on : .off
            self.ula.setTapeLevel(value: self.lastLevel.rawValue)
        }
        
        if self.tCycle >= kTStatesPerMilliSecond {
            self.lastLevel = .off
            self.ula.setTapeLevel(value: self.lastLevel.rawValue)
        }
        
        if self.tCycle >= pauseValue * kTStatesPerMilliSecond {
            self.status = .sendingData
            self.tCycle = 0
        }
    }
    
    private func sendData() {
        if !self.loader.eof {
            self.tapeBlockToSend = try! loader.readBlock()
            
            if self.tapeBlockToSend.description == "Pause" {
                if self.tapeBlockToSend.pauseAfterBlock == 0 {
                    self.stop()
                } else {
                    self.status = .pause
                }
            } else {
                self.indexTapeBlockPart = 0
                self.sendTapeBlockPart()
            }
        } else {
            self.stop()
        }
        
    }
    
    private func sendTapeBlockPart() {
        let part = self.tapeBlockToSend.parts[self.indexTapeBlockPart]
        
        switch part.type {
        case .Pulse:
            self.sendTone()
        case .Data:
            self.sendDataBlock()
        case .Info:
            self.status = .pause
        }
    }
    
    private func endTapeBlockPart() {
        self.tCycle = 0

        self.indexTapeBlockPart += 1
        if self.indexTapeBlockPart < self.tapeBlockToSend.parts.count {
            self.sendTapeBlockPart()
        } else {
            self.status = .pause
        }
    }
    
    private func sendTone() {
        let tone = self.tapeBlockToSend.parts[self.indexTapeBlockPart] as! TapeBlockPartPulse
        self.pulses = tone.getPulses()
        
        self.indexPulse = 0
        self.tCycle = 0
        
        self.status = .sendingPulses
        self.afterPulsesCallback = self.endTapeBlockPart
    }
    
    private func sendDataBlock() {
        self.indexByteToSend = 0
        self.sendByte()
    }

    private func endDataBlock() {
        self.endTapeBlockPart()
    }
    
    private func sendByte() {
        let dataBlock = self.tapeBlockToSend.parts[self.indexTapeBlockPart] as! TapeBlockPartData
        
        self.pulses = dataBlock.getPulses(byteIndex: self.indexByteToSend)
        
        self.indexPulse = 0
        self.tCycle = 0
        
        self.status = .sendingPulses
        self.afterPulsesCallback = self.endByte
    }
    
    private func endByte() {
        self.indexByteToSend += 1
        
        let dataBlock = self.tapeBlockToSend.parts[self.indexTapeBlockPart] as! TapeBlockPartData
        
        if self.indexByteToSend >= dataBlock.data.count {
            self.endDataBlock()
        } else {
            self.sendByte()
        }
    }

    private func sendPulses() {
        if self.tCycle <= self.tStatesWait {
            return
        }
        
        self.tCycle -= self.tStatesWait
        
        if self.indexPulse < self.pulses!.count {
            let pulse = self.pulses![self.indexPulse]
            
            if let pulseTapeLevel = pulse.tapeLevel {
                self.lastLevel = pulseTapeLevel
            } else {
                self.lastLevel = self.lastLevel == .off ? .on : .off
            }

            self.ula.setTapeLevel(value: self.lastLevel.rawValue)
            
            self.tStatesWait = pulse.tStates
            
            self.indexPulse += 1
        } else {
            self.tStatesWait = 0
            self.pulses = nil
            
            self.afterPulsesCallback?()
        }
    }
}
