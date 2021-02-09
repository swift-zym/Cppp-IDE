//
//  CDLanguageServerNotification.swift
//  C+++
//
//  Created by 23786 on 2021/2/9.
//  Copyright © 2021 Zhu Yixuan. All rights reserved.
//

import Cocoa

/// Class for processing notification.
class CDLanguageServerNotification: NSObject {
    
    private(set) var method: String = ""
    private(set) var params: Dictionary<String, Any> = [ : ]
    
    init(method: String, params: Dictionary<String, Any>) {
        self.params = params
        self.method = method
    }
    
    /// Convert the request to JSON Rpc data.
    func toData() throws -> Data {
        
        let dict = ["jsonrpc": "2.0", "method": self.method, "params": params] as [String : Any]
        let data = try JSONSerialization.data(withJSONObject: dict)
        let str = String(data: data, encoding: .utf8)
        guard str != nil else {
            throw CDLanguageServerError(description: "Error found when decoding data.")
        }
        let length = str!.count
        let headerData = "Content-Length: \(length)\r\n\r\n".data(using: .ascii)
        guard headerData != nil else {
            throw CDLanguageServerError(description: "Error found when encoding data.")
        }
        let newData = headerData! + data
        return newData
        
    }
    
}

