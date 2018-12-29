//
//  SemsTests.swift
//  SemsTests
//
//  Created by Jose Luis Fernandez-Mayoralas on 15/11/18.
//  Copyright © 2018 LomoCorp. All rights reserved.
//

import XCTest
@testable import Sems
import JMZeta80

class SemsTests: XCTestCase {
    var vm: VirtualMachine!
    var clock: Clock!
    var screen: VmScreen!
    var bus: Bus16!
    var cpu: Cpu!
    var ula: Ula!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        clock = Clock()
        screen = VmScreen(zoomFactor: 1)
        bus = Bus16(clock: clock, screen: screen)
        cpu = Cpu(bus: bus, clock: clock)
        ula = Ula(screen: screen, clock: clock)
        
        vm = VirtualMachine(bus: bus, cpu: cpu, ula: ula, clock: clock, screen: screen)
        loadRomData()
    }
    
    private func loadRomData() {
        let data = NSDataAsset(name: "Rom48k")!.data as NSData
        var buffer = [UInt8](repeating: 0, count: data.length)
        (data as NSData).getBytes(&buffer, length: data.length)
        
        try! self.vm.loadRomAtAddress(0x0000, data: buffer)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func write(data: [UInt8], atAddress address: UInt16, inBus bus: Bus16) {
        var laddress = address
        
        for byte in data {
            bus.write(laddress, value: byte)
            laddress += 1
        }
    }

    func testScreenTiming() {
        cpu.org(0x8000)
        
        write(data: [0x3E, 0x06, 0xD3, 0xFE], atAddress: 0x8000, inBus: bus)
        
        clock.frameTCycles = 14112 - 11 - 7
        vm.step()
        vm.step()
        XCTAssertEqual(clock.frameTCycles, 14112)
    }
    
    func testDisasmDDCB() {
        let disasm = Disassembler(dataBus: bus)
        cpu.org(0x8000)
        disasm.org(0x8000)
        
        write(data: [0xDD, 0xCB, 0xFE, 0x00], atAddress: 0x8000, inBus: bus)
        let inst = disasm.next()
        XCTAssertEqual(inst.toString(), "rlc (ix+$FE) -> b")
    }
    
    func testDisasmFD() {
        let disasm = Disassembler(dataBus: bus)
        cpu.org(0x8000)
        disasm.org(0x8000)
        
        write(data: [0xFD, 0xBE, 0xFE], atAddress: 0x8000, inBus: bus)
        let inst = disasm.next()
        XCTAssertEqual(inst.toString(), "cp (iy+$FE)")
    }
}
