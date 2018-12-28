//
//  DebuggerViewController.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 20/8/18.
//  Copyright © 2018 LomoCorp. All rights reserved.
//

import Cocoa

fileprivate struct InstructionDataCell {
    var address: String
    var dump: String
    var asm: String
}

class DebuggerViewController: NSViewController {
    private var vm: VirtualMachine!
    private var disasm: Disassembler!
    private var instructions = [InstructionDataCell]()
    
    @IBOutlet weak var disasmTableView: NSTableView!
    
    public func setVM(vm: VirtualMachine) {
        self.vm = vm
        
        self.disasm = Disassembler(dataBus: vm.getDataBus())
        self.disasm.org(0x0000)
        
        fillInstructions()
        
        disasmTableView.reloadData()
    }
    
    private func fillInstructions() {
        for _ in 0 ... 0xFF {
            let instruction = disasm.next()
            
            instructions.append(InstructionDataCell(
                address: String(format: "$%04X", instruction.address),
                dump: instruction.dump(),
                asm: instruction.toString()
            ))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        disasmTableView.dataSource = self
        disasmTableView.delegate = self
    }

    @IBAction func stepClick(_ sender: NSButton) {
        let instruction = self.disasm.next()
        
        NSLog("$%04X: %@ %@", instruction.address, instruction.dump(), instruction.toString())
    }
}

extension DebuggerViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return instructions.count
    }
}

extension DebuggerViewController: NSTableViewDelegate {
    fileprivate enum ColumnIdentifiers {
        static let AddressColumn = "addressColumnId"
        static let DumpColumn = "dumpColumnId"
        static let AsmColumn = "asmColumnId"
    }
    
    fileprivate enum CellIdentifiers {
        static let AddressCell = "addressCellId"
        static let DumpCell = "dumpCellId"
        static let AsmCell = "asmCellId"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier: String = ""
        var cellText: String = ""
        let instructionDataCell = instructions[row]
        
        switch tableColumn!.identifier.rawValue {
        case ColumnIdentifiers.AddressColumn:
            cellIdentifier = CellIdentifiers.AddressCell
            cellText = instructionDataCell.address
        case ColumnIdentifiers.DumpColumn:
            cellIdentifier = CellIdentifiers.DumpCell
            cellText = instructionDataCell.dump
        case ColumnIdentifiers.AsmColumn:
            cellIdentifier = CellIdentifiers.AsmCell
            cellText = instructionDataCell.asm
        default:
            return nil
        }
        
        let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(cellIdentifier), owner: nil) as! NSTableCellView
        cellView.textField!.stringValue = cellText

        return cellView
    }
}
