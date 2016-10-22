//
//  Bus.swift
//  Z80VirtualMachineKit
//
//  Created by Jose Luis Fernandez-Mayoralas on 1/5/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation

class BusBase : BusComponent {
    var lastAddress: UInt16 = 0xFFFF
    
    var bus_components = [BusComponentBase]()
    var last_data: UInt8 = 0xFF
    
    func addBusComponent(_ bus_component: BusComponentBase) {
        bus_components.append(bus_component)
    }
    
    func deleteBusComponent(_ bus_component: BusComponentBase) {

    }
    
    override func write(_ address: UInt16, value: UInt8) {
        self.lastAddress = address
        super.write(address, value: value)
    }
    
    override func read(_ address: UInt16) -> UInt8 {
        self.lastAddress = address
        return super.read(address)
    }
}

final class IoBus: BusBase {
    private var io_components: [BusComponentBase]
    
    init() {
        let dummy_component = BusComponent(base_address: 0x0000, block_size: 0x0000)
        io_components = Array(repeating: dummy_component, count: 0x100)
        
        super.init(base_address: 0x0000, block_size: 0x100)
    }
    
    override func addBusComponent(_ bus_component: BusComponentBase) {
        // only asign non ula bus components to odd ports
        if bus_component.getBaseAddress() & 0x01 == 1 {
            io_components[Int(bus_component.getBaseAddress())] = bus_component
        } else {
            if bus_component is ULAIo {
                // even ports belongs to ULA
                for i in 0..<0x100 {
                    if (i & 0x01) == 0 {
                        io_components[i] = bus_component
                    }
                }
            }
        }
        super.addBusComponent(bus_component)
    }
    
    override func write(_ address: UInt16, value: UInt8) {
        // port addressed by low byte of address
        io_components[Int(address & 0x00FF)].write(address, value: value)
        
        super.write(address, value: value)
    }
    
    override func read(_ address: UInt16) -> UInt8 {
        let _ = super.read(address)
        
        // port addressed by low byte of address
        last_data = io_components[Int(address & 0x00FF)].read(address)
        
        return last_data
    }
}

final class Bus16 : BusBase {
    private var paged_components : [BusComponentBase]
    
    init() {
        let dummy_component = BusComponent(base_address: 0x0000, block_size: 0x0000)
        paged_components = Array(repeating: dummy_component, count: 64)
        
        super.init(base_address: 0x0000, block_size: 0x10000)
    }
    
    override func addBusComponent(_ bus_component: BusComponentBase) {
        super.addBusComponent(bus_component)

        for component in self.bus_components {
            let start = Int(component.getBaseAddress() / 1024)
            let end = start + component.getBlockSize() / 1024 - 1
            
            for i in start...end {
                paged_components[i] = component
            }
        }
    }
    
    override func write(_ address: UInt16, value: UInt8) {
        let index_component = Int(address) / 1024
        paged_components[index_component].write(address, value: value)
        
        super.write(address, value: value)
    }
    
    override func read(_ address: UInt16) -> UInt8 {
        let _ = super.read(address)
        let index_component = (Int(address) & 0xFFFF) / 1024
        
        return paged_components[index_component].read(address)
    }
    
    override func dumpFromAddress(_ fromAddress: Int, count: Int) -> [UInt8] {
        var index_component = (fromAddress & 0xFFFF) / 1024
        var address = fromAddress
        var result = [UInt8]()
        
        while result.count < count {
            result = result + paged_components[index_component].dumpFromAddress(address, count: count - result.count)
            index_component += 1
            address += result.count
        }
        
        return result
    }
}
