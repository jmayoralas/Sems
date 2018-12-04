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
        vm.configureOldCpu()
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

    func testCpu_1() {
        let cpu_s = vm.oldCpu!
        
        cpu_s.bus.write(0x8288, value: 0xED)
        cpu_s.bus.write(0x8289, value: 0xA3)
        cpu_s.bus.write(0x880C, value: 0x86)
        cpu_s.cpu.regs.af = 0xAA2E
        cpu_s.cpu.regs.bc = 0x40FE
        cpu_s.cpu.regs.hl = 0x880C
        cpu_s.cpu.org(0x8288)
        cpu_s.clock.frameTCycles = 15117
        
        bus.write(0x8288, value: 0xED)
        bus.write(0x8289, value: 0xA3)
        bus.write(0x880C, value: 0x86)
        cpu.setRegisterAF(value: 0xAA2E)
        cpu.setRegisterBC(value: 0x40FE)
        cpu.setRegisterHL(value: 0x880C)
        cpu.org(0x8288)
        clock.frameTCycles = 15117

        vm.step()
        vm.stepOldCpu()
        
        XCTAssertEqual(cpu_s.clock.frameTCycles, clock.frameTCycles)
    }
    
    func testCpu_2() {
        let cpu_s = vm.oldCpu!
        
        cpu_s.cpu.org(0x05E2)
        cpu_s.clock.frameTCycles = 17061
        
        cpu.org(0x05E2)
        clock.frameTCycles = 17061
        
        vm.step()
        vm.stepOldCpu()
        
        XCTAssertEqual(cpu_s.clock.frameTCycles, clock.frameTCycles)
    }

}
