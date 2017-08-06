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
    private var addressUpdated: [UInt16]
    
    public init(zoomFactor: Int) {
        self.zoomFactor = zoomFactor
        
        width = kBaseWidth * zoomFactor
        height = width * 3 / 4
        
        buffer = VmScreen.initBuffer(zoomFactor: zoomFactor)
        
        memoryScreen = Ram(base_address: 16384, block_size: 0x1B00)
        addressUpdated = []
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
            if let address = self.getMemoryAddress(tCycle: i) {
                let attributeAddress = getAttributeAddress(address)!
                
                let newValue = memory.readNoContention(address)
                let newAttribute = memory.readNoContention(attributeAddress)
                
                if newValue != memoryScreen.read(address) {
                    memoryScreen.write(address, value: newValue)
                    addressUpdated.append(address)
                    changed = true
                }
                
                if newAttribute != memoryScreen.read(attributeAddress) {
                    memoryScreen.write(attributeAddress, value: newAttribute)
                    addressUpdated.append(attributeAddress)
                    changed = true
                }
            }
        }
        
        self.lastTCycle = tCycle + 1
        self.lastTCycle = (self.lastTCycle > kTicsPerFrame ? self.lastTCycle - kTicsPerFrame : self.lastTCycle)
    }
    
    func updateScreenBuffer() {
        for address in addressUpdated {
            updateScreenBufferAt(address)
        }
        
        addressUpdated = []
        changed = true
    }
    
    func updateScreenBufferAt(_ address: UInt16) {
        let local_address = address & 0x3FFF
        
        if local_address > 0x1AFF {
            return
        }
        
        if local_address < 0x1800 {
            // bitmap area
            let x = Int((local_address.low & 0b00011111))
            let y = Int(((local_address.high & 0b00011000) << 3) | ((local_address.low & 0b11100000) >> 2) | (local_address.high & 0b00000111))
            
            let attribute_address = UInt16(0x5800 + x + (y / 8) * 32)
            
            fillEightBitLineAt(char: x, line: y, value: memoryScreen.read(address), attribute: VmScreen.getAttribute(memoryScreen.read(attribute_address)))
        } else {
            // attr area
            updateCharAtOffset(Int(local_address) & 0x7FF, attribute: VmScreen.getAttribute(memoryScreen.read(address)))
        }

    }
    
    func fillEightBitLineAt(char x: Int, line y: Int, value: UInt8, attribute: Attribute) {
        
        let inkColor: PixelData!
        let paperColor: PixelData!
        
        if flashState && attribute.flashing {
            inkColor = attribute.paperColor
            paperColor = attribute.inkColor
        } else {
            inkColor = attribute.inkColor
            paperColor = attribute.paperColor
        }
        
        let bitmap_x = x * 8 + 32
        let bitmap_y = y + 24
        
        var bit = 0
        
        for i in (0...7).reversed() {
            let index = getBufferIndex(bitmap_x + bit, bitmap_y)
            let pixelData: PixelData = ((Int(value) & 1 << i) > 0) ? inkColor : paperColor
            
            setBuffer(atIndex: index, withPixelData: pixelData)
            
            bit += 1
        }
    }
    
    func updateCharAtOffset(_ offset: Int, attribute: Attribute) {
        let y = (offset / 32) * 8
        let x = offset % 32
        
        let line_address = UInt16(0x4000 + y * 32 + x)
        let line_address_corrected = (line_address & 0xF800) | ((line_address & 0x700) >> 3) | ((line_address & 0xE0) << 3) | (line_address & 0x1F)
        
        for i in 0...7 {
            fillEightBitLineAt(char: x, line: y + i, value: memoryScreen.read(line_address_corrected + UInt16(i * 0x100)), attribute: attribute)
        }
    }
    
    func updateFlashing() {
        for i in 0..<0x300 {
            addressUpdated.append(0x5800 + UInt16(i))
        }
        
        changed = true
    }
    
    func updateBorder(line: Int, color: PixelData) {
        if 36 <= line && line <= 239 + 36 {
            // the line is on the visible area of the screen
            // update border color if we have to
            let bitmapLine = line - 36
            var index = getBufferIndex(0, bitmapLine)
            
            // the bitmapLine background color has changed ?
            if buffer[index] != color {
                if 24 <= bitmapLine && bitmapLine < 24 + 192 {
                    // bitmap border
                    for i in 0..<32 {
                        index = getBufferIndex(i, bitmapLine)
                        setBuffer(atIndex: index, withPixelData: color)
                    }
                    for i in 256 + 32..<320 {
                        index = getBufferIndex(i, bitmapLine)
                        setBuffer(atIndex: index, withPixelData: color)
                    }
                } else {
                    // above and below bitmap area border
                    for i in 0..<320 {
                        index = getBufferIndex(i, bitmapLine)
                        setBuffer(atIndex: index, withPixelData: color)
                    }
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
        var attribute_address: UInt16? = nil
        
        let local_address = address & 0x3FFF
        
        if local_address < 0x1800 {
            // bitmap area
            let x = Int((local_address.low & 0b00011111))
            let y = Int(((local_address.high & 0b00011000) << 3) | ((local_address.low & 0b11100000) >> 2) | (local_address.high & 0b00000111))
            
            attribute_address = UInt16(0x5800 + x + (y / 8) * 32)
        }
        
        return attribute_address
    }

}
