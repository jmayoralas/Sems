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
let kBorderLastTCycle = 62639 // last tcycle for coord. x=312, y=239

struct BorderData {
    let color: PixelData
    var tCycle: Int
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
    private var currentBorderData: BorderData
    private var previousBorderColor: PixelData = kWhiteColor
    private var floatDataTable: [UInt16?] = Array(repeating: nil, count: 224 * 192)
    
    public init(zoomFactor: Int) {
        self.zoomFactor = zoomFactor
        
        width = kBaseWidth * zoomFactor
        height = width * 3 / 4
        
        buffer = VmScreen.initBuffer(zoomFactor: zoomFactor)
        
        memoryScreen = Ram(base_address: 16384, block_size: 0x1B00)
        currentBorderData = BorderData(color: kWhiteColor, tCycle: 0)

        super.init()
        
        fillFloatingDataTable()
    }
    
    final func setZoomFactor(zoomFactor: Int) {
        if self.zoomFactor != zoomFactor {
            self.zoomFactor = zoomFactor
            
            width = kBaseWidth * zoomFactor
            height = width * 3 / 4
            
            buffer = VmScreen.initBuffer(zoomFactor: zoomFactor)
        }
    }
    
    final func step(tCycle: Int) {
        for i in self.lastTCycle...tCycle {
            processTCycle(tCycle: i)
        }
        
        self.lastTCycle = tCycle + 1
        self.lastTCycle = (self.lastTCycle > FRAME_TSTATES ? self.lastTCycle - FRAME_TSTATES : self.lastTCycle)
    }
    
    final func updateFlashing() {
        for i in 0..<0x300 {
            addressUpdated.append(0x5800 + UInt16(i))
        }
        
        changed = true
    }
    
    final func setBorderData(borderData: BorderData) {
        previousBorderColor = currentBorderData.color
        currentBorderData = borderData
        changed = true
    }
    
    final func updateScreenBuffer() {
        updateBitmap()
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
        var line_address_corrected = (line_address & 0xF800)
        line_address_corrected |= ((line_address & 0x700) >> 3)
        line_address_corrected |= ((line_address & 0xE0) << 3)
        line_address_corrected |= (line_address & 0x1F)
        
        for i in 0...7 {
            let coord_i = (coord.x, coord.y + i)
            fillEightBitLineAt(coord: coord_i, value: memoryScreen.read(line_address_corrected + UInt16(i * 0x100)), attribute: attribute)
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
        if let coord = getBorderXY(tCycle: tCycle) {
            updateBorderData(coord: coord, tCycle: tCycle)
        }
        
        guard let address = self.getMemoryAddress(tCycle: tCycle) else {
            return
        }

        let attributeAddress = getAttributeAddress(address)!
        
        let newValue = memory.readNoContention(address)
        let newAttribute = memory.readNoContention(attributeAddress)
        
        saveByteIntoBuffer(address: address, byte: newValue)
        saveByteIntoBuffer(address: attributeAddress, byte: newAttribute)
    }
    
    private func updateBorderData(coord: (x: Int, y: Int), tCycle: Int) {
        let colorToSet = tCycle < currentBorderData.tCycle ? previousBorderColor : currentBorderData.color
        
        if buffer[getBufferIndex(coord.x, coord.y)] != colorToSet {
            for i in 0...7 {
                setBuffer(atIndex: getBufferIndex(coord.x + i, coord.y), withPixelData: colorToSet)
            }
        }
        
        // when we are at the end of frame,
        // assume current border data from the beginning of next frame
        if tCycle >= kBorderLastTCycle {
            currentBorderData.tCycle = 0
        }
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
        
        let x = local_address.low & 0b00011111
        var y = (local_address.high & 0b00011000) << 3
        y |= (local_address.low & 0b11100000) >> 2
        y |= local_address.high & 0b00000111
        
        return (Int(x),Int(y))
    }
    
    private func getBorderXY(tCycle: Int) -> (x:Int, y:Int)? {
        guard tCycle >= FIRST_VISIBLE_SCANLINE * SCANLINE_TSTATES - 24 else {
            return nil
        }
        
        let y = (tCycle + 24) / SCANLINE_TSTATES - FIRST_VISIBLE_SCANLINE
        
        let lineTCycleBase = 3584 + y * SCANLINE_TSTATES // left border first pixel
        let x = (tCycle + 24 - lineTCycleBase) / 4
        
        guard 2 <= x && x < 44 - 2 else {
            return nil
        }
        
        guard 24 <= y && y < 288 - 24 else {
            return nil
        }
        
        let res_x  = (x - 2) * 8
        let res_y = y - 24
        
        if res_x >= 32 && res_x < 288 && res_y >= 24 && res_y < 216 {
            return nil
        }
        
        return (res_x, res_y)
    }

    private func updateBitmap() {
        for address in addressUpdated {
            updateScreenBufferAt(address)
        }
        
        addressUpdated = []
    }
    
    private func fillFloatingData(line: Int, fromAddress: UInt16) {
        var address = fromAddress
        
        let baseline = line * 224
        
        for i in stride(from: baseline, to: baseline + 127, by: 8) {
            floatDataTable[i] = address
            floatDataTable[i + 1] = getAttributeAddress(address)
            floatDataTable[i + 2] = address + 1
            floatDataTable[i + 3] = getAttributeAddress(address + 1)
            
            address += 2
        }
    }
    
    private func fillFloatingDataTable() {
        var address: UInt16 = 0x4000
        
        for line in 0...191 {
            fillFloatingData(line: line, fromAddress: address)
            address += 32
        }
    }

    private func getFloatDataAddress(tCycle: Int) -> UInt16? {
        guard 14339 <= tCycle && tCycle < 57344 else {
            return nil
        }
        
        return floatDataTable[tCycle - 14339]
    }

    func getFloatData(tCycle: Int) -> UInt8 {
        guard let address = getFloatDataAddress(tCycle: tCycle) else {
            return 0xFF
        }
        
        return memory.readNoContention(address)
    }
}
