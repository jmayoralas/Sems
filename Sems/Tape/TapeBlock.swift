//
//  TapeBlock.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 13/9/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

enum TapeLevel: Int {
    case off = 0
    case on = 1
}

struct Pulse {
    var tapeLevel: TapeLevel?
    var tStates: Int
}

let kEndPulseSequence = Pulse(tapeLevel: nil, tStates: 0)

enum TapeBlockPartType {
    case Pulse
    case Data
    case Info
}

public enum TapeBlockDescription: Int, CustomStringConvertible {
    case ProgramHeader = 0
    case NumberArrayHeader
    case CharacterArrayHeader
    case BytesHeader
    
    public var description: String {
        get {
            let description: String
            
            switch self {
            case .ProgramHeader:
                description = "Program"
            case .NumberArrayHeader:
                description = "Number array"
            case .CharacterArrayHeader:
                description = "Character array"
            case .BytesHeader:
                description = "Bytes"
            }
            
            return description
        }
    }
}




protocol TapeBlockPart: CustomStringConvertible {
    var type: TapeBlockPartType { get }
    var size: Int { get }
}




struct TapeBlockPartPulse : TapeBlockPart {
    var type: TapeBlockPartType = .Pulse
    var size: Int
    
    var description: String {
        get {
            return String(format: "Pulse block. %d pulses.", self.pulses.count - 1)
        }
    }
    
    private let pulses: [Pulse]
    
    init(size: Int, pulsesCount: Int, tStatesDuration: Int) {
        self.size = size
        
        var pulses = [Pulse]()
        
        var tapeLevel: TapeLevel?
        
        for i in 1 ... pulsesCount {
            // make sure a tone always start with an off tape level
            tapeLevel = i == 1 ? .off : nil
            pulses.append(Pulse(tapeLevel: tapeLevel, tStates: tStatesDuration))
        }
        
        self.pulses = pulses
    }
    
    init(size: Int, firstPulseTStates: Int, secondPulseTStates: Int) {
        self.size = size
        
        self.pulses = [
            Pulse(tapeLevel: nil, tStates: firstPulseTStates),
            Pulse(tapeLevel: nil, tStates: secondPulseTStates),
        ]
    }
    
    func getPulses() -> [Pulse] {
        return self.pulses
    }
}




struct TapeBlockPartData: TapeBlockPart {
    var type: TapeBlockPartType = .Data
    var size: Int
    
    var description: String {
        get {
            return String(format: "Pure data block. %d bytes", self.data.count)
        }
    }
    
    private var resetBitPulseLength: Int
    private var setBitPulseLength: Int
    
    private var usedBitsLastByte: Int
    
    var data: [UInt8]
    
    init(size: Int, resetBitPulseLength: Int, setBitPulseLength: Int, usedBitsLastByte: Int, data: [UInt8]) {
        self.size = size
        self.resetBitPulseLength = resetBitPulseLength
        self.setBitPulseLength = setBitPulseLength
        self.usedBitsLastByte = usedBitsLastByte
        self.data = data
    }
    
    func getPulses(byteIndex: Int) -> [Pulse] {
        let lastUsedBit = byteIndex < self.data.count - 1 ? 0 : 8 - self.usedBitsLastByte
        
        var pulses = [Pulse]()
        
        guard lastUsedBit < 8 else {
            return pulses
        }
        
        for bit in (lastUsedBit ... 7).reversed() {
            pulses.append(contentsOf: self.getBitPulses(byteIndex: byteIndex, bitIndex: bit))
        }
        
        return pulses
    }
    
    private func getBitPulses(byteIndex: Int, bitIndex: Int) -> [Pulse] {
        let bitToSend = self.data[byteIndex].bit(bitIndex)
        
        return self.getBitPulses(forBitValue: bitToSend)
    }
    
    private func getBitPulses(forBitValue bitValue: Int) -> [Pulse] {
        let bitTStates = bitValue == 0 ? self.resetBitPulseLength : self.setBitPulseLength
        
        return [
            Pulse(tapeLevel: nil, tStates: bitTStates),
            Pulse(tapeLevel: nil, tStates: bitTStates),
        ]
    }
}


struct TapeBlockPartInfo: TapeBlockPart {
    var type = TapeBlockPartType.Info
    var size: Int
    
    var description: String
    
    init(size: Int, description: String) {
        self.size = size
        self.description = description
    }
}


struct TapeBlock: CustomStringConvertible {
    var description: String
    var parts: [TapeBlockPart]
    
    var pauseAfterBlock: Int?
    
    var size: Int = 0
    
    init(description: String, parts: [TapeBlockPart], pauseAfterBlock: Int?) {
        self.description = description
        self.parts = parts
        self.pauseAfterBlock = pauseAfterBlock
        
        self.size = self.getPartsSize()
    }
    
    init(size: Int) {
        self.description = "dummy"
        self.size = size
        self.parts = []
    }
    
    func getPartsSize() -> Int {
        var size: Int = 0
        
        for part in self.parts {
            size += part.size
        }
        
        return size
    }
}
