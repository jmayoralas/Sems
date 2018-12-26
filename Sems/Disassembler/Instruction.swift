//
//  Instruction.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 25/8/18.
//  Copyright © 2018 LomoCorp. All rights reserved.
//

import Foundation

class Instruction {
    var address: UInt16!
    var opcode: UInt8!
    var bytes: [UInt8] = []
    var caption: String!
    
    private var params: [UInt8] = []
    
    func toString() -> String {
        return String(format: self.caption, paramsToString())
    }
    
    func addParam(param: UInt8) {
        params.append(param)
    }
    
    func addOpcodeByte(byte: UInt8) {
        bytes.append(byte)
        opcode = byte
    }
    
    private func getParamsString() -> String? {
        return arrayToString(params)
    }
    
    private func getBytesString() -> String {
        return arrayToString(bytes)!
    }
    
    private func arrayToString(_ a: [UInt8]) -> String? {
        guard a.count > 0 else { return nil }
        
        var p_str = ""
        
        for value in a {
            if p_str.count > 0 { p_str.append(" ") }
            p_str.append(String(format: "%@", value.hexStr()))
        }
        
        return p_str
    }
    
    func clearParams() {
        self.params.removeAll()
    }
    
    func clearBytes() {
        self.bytes.removeAll()
    }
    
    func dump() -> String {
        var dump_str = getBytesString()
        
        if let params_str = getParamsString() {
            dump_str.append(" ")
            dump_str.append(params_str)
        }
        
        return dump_str
    }
    
    private func paramsToString() -> String {
        var data = ""
        
        guard self.params.count > 0 else {
            return data
        }
        
        if params.count == 1 {
            data = String(format: "0x%02X", params[0])
        } else {
            data = String(format: "0x%04X", addressFromPair(params[1], params[0]))
        }
        
        return String(format: "0x%@", data)
    }
    
    private func addressFromPair(_ val_h: UInt8, _ val_l: UInt8) -> UInt16 {
        return UInt16(Int(Int(val_h) * 0x100) + Int(val_l))
    }
}

