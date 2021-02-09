//
//  CDLanguageServerResponse.swift
//  C+++
//
//  Created by 23786 on 2021/2/7.
//  Copyright © 2021 Zhu Yixuan. All rights reserved.
//

import Foundation

extension CDLanguageServerClient {
    
    
    func readResponse(_ data: Data) {
        
        do {
            let response = try CDLanguageServerResponse(from: data)
            
            switch response.method {
                case "textDocument/publishDiagnostics":
                    processDiagnostics(response: response)
                default:
                    break
            }
            
        } catch {
            print(error)
        }
        
    }
    
    private func processDiagnostics(response: CDLanguageServerResponse) {
        
        let uri = response.params["uri"]
        guard let str = uri as? String, let url = URL(string: str)?.path else {
            return
        }
        let diagnostics = response.params["diagnostics"]
        guard let array = diagnostics as? [Dictionary<String, Any>] else {
            return
        }
        
        var diagnosticsArray = [CDDiagnostic]()
        
        for item in array {
            diagnosticsArray.append( CDDiagnostic(dict: item) )
        }
        
        self.delegate?.receivedDiagnostics(for: url, diagnostics: diagnosticsArray)
        
    }
    
    
}


/// Class for processing response fom the LSP.
/// `textDocument/publishDiagnostics` is considered as server response (actually, it is a request from the server) in this class.
class CDLanguageServerResponse: NSObject {
    
    private(set) var params: Dictionary<String, Any> = [ : ]
    private(set) var res: Dictionary<String, Any> = [ : ]
    private(set) var error: Dictionary<String, Any> = [ : ]
    private(set) var id: Int = -1
    private(set) var method: String = ""
    
    /// Initialize a response object from the data.
    init(from data: Data) throws {
        
        guard let str = String(data: data, encoding: .utf8) else {
            throw CDLanguageServerError(description: "Error found when decoding data.")
        }
        
        let components = str.components(separatedBy: "\r\n")
        for component in components {
            do {
                let dict = try JSONSerialization.jsonObject(with: component.data(using: .utf8)!) as? Dictionary<String, Any>
                guard dict != nil else {
                    print("is nil")
                    continue
                }
                self.id = dict!["id"] as? Int ?? -1
                if dict!.keys.contains("error") {
                    self.error = dict!["error"] as! Dictionary<String, Any>
                    throw CDLanguageServerError(description: "Error from language server: \(error["message"] ?? "<Get Error Description Failed.>")")
                }
                self.method = dict!["method"] as? String ?? ""
                if dict!.keys.contains("result") {
                    self.res = dict!["result"] as! Dictionary<String, Any>
                } else if dict!.keys.contains("params") {
                    self.params = dict!["params"] as! Dictionary<String, Any>
                }
                return
            } catch {
                if error is CDLanguageServerError {
                    throw error
                }
                continue
            }
        }
        
        throw CDLanguageServerError(description: "Error found when decoding data.")
        
    }
    
}

struct CDSourceFileLocation {
    
    var line: Int = 0
    var character: Int = 0
    
    init(dict: [String : Any]) {
        self.line = dict["line"] as! Int
        self.character = dict["character"] as! Int
    }
    
}

struct CDSourceFileRange {
    
    var start: CDSourceFileLocation
    var end: CDSourceFileLocation
    
    init(dict: [String : Any]) {
        self.start = CDSourceFileLocation(dict: dict["start"] as! [String : Any])
        self.end = CDSourceFileLocation(dict: dict["end"] as! [String : Any])
    }
    
}

struct CDDiagnostic {
    
    enum Severity: Int {
        case error = 1
        case warning = 2
        case information = 3
        case hint = 4
    }
    
    var code: String? = ""
    var message: String? = ""
    var range: CDSourceFileRange?
    var severity: Severity? = .error
    var source: String? = ""
    
    init(dict: [String : Any]) {
        self.code = dict["code"] as? String
        self.message = dict["message"] as? String
        let raw = dict["severity"] as? Int
        if raw != nil {
            self.severity = Severity(rawValue: raw!)
        }
        self.source = dict["source"] as? String
        self.range = CDSourceFileRange(dict: dict["range"] as! [String : Any])
    }
    
}
