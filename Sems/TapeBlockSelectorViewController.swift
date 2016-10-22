//
//  TapeBlockSelectorViewController.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 5/9/16.
//  Copyright © 2016 Jose Luis Fernandez-Mayoralas. All rights reserved.
//

import Cocoa
import Z80VirtualMachineKit

final class TapeBlockSelectorViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var tapeBlockList: NSTableView!

    private var blockDirectory: [TapeBlockDirectoryEntry]?
    
    func setBlockDirectory(blockDirectory: [TapeBlockDirectoryEntry]) {
        self.blockDirectory = blockDirectory
        self.tapeBlockList.reloadData()
        self.tapeBlockList.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
    }
    
    override func viewDidAppear() {
        self.view.window!.title = "Tape block selector"
    }
    
    @IBAction func chooseClick(_ sender: NSButton) {
        NSApplication.shared().stopModal(withCode: NSModalResponseOK)
    }
    
    @IBAction func cancelClick(_ sender: NSButton) {
        NSApplication.shared().stopModal(withCode: NSModalResponseCancel)
    }
    
    func getSelectedTapeBlockIndex() -> Int {
        return self.tapeBlockList.selectedRow
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        guard let directory = blockDirectory else {
            return 0
        }
        
        return directory.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cellView = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        cellView.textField!.font = NSFont.init(name: "Courier", size: 12)
        
        if tableColumn!.identifier == "identifier" {
            cellView.textField!.stringValue = blockDirectory![row].identifier
        } else {
            cellView.textField!.stringValue = blockDirectory![row].type
        }
        
        
        return cellView
    }
}
