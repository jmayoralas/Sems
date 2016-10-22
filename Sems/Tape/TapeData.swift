//
//  NSData+TapeLoader.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 26/8/16.
//  Copyright © 2016 Jose Luis Fernandez-Mayoralas. All rights reserved.
//

import Foundation

private let kPilotToneHeaderPulsesCount = 8063
private let kPilotToneDataPulsesCount = 3223
private let kPilotTonePulseLength = 2168
private let kPilotTonePause = 1000
private let kSyncPulseFirstLength = 667
private let kSyncPulseSecondLength = 735
private let kResetBitLength = 855
private let kSetBitLength = kResetBitLength * 2

private enum TapeFormat: UInt8 {
    case Tap
    case Tzx
}

private enum TzxBlockId: UInt8 {
    case StandardSpeed = 0x10
    case TurboSpeed = 0x11
    case PureTone = 0x12
    case PulseSequence = 0x13
    case PureData = 0x14
    case PauseOrStopTape = 0x20
    case GroupStart = 0x21
    case GroupEnd = 0x22
    case LoopStart = 0x24
    case LoopEnd = 0x25
    case TextDescription = 0x30
    case ArchiveInfo = 0x32
}

final class TapeData {

    var eof: Bool {
        get {
            return self.location >= self.data.length
        }
    }
    
    private var location: Int = 0
    private var data: NSData
    private var groupStarted: Bool = false
    private var loopCount: Int = 0
    private var loopStartLocation: Int = 0
    
    init?(contentsOfFile path: String) {
        guard let data = NSData(contentsOfFile: path) else {
            return nil
        }
        
        self.data = data
        
        self.location = self.getLocationFirstTapeDataBlock()
    }
    
    private var tapeFormat: TapeFormat {
        get {
            // get first 8 bytes and search for TZX signature
            let range = NSRange(location: 0, length: 7)
            var tapeFormat: TapeFormat = .Tap
            
            var signatureBytes = [UInt8](repeating: 0, count: 7)
            self.data.getBytes(&signatureBytes, range: range)
            
            if let signature = String(bytes: signatureBytes, encoding: String.Encoding.utf8) {
                if signature == "ZXTape!" {
                    tapeFormat = .Tzx
                }
            }
            
            return tapeFormat
        }
    }

    // MARK: Public methods
    func getNextTapeBlock() throws -> TapeBlock {
        var tapeBlock: TapeBlock
        
        repeat {
            tapeBlock = try self.getTapeBlock(atLocation: self.location)
            self.location += tapeBlock.size
        } while tapeBlock.description == "dummy"
        
        return tapeBlock
    }
    
    // MARK: Private methods
    private func getDataFromTapeBlock(tapeBlock: TapeBlock) -> [UInt8] {
        var data = [UInt8]()
        
        for part in tapeBlock.parts {
            if part.type == .Data {
                data.append(contentsOf: (part as! TapeBlockPartData).data)
            }
        }
        
        return data
    }
    
    private func getLocationFirstTapeDataBlock() -> Int {
        var firstDataBlock: Int = 0
        
        switch tapeFormat {
        case .Tap:
            firstDataBlock = 0
        case .Tzx:
            firstDataBlock = 10
        }
        
        return firstDataBlock
        
    }
    
    
    private func getTapeBlock(atLocation location: Int) throws -> TapeBlock {
        let tapeBlock: TapeBlock
        
        switch self.tapeFormat {
        case .Tap:
            tapeBlock = self.getTapTapeBlock(atLocation: location)
        case .Tzx:
            tapeBlock = try self.getTzxTapeBlock(atLocation: location)
        }
        
        return tapeBlock
    }
    
    
    private func getNumber(location: Int, size: Int) -> Int {
        var number: Int = 0
        
        let range = NSRange(location: location, length: size)
        var bytes = [UInt8](repeatElement(0, count: size))
        
        self.data.getBytes(&bytes, range: range)
        
        for i in (0 ..< size).reversed() {
            number += Int(bytes[i]) << (8 * i)
        }
        
        return number
    }
    
    private func getBytes(location: Int, size: Int) -> [UInt8] {
        let range = NSRange(location: location, length: Int(size))
        var data = [UInt8](repeating: 0, count: Int(size))
        self.data.getBytes(&data, range: range)
        
        return data
    }
    
    private func getTapTapeBlock(atLocation location: Int) -> TapeBlock {
        let size = self.getNumber(location: location, size: 2)
        let data = self.getBytes(location: location + 2, size: size)
        
        return self.getStandardSpeedDataBlock(data: data)
    }
    
    private func getStandardSpeedDataBlock(data: [UInt8]) -> TapeBlock {
        let flagByte = data[0]
        let pilotTonePulsesCount = flagByte < 128 ? kPilotToneHeaderPulsesCount : kPilotToneDataPulsesCount
        
        // a standard speed data block consists of:
        // a pilot tone
        let pilotTone = TapeBlockPartPulse(size: 1, pulsesCount: pilotTonePulsesCount, tStatesDuration: kPilotTonePulseLength)
        
        // a two pulse sync signal
        let syncPulse = TapeBlockPartPulse(size: 1, firstPulseTStates: kSyncPulseFirstLength, secondPulseTStates: kSyncPulseSecondLength)
        
        // a pure data block
        let dataBlock = TapeBlockPartData(size: data.count, resetBitPulseLength: kResetBitLength, setBitPulseLength: kSetBitLength, usedBitsLastByte: 8, data: data)

        return TapeBlock(description: self.getDescription(data: data), parts: [pilotTone, syncPulse, dataBlock], pauseAfterBlock: kPilotTonePause)
    }
    
    private func getTurboSpeedDataBlock(atLocation location: Int) -> TapeBlock {
        let size = self.getNumber(location: location + 0x0F, size: 3)
        let data = self.getBytes(location: location + 0x12, size: size)
        
        // a turbo speed data block consists of:
        // a pilot tone
        
        let pilotTonePulsesLength = self.getNumber(location: location, size: 2)
        let pilotTonePulsesCount = self.getNumber(location: location + 0x0A, size: 2)
        let pilotTone = TapeBlockPartPulse(size: 1, pulsesCount: pilotTonePulsesCount, tStatesDuration: pilotTonePulsesLength)
        
        // a two pulse sync signal
        let firstPulseLength = self.getNumber(location: location + 0x02, size: 2)
        let secondPulseLength = self.getNumber(location: location + 0x04, size: 2)
        let syncPulse = TapeBlockPartPulse(size: 1, firstPulseTStates: firstPulseLength, secondPulseTStates: secondPulseLength)
        
        // a pure data block
        let resetBitLength = self.getNumber(location: location + 0x06, size: 2)
        let setBitLength = self.getNumber(location: location + 0x08, size: 2)
        let usedBitsLastByte = self.getNumber(location: location + 0x0C, size: 1)
        
        
        
        let dataBlock = TapeBlockPartData(
            size: data.count,
            resetBitPulseLength: resetBitLength,
            setBitPulseLength: setBitLength,
            usedBitsLastByte: usedBitsLastByte,
            data: data
        )
        
        let pause = self.getNumber(location: location + 0x0D, size: 2)
        var block = TapeBlock(description: self.getDescription(data: data), parts: [pilotTone, syncPulse, dataBlock], pauseAfterBlock: pause)
        block.size += 0x11
        
        return block
    }
    
    private func getDescription(data: [UInt8]) -> String {
        let flagByte = data[0]
        let blockType = Int(data[1])
        
        let description: String
        
        if flagByte < 128 {
            let name : [UInt8] = Array(data[2...11])
            let identifier = String(data: Data(name), encoding: String.Encoding.ascii)!
            
            if let descriptionFromData = TapeBlockDescription(rawValue: blockType) {
                description = String(format: "%@: %@", descriptionFromData.description, identifier)
            } else {
                description = String(format: "Unknown block type: %d", Int(data[1]))
            }
        } else {
            description = "[DATA]"
        }
        
        return description
    }

    private func getTzxTapeBlock(atLocation location: Int) throws -> TapeBlock {
        let blockIdValue = UInt8(self.getNumber(location: location, size: 1))
        
        guard let blockId = TzxBlockId(rawValue: blockIdValue) else {
            throw TapeLoaderError.UnsupportedTapeBlockFormat(blockId: blockIdValue, location: location)
        }
        
        return try self.getTzxTapeBlock(blockId: blockId, location: location + 1)
    }
    
    private func getTzxTapeBlock(blockId: TzxBlockId, location: Int) throws -> TapeBlock {
        var block: TapeBlock
        
        switch blockId {
        case .StandardSpeed:
            let pause = self.getNumber(location: location, size: 2)
            
            block = self.getTapTapeBlock(atLocation: location + 2)
        
            block.size += 3
            
            if pause > 0 {
                block.pauseAfterBlock = pause
            }
            
        case .TurboSpeed:
            block = self.getTurboSpeedDataBlock(atLocation: location)
            
        case .ArchiveInfo:
            let size = self.getNumber(location: location, size: 2)
            let part = TapeBlockPartInfo(size: size + 3, description: "")
            block = TapeBlock(description: "Archive Info", parts: [part], pauseAfterBlock: nil)
            
        case .PauseOrStopTape:
            let pause = self.getNumber(location: location, size: 2)
            block = TapeBlock(description: "Pause", parts: [], pauseAfterBlock: pause)
            block.size = 3
            
        case .TextDescription:
            let size = self.getNumber(location: location, size: 1)
            let part = TapeBlockPartInfo(size: size + 2, description: "")
            block = TapeBlock(description: "Description", parts: [part], pauseAfterBlock: nil)
            
        case .GroupStart:
            let size = self.getNumber(location: location, size: 1)
            self.groupStarted = true
            let part = TapeBlockPartInfo(size: size + 2, description: "")
            block = TapeBlock(description: "Group start", parts: [part], pauseAfterBlock: nil)
            
        case .GroupEnd:
            self.groupStarted = false
            let part = TapeBlockPartInfo(size: 1, description: "")
            block = TapeBlock(description: "Group end", parts: [part], pauseAfterBlock: nil)
            
        case .LoopStart:
            let size = 3
            
            guard self.loopCount == 0 else {
                throw TapeLoaderError.DataIncoherent(blockId: blockId.rawValue, location: location)
            }
            
            self.loopCount = self.getNumber(location: location, size: 2)
            guard self.loopCount > 1 else {
                throw TapeLoaderError.DataIncoherent(blockId: blockId.rawValue, location: location)
            }
            
            block = TapeBlock(size: size)
            self.loopStartLocation = location + size - 1
            
        case .LoopEnd:
            self.loopCount -= 1
            
            self.location = self.loopCount > 0 ? self.loopStartLocation : self.location + 1
            
            block = TapeBlock(size: 0)
            
        case .PureTone:
            let toneLength = self.getNumber(location: location, size: 2)
            let tonePulsesCount = self.getNumber(location: location + 2, size: 2)
            let part = TapeBlockPartPulse(size: 5, pulsesCount: tonePulsesCount, tStatesDuration: toneLength)
            
            block = TapeBlock(description: "Pure tone", parts: [part], pauseAfterBlock: nil)
            
        case .PulseSequence:
            let pulsesCount = self.getNumber(location: location, size: 1)
            
            var parts = [TapeBlockPart]()
            
            for i in 1 ... pulsesCount / 2 {
                let firstPulseLength = self.getNumber(location: location + (i * 4 - 4) + 1, size: 2)
                let secondPulseLength = self.getNumber(location: location + (i * 4 - 4) + 3, size: 2)
                
                parts.append(TapeBlockPartPulse(size: 4, firstPulseTStates: firstPulseLength, secondPulseTStates: secondPulseLength))
            }
            
            block = TapeBlock(description: "Pulse sequence", parts: parts, pauseAfterBlock: nil)
            block.size += 2
            
        case .PureData:
            let resetBitLength = self.getNumber(location: location, size: 2)
            let setBitLength = self.getNumber(location: location + 2, size: 2)
            let usedBitsLastByte = self.getNumber(location: location + 4, size: 1)
            let pause = self.getNumber(location: location + 5, size: 2)
            let size = self.getNumber(location: location + 7, size: 3)
            let data = self.getBytes(location: location + 10, size: size)
            
            let dataPart = TapeBlockPartData(size: data.count + 10, resetBitPulseLength: resetBitLength, setBitPulseLength: setBitLength, usedBitsLastByte: usedBitsLastByte, data: data)
            block = TapeBlock(description: "Pure data", parts: [dataPart], pauseAfterBlock: pause)
            block.size += 1
            
        }
 
        return block
    }
}
