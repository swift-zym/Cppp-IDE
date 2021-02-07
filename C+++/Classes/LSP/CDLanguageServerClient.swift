//
//  CDLanguageServer.swift
//  C+++
//
//  Created by 23786 on 2021/1/3.
//  Copyright © 2021 Zhu Yixuan. All rights reserved.
//

import SwiftLSPClient
import Cocoa

// TODO
extension Notification.Name {
    static let languageServerDidOpenDocument = NSNotification.Name(rawValue: "LanguageServerDidOpenDocument")
    static let languageServerDidInit = NSNotification.Name(rawValue: "LanguageServerDidInit")
}

class CDLanguageServerClient: NSObject {
    
    private var server: LanguageServer?
    private var process: Process?
    private let inputPipe = Pipe()
    private let outputPipe = Pipe()
    private let errorPipe = Pipe()
    private var id: Int = 1
    var delegate: CDLanguageServerClientDelegate?
    
    func startServer(path: String = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clangd", arguments: [String] = []) {
        
        let process = Process()
        process.launchPath = path
        process.arguments = arguments
        
        process.standardInput = inputPipe
        process.standardOutput = outputPipe
        process.standardError = errorPipe
        
        outputPipe.fileHandleForReading.readabilityHandler = { (fileHandle) in
            
            self.readResponse(fileHandle.availableData)
            
        }
        
        errorPipe.fileHandleForReading.readabilityHandler = { (fileHandle) in
            
            NSLog("stderr: \(String(data: fileHandle.availableData, encoding: .utf8) ?? "ERROR")")
            
        }
        
        process.launch()
        
        inputPipe.fileHandleForWriting.write(
            """
            Content-Length: 123
            
            {"jsonrpc":"2.0","id":1,"method":"initialize","params":{"capabilities":{},"trace":"off","processId":\(Int(ProcessInfo.processInfo.processIdentifier)),"rootPath":"\\/"}}
            """.data(using: .utf8)! )
        
    }
    
    func openDocument(path: String, content: String) {
        
        id += 1
        let request = CDLanguageServerRequest(
            method: "textDocument/didOpen",
            id: id, params: [
                "textDocument": [
                    "languageId": "cpp",
                    "text": content,
                    "uri": URL(fileURLWithPath: path).absoluteString,
                    "version": 1
                ]
            ]
        )
        self.writeRequest(request)
        
    }
    
    private func writeRequest(_ request: CDLanguageServerRequest) {
        
        let data = try? request.toData()
        guard data != nil else {
            return
        }
        self.inputPipe.fileHandleForWriting.write(data!)
        
    }
    
}
