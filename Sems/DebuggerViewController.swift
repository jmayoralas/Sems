//
//  DebuggerViewController.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 20/8/18.
//  Copyright © 2018 LomoCorp. All rights reserved.
//

import Cocoa

class DebuggerViewController: NSViewController {
    private var vm: VirtualMachine!
    private var disasm: Disassembler!
    
    public func setVM(vm: VirtualMachine) {
        self.vm = vm
        
        let data = self.vm.dumpMemoryFromAddress(0, toAddress: 0x1000)
        self.disasm = Disassembler(data: data)
        self.disasm.org(0x0000)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    @IBAction func stepClick(_ sender: NSButton) {
        self.disasm.step()
    }
}
