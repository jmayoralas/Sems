//
//  VmScreen.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 7/8/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

public struct PixelData {
    var a:UInt8 = 255
    var r:UInt8
    var g:UInt8
    var b:UInt8
}

let colorTable = [
    PixelData(a: 255, r: 0, g: 0, b: 0),
    PixelData(a: 255, r: 0, g: 0, b: 0xCD),
    PixelData(a: 255, r: 0xCD, g: 0, b: 0),
    PixelData(a: 255, r: 0xCD, g: 0, b: 0xCD),
    PixelData(a: 255, r: 0, g: 0xCD, b: 0),
    PixelData(a: 255, r: 0, g: 0xCD, b: 0xCD),
    PixelData(a: 255, r: 0xCD, g: 0xCD, b: 0),
    PixelData(a: 255, r: 0xCD, g: 0xCD, b: 0xCD),
    
    PixelData(a: 255, r: 0, g: 0, b: 0),
    PixelData(a: 255, r: 0, g: 0, b: 0xFF),
    PixelData(a: 255, r: 0xFF, g: 0, b: 0),
    PixelData(a: 255, r: 0xFF, g: 0, b: 0xFF),
    PixelData(a: 255, r: 0, g: 0xFF, b: 0),
    PixelData(a: 255, r: 0, g: 0xFF, b: 0xFF),
    PixelData(a: 255, r: 0xFF, g: 0xFF, b: 0),
    PixelData(a: 255, r: 0xFF, g: 0xFF, b: 0xFF),
]

let kWhiteColor = colorTable[7]

extension PixelData: Equatable {}
public func ==(lhs: PixelData, rhs: PixelData) -> Bool {
    return lhs.a == rhs.a && lhs.r == rhs.r && lhs.g == rhs.g && lhs.b == rhs.b
}

struct Attribute {
    var flashing: Bool
    var paperColor: PixelData
    var inkColor: PixelData
}

let kBaseWidth = 320

struct BorderData {
    let color: PixelData
    let tCycle: Int
}

@objc final public class VmScreen: NSObject {
    var flashState: Bool = false
    
    public var width: Int
    public var height: Int
    
    public var buffer: [PixelData]
    
    var changed: Bool = false
    
    var memory: ULAMemory!
    private var zoomFactor: Int
    
    private var lastTCycle: Int = 0
    private var memoryScreen: Ram
    private var addressUpdated: [UInt16] = []
    private var borderUpdated: [BorderData] = []
    private var lastBorderColor: PixelData = kWhiteColor
    
    public init(zoomFactor: Int) {
        self.zoomFactor = zoomFactor
        
        width = kBaseWidth * zoomFactor
        height = width * 3 / 4
        
        buffer = VmScreen.initBuffer(zoomFactor: zoomFactor)
        
        memoryScreen = Ram(base_address: 16384, block_size: 0x1B00)
    }
    
    public func setZoomFactor(zoomFactor: Int) {
        if self.zoomFactor != zoomFactor {
            self.zoomFactor = zoomFactor
            
            width = kBaseWidth * zoomFactor
            height = width * 3 / 4
            
            buffer = VmScreen.initBuffer(zoomFactor: zoomFactor)
        }
    }
    
    func step(tCycle: Int) {
        for i in self.lastTCycle...tCycle {
            processTCycle(tCycle: i)
        }
        
        self.lastTCycle = tCycle + 1
        self.lastTCycle = (self.lastTCycle > kTicsPerFrame ? self.lastTCycle - kTicsPerFrame : self.lastTCycle)
    }
    
    func updateFlashing() {
        for i in 0..<0x300 {
            addressUpdated.append(0x5800 + UInt16(i))
        }
        
        changed = true
    }
    
    func setBorderData(borderData: BorderData) {
        if borderUpdated.count == 0 || borderUpdated[borderUpdated.count - 1].color != borderData.color {
            borderUpdated.append(borderData)
            
            changed = true
        }
        
    }
    
    func updateScreenBuffer() {
        // update bitmap
        for address in addressUpdated {
            updateScreenBufferAt(address)
        }
        
        //update border
        var tCycle = 1
        
        for borderData in borderUpdated {
            updateBorder(fromTCycle: tCycle, untilTCycle: borderData.tCycle, withPixelData: lastBorderColor)
            lastBorderColor = borderData.color
            tCycle = borderData.tCycle
        }
        
        updateBorder(fromTCycle: tCycle, untilTCycle: 64512, withPixelData: lastBorderColor)
        
        addressUpdated = []
        borderUpdated = []
        
        changed = false
    }
    
    private func updateScreenBufferAt(_ address: UInt16) {
        guard 0x4000 <= address && address <= 0x5AFF else {
            return
        }
        
        if address < 0x5800 {
            // btimap area
            fillEightBitLineAt(address: address)
        } else {
            // attr area
            updateCharAt(address: address)
        }

    }
    
    private func fillEightBitLineAt(address: UInt16) {
        guard let coord = getXYForAddress(address) else {
            return
        }
        
        let value = memoryScreen.read(address)
        let attribute = VmScreen.getAttribute(memoryScreen.read(getAttributeAddress(address)!))
        
        fillEightBitLineAt(coord: coord, value: value, attribute: attribute)
    }

    private func fillEightBitLineAt(coord: (x: Int, y: Int), value: UInt8, attribute: Attribute) {
        let inkColor: PixelData!
        let paperColor: PixelData!
        
        if flashState && attribute.flashing {
            inkColor = attribute.paperColor
            paperColor = attribute.inkColor
        } else {
            inkColor = attribute.inkColor
            paperColor = attribute.paperColor
        }
        
        let bitmapCoord = (x: coord.x * 8 + 32, y: coord.y + 24)
        var bit = 0
        
        for i in (0...7).reversed() {
            let index = getBufferIndex(bitmapCoord.x + bit, bitmapCoord.y)
            let pixelData: PixelData = ((Int(value) & 1 << i) > 0) ? inkColor : paperColor
            
            setBuffer(atIndex: index, withPixelData: pixelData)
            
            bit += 1
        }
    }

    private func updateCharAt(address: UInt16) {
        let local_address = address & 0x3FFF
        let offset = Int(local_address) & 0x7FF
        let coord = (x: offset % 32, y: (offset / 32) * 8)
        let attribute = VmScreen.getAttribute(memoryScreen.read(address))
        
        let line_address = UInt16(0x4000 + coord.y * 32 + coord.x)
        let line_address_corrected = (line_address & 0xF800) | ((line_address & 0x700) >> 3) | ((line_address & 0xE0) << 3) | (line_address & 0x1F)
        
        for i in 0...7 {
            let coord_i = (coord.x, coord.y + i)
            fillEightBitLineAt(coord: coord_i, value: memoryScreen.read(line_address_corrected + UInt16(i * 0x100)), attribute: attribute)
        }
    }

    private func updateBorder(fromTCycle: Int, untilTCycle: Int, withPixelData pixelData: PixelData) {
        let topBufferTCycle = (untilTCycle <= 62640 ? untilTCycle : 62640)
        
        guard fromTCycle < topBufferTCycle else {
            return
        }
        
        for tCycle in fromTCycle...topBufferTCycle - 1 {
            if let coord = getBorderXY(tCycle: tCycle) {
                for i in 0...7 {
                    let index = getBufferIndex(coord.x + i, coord.y)
                    setBuffer(atIndex: index, withPixelData: pixelData)
                }
            }
        }
    }
    
    private func getBufferIndex(_ x: Int, _ y: Int) -> Int {
        return y * zoomFactor * width + x * zoomFactor
    }
    
    private func setBuffer(atIndex index: Int, withPixelData pixelData: PixelData) {
        for i in 0 ..< zoomFactor {
            for j in 0 ..< zoomFactor {
                if buffer[index + i + j * width] != pixelData {
                    buffer[index + i + j * width] = pixelData
                }
            }
        }
    }
    
    static func getAttribute(_ value: UInt8) -> Attribute {
        return Attribute(
            flashing: (value & 0b10000000) > 0 ? true : false,
            paperColor: colorTable[(Int(value) >> 3) & 0b00001111],
            inkColor: colorTable[((Int(value) >> 3) & 0b00001000) | (Int(value) & 0b00000111)]
        )
    }
    
    private static func initBuffer(zoomFactor: Int) -> [PixelData] {
        let width = kBaseWidth * zoomFactor
        let height = width * 3 / 4
        
        return [PixelData](repeating: kWhiteColor, count: width * height)
    }
    
    private func getMemoryAddress(tCycle: Int) -> UInt16? {
        guard tCycle % 4 == 1 else {
            return nil
        }
        
        let line = (tCycle / 224 - 64)
        
        guard 0 <= line && line <= 191 else {
            return nil
        }
        
        let lineTCycleBase = 14336 + (224 * line)
        let lineBaseAddress = 16384 + 32 * line
        
        let offset = (tCycle - lineTCycleBase) / 4
        
        guard 0 <= offset && offset <= 31 else {
            return nil
        }
        
        return UInt16(lineBaseAddress + offset)
    }
    
    private func getAttributeAddress(_ address: UInt16) -> UInt16? {
        guard let coord = getXYForAddress(address) else {
            return nil
        }
        
        return UInt16(0x5800 + coord.x + (coord.y / 8) * 32)
    }

    private func processTCycle(tCycle: Int) {
        guard let address = self.getMemoryAddress(tCycle: tCycle) else {
            return
        }

        let attributeAddress = getAttributeAddress(address)!
        
        let newValue = memory.readNoContention(address)
        let newAttribute = memory.readNoContention(attributeAddress)
        
        saveByteIntoBuffer(address: address, byte: newValue)
        saveByteIntoBuffer(address: attributeAddress, byte: newAttribute)
    }
    
    private func saveByteIntoBuffer(address: UInt16, byte: UInt8) {
        guard byte != memoryScreen.read(address) else {
            return
        }
        
        memoryScreen.write(address, value: byte)
        addressUpdated.append(address)
        
        changed = true
    }
    
    private func getXYForAddress(_ address: UInt16) -> (x: Int, y: Int)? {
        let local_address = address & 0x3FFF

        guard local_address < 0x1800 else {
            return nil
        }
        
        return (
            Int((local_address.low & 0b00011111)),
            Int(((local_address.high & 0b00011000) << 3) | ((local_address.low & 0b11100000) >> 2) | (local_address.high & 0b00000111))
        )
    }
    
    private func getBorderXY(tCycle: Int) -> (x:Int, y:Int)? {
        guard tCycle >= 16 * 224 - 24 else {
            return nil
        }
        
        let y = (tCycle + 24) / 224 - 16
        
        let lineTCycleBase = 3584 + y * 224 // left border first pixel
        let x = (tCycle + 24 - lineTCycleBase) / 4
        
        guard 2 <= x && x <= 44 - 2 else {
            return nil
        }
        
        guard 24 <= y && y <= 288 - 24 else {
            return nil
        }
        
        let res_x  = (x - 2) * 8
        let res_y = y - 24
        
        if res_x >= 32 && res_x < 288 && res_y >= 24 && res_y < 216 {
            return nil
        }
        
        return (res_x, res_y)
    }





}
