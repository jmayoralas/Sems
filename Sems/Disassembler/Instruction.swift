//
//  Instruction.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 25/8/18.
//  Copyright © 2018 LomoCorp. All rights reserved.
//

import Foundation

class Instruction {
    var address: UInt16
    var opcode: UInt8
    var caption: String!
    
    private var params: [UInt8] = []
    
    init(address: UInt16, opcode: UInt8) {
        self.address = address
        self.opcode = opcode
    }
    
    func toString() -> String {
        return String(format: self.caption, paramsToString())
    }
    
    func addParam(param: UInt8) {
        params.append(param)
    }
    
    private func getParamsString() -> String? {
        guard params.count > 0 else { return nil }
        
        var p_str = ""
        
        for param in params {
            p_str.append(String(format: " %@", param.hexStr()))
        }
        
        return p_str
    }
    
    func clearParams() {
        self.params.removeAll()
    }
    
    func dump() -> String {
        var dump_str = String(format: "%@", self.opcode.hexStr())
        if let params_str = getParamsString() {
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
            data = params[0].hexStr()
        } else {
            data = addressFromPair(params[1], params[0]).hexStr()
        }
        
        return String(format: "0x%@", data)
    }
    
    private func addressFromPair(_ val_h: UInt8, _ val_l: UInt8) -> UInt16 {
        return UInt16(Int(Int(val_h) * 0x100) + Int(val_l))
    }
}

