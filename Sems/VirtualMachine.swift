//
//  VirtualMachine.swift
//  z80
//
//  Created by Jose Luis Fernandez-Mayoralas on 31/12/15.
//  Copyright © 2015 lomocorp. All rights reserved.
//

import Foundation
import JMZeta80

struct SpecialKeys: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) { self.rawValue = rawValue }
    
    public static let capsShift = SpecialKeys(rawValue: 1)
    public static let symbolShift = SpecialKeys(rawValue: 1 << 1)
}

struct TapeBlockDirectoryEntry {
    public let type: String
    public let identifier: String
}

enum UlaKeyOperation {
    case down
    case up
}

private struct UlaUpdateData {
    var address: UInt8?
    var value: UInt8
}

@objc protocol VirtualMachineStatus {
    @objc optional func Z80VMScreenRefresh()
    @objc optional func Z80VMEmulationHalted()
}

class VirtualMachine
{
    // MARK: Properties
    public var delegate: VirtualMachineStatus?
    
    private let cpu: Cpu
    private let old_cpu: Z80
    private let ula: Ula
    private let old_ula: Ula
    private let clock: Clock
    private let bus: Bus16
    
    private let rom = Rom(base_address: 0x0000, block_size: 0x4000)
    
    private struct KeyboardRow {
        let address: UInt8
        let keys: [Character]
    }
    
    private var keyboard = [
        KeyboardRow(address: 0xFE, keys: ["-","z","x","c","v"]),
        KeyboardRow(address: 0xFD, keys: ["a","s","d","f","g"]),
        KeyboardRow(address: 0xFB, keys: ["q","w","e","r","t"]),
        KeyboardRow(address: 0xF7, keys: ["1","2","3","4","5"]),
        KeyboardRow(address: 0xEF, keys: ["0","9","8","7","6"]),
        KeyboardRow(address: 0xDF, keys: ["p","o","i","u","y"]),
        KeyboardRow(address: 0xBF, keys: ["*","l","k","j","h"]),
        KeyboardRow(address: 0x7F, keys: [" ","-","m","n","b"]),
    ]
    
    private let capsShiftUlaUpdateData = UlaUpdateData(address: 0xFE, value: 0b11111110)
    private let symbolShiftUlaUpdateData = UlaUpdateData(address: 0x7F, value: 0b11111101)
    private var previousSpecialKeys = SpecialKeys()
    
    private let tape: Tape
    private var instantLoad: Bool = false
    
    // MARK: Constructor
    public init(_ screen: VmScreen) {
        clock = Clock()
        bus = Bus16(clock: clock, screen: screen)
        cpu = Cpu(bus: bus, clock: clock)
        ula = Ula(screen: screen, clock: clock)
        tape = Tape(ula: ula)
        
        // connect the 16k ROM
        bus.addBusComponent(rom)
        
        // connect the ULA and his 16k of memory (this is a Spectrum 16k)
        bus.addBusComponent(ula.memory)
        bus.addIOBusComponent(ula.io)
        
        // add the upper 32k to emulate a 48k Spectrum
        let ram = Ram(base_address: 0x8000, block_size: 0x8000)
        bus.addBusComponent(ram)

        cpu.reset()
        
        let old_clock = Clock()
        let old_screen = VmScreen(zoomFactor: 1)
        old_ula = Ula(screen: old_screen, clock: old_clock)
        let old_bus = InternalBus(clock: old_clock, screen: old_screen)
        old_bus.addBusComponent(rom)
        old_cpu = Z80(dataBus: old_bus, ioBus: IoBus(clock: old_clock, screen: old_screen), clock: old_clock)
        old_cpu.dataBus.addBusComponent(old_ula.memory)
        old_cpu.ioBus.addBusComponent(old_ula.io)
        let old_ram = Ram(base_address: 0x8000, block_size: 0x8000)
        old_bus.addBusComponent(old_ram)
        
        old_cpu.reset()
    }
    
    // MARK: Methods
    public func reset() {
        tape.close()
        cpu.reset()
        
        old_cpu.reset()
    }
    
    public func run() {
        let queue = DispatchQueue.global()
        
        queue.async {
            repeat {
                self.step()
            } while true
        }
    }
    
    public func step() {
        tapeLoaderHook()
        
        clock.reset()
        old_cpu.clock.reset()
        
        cpu.executeNextOpcode()
        old_cpu.step()

        checkCpuStatus()

        tape.step()
        ula.step()
        old_ula.step()
        
        if clock.frameTCycles < 32 {
            cpu.int_req = true
            old_cpu.int = true
            
            if ula.screen.changed {
                ula.screen.updateScreenBuffer()
                delegate?.Z80VMScreenRefresh?()
            }
        } else {
            cpu.int_req = false
            old_cpu.int = false
        }
    }
    
    public func getInstructionsCount() -> Int {
        return 0
    }
    
    public func addIoDevice(_ port: UInt8) {
        bus.addIOBusComponent(GenericIODevice(base_address: UInt16(port), block_size: 1))
    }
    
    public func loadRamAtAddress(_ address: Int, data: [UInt8]) {
        for i in 0..<data.count {
            bus.write(UInt16(address + i), value: data[i])
        }
    }
    
    public func loadRomAtAddress(_ address: Int, data: [UInt8]) throws {
        try rom.loadData(data, atAddress: address)
    }
    
    public func getTCycle() -> Int {
        return clock.getCycles()
    }
    
    public func setPc(_ pc: UInt16) {
        cpu.org(pc)
    }
    
    public func clearMemory() {
        for address in 0x4000...0xFFFF {
            if (0x5800 <= address) && (address < 0x5B00) {
                bus.write(UInt16(address), value: 0x38)
            } else {
                bus.write(UInt16(address), value: 0x00)
            }
            
        }
        
        delegate?.Z80VMScreenRefresh?()
    }
    
    
    public func isRunning() -> Bool {
        return true
    }
    
    public func dumpMemoryFromAddress(_ fromAddress: Int, toAddress: Int) -> [UInt8] {
        return bus.dumpFromAddress(fromAddress, count: toAddress - fromAddress + 1)
    }
    
    public func toggleWarp() {
        self.ula.toggleAudio()
    }
    
    public func openTape(path: String) throws {
        try tape.open(path: path)
    }
    
    public func getBlockDirectory() throws -> [TapeBlockDirectoryEntry] {
        let blocks = try self.tape.getBlockDirectory()
        
        var blockDirectory = [TapeBlockDirectoryEntry]()
        
        for block in blocks {
            blockDirectory.append(TapeBlockDirectoryEntry(type: block.description, identifier: " "))
        }
        
        return blockDirectory
    }
    
    public func setCurrentTapeBlock(index: Int) throws {
        try self.tape.setCurrentBlock(index: index)
    }
    
    public func startTape() throws {
        try self.tape.start()
    }
    
    public func stopTape() {
        self.tape.stop()
    }
    
    public func tapeIsPlaying() -> Bool {
        return self.tape.isPlaying
    }
    
    public func enableInstantLoad() {
        self.instantLoad = true
        
        guard self.tape.tapeAvailable else {
            return
        }
        
        if self.tapeIsPlaying() {
            self.tape.stop()
        }
        
        self.tape.rewind()
    }
    
    public func disableInstantLoad() {
        self.instantLoad = false
        
        guard self.tape.tapeAvailable else {
            return
        }
        
        self.tape.rewind()
    }
    
    public func instantLoadEnabled() -> Bool {
        return self.instantLoad
    }
    
    // MARK: Tape loader
    private func tapeLoaderHook() {
        guard instantLoad && tape.tapeAvailable else {
            return
        }
        
        let buffer: [UInt8]?
        
        do {
            buffer = try tape.blockRequested()
        } catch {
            buffer = nil
        }
        
        cpu.tapeLoaderHook(buffer: buffer)
    }

    
    // MARK: Keyboard management
    public func keyDown(char: Character) {
        let (lchar, ulaUpdateData) = getEfectiveKeyData(char: char)
        
        if let data = ulaUpdateData {
            updateUla(operation: .up, data: capsShiftUlaUpdateData)
            updateUla(operation: .down, data: data)
        }
        
        updateUla(operation: .down, data: getKeyboardUlaUpdateData(char: lchar))
    }
    
    public func keyUp(char: Character) {
        let (lchar, ulaUpdateData) = getEfectiveKeyData(char: char)
        
        if let data = ulaUpdateData {
            updateUla(operation: .up, data: data)
        }
        
        updateUla(operation: .up, data: getKeyboardUlaUpdateData(char: lchar))
    }
    
    public func specialKeyUpdate(special_keys: SpecialKeys) {
        var op: UlaKeyOperation = special_keys.contains(SpecialKeys.capsShift) ? .down : .up
        if (!previousSpecialKeys.contains(SpecialKeys.capsShift) && op == .down) || (previousSpecialKeys.contains(SpecialKeys.capsShift) && op == .up) {
            updateUla(operation: op, data: capsShiftUlaUpdateData)
        }
        
        op = special_keys.contains(SpecialKeys.symbolShift) ? .down : .up
        if (!previousSpecialKeys.contains(SpecialKeys.symbolShift) && op == .down) || (previousSpecialKeys.contains(SpecialKeys.symbolShift) && op == .up) {
            updateUla(operation: op, data: symbolShiftUlaUpdateData)
        }
        
        previousSpecialKeys = special_keys
    }
    
    private func getEfectiveKeyData(char: Character) -> (Character, UlaUpdateData?) {
        // treat special combination for backspace
        var lchar: Character = char
        var ulaUpdateData: UlaUpdateData? = nil
        
        switch char {
        case "@":
            lchar = "0"
            ulaUpdateData = capsShiftUlaUpdateData
        case ",":
            lchar = "n"
            ulaUpdateData = symbolShiftUlaUpdateData
        case ";":
            lchar = "o"
            ulaUpdateData = symbolShiftUlaUpdateData
        case ":":
            lchar = "z"
            ulaUpdateData = symbolShiftUlaUpdateData
        case ".":
            lchar = "m"
            ulaUpdateData = symbolShiftUlaUpdateData
        case "-":
            lchar = "j"
            ulaUpdateData = symbolShiftUlaUpdateData
        case "+":
            lchar = "k"
            ulaUpdateData = symbolShiftUlaUpdateData
        case "<":
            lchar = "r"
            ulaUpdateData = symbolShiftUlaUpdateData
        case ">":
            lchar = "t"
            ulaUpdateData = symbolShiftUlaUpdateData
        default:
            break
        }
        
        return (lchar, ulaUpdateData)
    }
    
    private func updateUla(operation: UlaKeyOperation, data: UlaUpdateData) {
        if let address = data.address {
            switch operation {
            case .down:
                ula.keyDown(address: address, value: data.value)
                old_ula.keyDown(address: address, value: data.value)
            case .up:
                ula.keyUp(address: address, value: data.value)
                old_ula.keyUp(address: address, value: data.value)
            }
        }
    }
    
    private func getKeyboardUlaUpdateData(char: Character) -> UlaUpdateData  {
        var result = UlaUpdateData(address: nil, value: 0xFF)
        
        for row in keyboard {
            if row.keys.contains(char) {
                result.address = row.address
                result.value = getValue(char: char, keys: row.keys)
                break
            }
        }
        
        return result
    }
    
    private func getValue(char: Character, keys: [Character]) -> UInt8 {
        var value: UInt8 = 0xFF
        
        for (index,lchar) in keys.enumerated() {
            if lchar == char {
                value.resetBit(index)
            }
        }
        
        return value
    }
    
    private func checkCpuStatus() {
        let new_regs = cpu.getInternalRegisters()
        
        if  new_regs.pc != old_cpu.regs.pc ||
            new_regs.af != old_cpu.regs.af ||
            new_regs.bc != old_cpu.regs.bc ||
            new_regs.de != old_cpu.regs.de ||
            new_regs.hl != old_cpu.regs.hl ||
            new_regs.ix != old_cpu.regs.ix ||
            new_regs.iy != old_cpu.regs.iy ||
            ula.memory.read(0x5C3C) != old_ula.memory.read(0x5C3C) ||
            clock.getCycles() != old_cpu.clock.getCycles()
        {
            NSLog("new - clock: %d - frame cycles: %d - contention: %d", clock.getCycles(), clock.frameTCycles, clock.contentionTCycles)
            NSLog("    ir: 0x%02X - pc: 0x%04X - f: 0x%02X", new_regs.ir, new_regs.pc, cpu.getFlags())
            NSLog("    af: 0x%04X - bc: 0x%04X - de: 0x%02X", new_regs.af, new_regs.bc, new_regs.de)
            NSLog("    hl: 0x%04X - ix: 0x%04X - iy: 0x%02X", new_regs.hl, new_regs.ix, new_regs.iy)
            NSLog("old - clock: %d - frame cycles: %d - contention: %d", old_cpu.clock.getCycles(), old_cpu.clock.frameTCycles, old_cpu.clock.contentionTCycles)
            NSLog("    ir: 0x%02X - pc: 0x%04X - f: 0x%02X", old_cpu.regs.ir, old_cpu.regs.pc, old_cpu.regs.f)
            NSLog("    af: 0x%04X - bc: 0x%04X - de: 0x%02X", old_cpu.regs.af, old_cpu.regs.bc, old_cpu.regs.de)
            NSLog("    hl: 0x%04X - ix: 0x%04X - iy: 0x%02X", old_cpu.regs.hl, old_cpu.regs.ix, old_cpu.regs.iy)
            NSLog("End")
        }
    }
}
