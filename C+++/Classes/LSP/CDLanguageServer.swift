//
//  CDLanguageServer.swift
//  C+++
//
//  Created by 23786 on 2021/1/3.
//  Copyright © 2021 Zhu Yixuan. All rights reserved.
//

import SwiftLSPClient
import Cocoa

class CDLanguageServer: NSObject {
    
    var server: LanguageServer?
    var filePath: String
    
    init(filePath: String) {
        self.filePath = filePath
    }
    
    func startServer() {
        
        let executablePath = "~/Library/C+++/clangd"
        let host = LanguageServerProcessHost(path: executablePath, arguments: [])
        
        host.start { (server) in
            
            guard let server = server else {
                NSLog("unable to launch server")
                return
            }
            
            self.server = server
            
            // Set-up notificationResponder to see log/error messages from LSP server
            server.notificationResponder = self

            let processId = Int(ProcessInfo.processInfo.processIdentifier)
            let capabilities = ClientCapabilities(workspace: nil, textDocument: TextDocumentClientCapabilities(synchronization: TextDocumentClientCapabilitySynchronization(dynamicRegistration: true, willSave: true, willSaveWaitUntil: true, didSave: true), completion: TextDocumentClientCapabilityCompletion(dynamicRegistration: true, completionItem: TextDocumentClientCapabilityCompletionItem(snippetSupport: true, commitCharactersSupport: true, documentationFormat: [.markdown, .plaintext], deprecatedSupport: true, preselectSupport: true), completionItemKind: TextDocumentClientCapabilityCompletionItemKind(valueSet: [.class, .color, .constant, .constructor, .function, .enum, .enumMember, .event, .field, .keyword, .method, .text, .struct, .unit, .typeParameter, .file, .folder, .reference, .property, .module, .operator, .interface])), hover: nil, formatting: nil, rangeFormatting: nil, onTypeFormatting: nil, publishDiagnostics: nil), experimental: nil)

            let params = InitializeParams(processId: processId,
                                          rootPath: nil,
                                          rootURI: nil,
                                          initializationOptions: nil,
                                          capabilities: capabilities,
                                          trace: Tracing.off,
                                          workspaceFolders: nil)

            self.server?.initialize(params: params, block: { (result) in
                switch result {
                case .failure(let error):
                    NSLog("unable to initialize\n\(error)")
                case .success(let value):
                    NSLog("initialized")
                }
            })
            
        }
        
    }
    
    func getCompletions(_ line: Int, _ character: Int, triggerString: String) {
        
        print("ok")
        
        if self.server != nil {
            
            do {
                self.server?.didOpenTextDocument(params: DidOpenTextDocumentParams(textDocument: try TextDocumentItem(contentsOfFile: self.filePath))) { (res) in
                    print(res ?? "No Error!")
                }
            } catch {
                
            }
            
            
            server?.completion(params: CompletionParams(uri: self.filePath, position: Position((line, character)), triggerKind: .triggerCharacter, triggerCharacter: triggerString)) { (result) in
                do {
                    let res = try result.get()
                    print(res.items)
                } catch {
                    print("failed, \(error)")
                }
            }
        } else {
            print("nil")
        }
        
    }
    
}


extension CDLanguageServer: NotificationResponder {
    
    func languageServer(_ server: LanguageServer, logMessage message: LogMessageParams) {
        print(message.message)
    }
    
    func languageServer(_ server: LanguageServer, showMessage message: ShowMessageParams) {
        print(message.message)
    }
    
    func languageServer(_ server: LanguageServer, showMessageRequest messageRequest: ShowMessageRequestParams) {
        print(messageRequest.message)
    }
    
    func languageServer(_ server: LanguageServer, publishDiagnostics diagnosticsParams: PublishDiagnosticsParams) {
        NSLog("Diagnostics Received\n")
    }
    
    func languageServer(_ server: LanguageServer, failedToDecodeNotification notificationName: String, with error: Error) {
        print(error)
    }
    
}
