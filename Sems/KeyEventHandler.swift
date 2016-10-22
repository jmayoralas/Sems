//
//  KeyEventHandler.swift
//  DebuggerZ80VirtualMachine
//
//  Created by Jose Luis Fernandez-Mayoralas on 20/6/16.
//  Copyright © 2016 lomocorp. All rights reserved.
//

import Foundation
import Cocoa
import Z80VirtualMachineKit

class KeyEventHandler {
    static func getChar(event: NSEvent) -> Character {
        let number_key_codes: [UInt16] = [29, 18, 19, 20, 21, 23, 22, 26, 28, 25]
        
        let char: Character
        
        if let index = number_key_codes.index(of: event.keyCode) {
            char = Character(String(index))
        } else {
            switch event.keyCode {
            case 36:
                char = "*" // enter key
            case 51:
                char = "@" // backspace key
            default:
                char = Character(event.charactersIgnoringModifiers!.lowercased())
            }
        }
        
        return char
    }
    
    static func getSpecialKeys(event: NSEvent) -> SpecialKeys {
        // get caps shift (Shift), symbol shift (Control) and enter (Return) keys from NSEvent keyCode
        var special_keys = SpecialKeys()
        
        if event.modifierFlags.contains(.shift) {
            (_,_) = special_keys.insert(.capsShift)
        }
        
        if event.modifierFlags.contains(.control) {
            (_,_) = special_keys.insert(.symbolShift)
        }
    
        return special_keys
    }
}
