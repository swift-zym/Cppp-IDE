//
//  CDCodeDocument+Compile.swift
//  C+++
//
//  Created by 23786 on 2020/8/1.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension CDCodeDocument {
    
    @discardableResult
    func compileFile(alsoRuns: Bool = true, arguments: String = CDCompileSettings.shared.arguments) -> (log: String, result: CDCompileResult?, didSuccess: Bool) {
        
        self.endDebugging()
        
        if self.fileURL == nil {
            self.contentViewController?.showAlert("Error", "You haven't saved your file yet. You must save your file before compiling it.")
            return (log: "", result: nil, didSuccess: false)
        }
        
        let nsString = self.fileURL!.path.nsString
        
        let path = nsString.deletingLastPathComponent
         
        // The path of the file
        let _fileURL = "\"" + nsString.lastPathComponent + "\""
        
        // Create the name of the output exec
        let out = "\"" + nsString.lastPathComponent.nsString.deletingPathExtension + "\""
        
        // The compile command
        let command = "cd \"\(path)\"\n" + "\(CDCompileSettings.shared.compiler ?? "g++") \(arguments) \(_fileURL) -o \(out)"
        
        // Compile
        let compileResult = runShellCommand(command)
        
        var result = ""
        var didSuccess = false
        
        if compileResult.count == 1 {
            
            // Success
            result = "Compile Command:\n\n\(command)\n\nCompile Succeed"
            self.contentViewController?.setStatus(string: "\(self.fileURL!.lastPathComponent) | Compile Succeed")
            didSuccess = true
            
        } else {
            
            // Error
            if (compileResult[1].contains(" error: ")) {
                
                didSuccess = false
                self.contentViewController?.setStatus(string: "\(self.fileURL!.lastPathComponent) | Compile Failed")
                result = "Compile Command:\n\n\(command)\n\nCompile Failed\n\n" + compileResult[1]
                 
            } else /* Warning */ {
                
                didSuccess = true
                self.contentViewController?.setStatus(string: "\(self.fileURL!.lastPathComponent) | Compile Succeed")
                result = "Compile Command:\n\n\(command)\n\nCompile Succeed\n\n" + compileResult[1]
            }
            
        }
        
        // result = result.replacingOccurrences(of: self.fileURL!.lastPathComponent + ":", with: "")
        
        if didSuccess {
            sendUserNotification(title: "Compile Succeed", subtitle: "\(self.fileURL!.lastPathComponent)")
        } else {
            sendUserNotification(title: "Compile Failed", subtitle: "\(self.fileURL!.lastPathComponent)")
        }
        
        if alsoRuns && didSuccess {
            let process = processForShellCommand(command: "cd \"\(path)\"\n" + "open \(out)")
            process.launch()
            self.runTask = process
        }
        
        self.contentViewController?.consoleView?.textView?.string = result
        
        let res = parseCompileResult(result: result)
            
        /*DispatchQueue.main.async {
            
            for i in result.components(separatedBy: "\n") {
                if i.first == nil {
                    continue
                }
                if i.first!.isNumber && i.contains(":") {
                    let index = i.firstIndexOf(":")
                    let nsstring = NSString(string: i)
                    let substring = nsstring.substring(to: index)
                    if let int = Int(substring) {
                        self.contentViewController?.lineNumberView?.buttonsArray[int - 1].markAsErrorLine()
                    }
                }
            }
            
        }*/
        
        return (log: result, result: res, didSuccess: didSuccess)
        
    }
    
    
    
    
    @IBAction func compileFile(_ sender: Any?) {
        
        let res = self.compileFile(alsoRuns: true)
        self.latestCompileResult = res.result
        self.contentViewController?.consoleView?.tableView?.dataSource = self.latestCompileResult!
        
    }
    
    
    
    @IBAction func testFile(_ sender: Any?) {
        
        let vc = CDTestViewController()
        vc.fileURL = self.fileURL?.path ?? ""
        self.contentViewController.presentAsSheet(vc)
        
    }
    
    
    
    @IBAction func compileWithoutRunning(_ sender: Any?) {
        
        self.compileFile(alsoRuns: false)
        
    }
    
    private func parseCompileResult(result: String) -> CDCompileResult {
        
        func parseLine(line l: String) -> CDCompileError? {
            // g++ output format:
            // [file]:[line]:[column]: [errorType]: [message]
            
            var line = l // mutable copy
            let new = CDCompileError()
            
            // Parse file
            let firstIndex = line.firstIndex(of: ":")
            guard firstIndex != nil else {
                return nil
            }
            new.file = String(line[..<firstIndex!])
            line.removeSubrange(...firstIndex!)
            
            // Parse line number
            let secondIndex = line.firstIndex(of: ":")
            guard secondIndex != nil else {
                return nil
            }
            let str = String(line[..<secondIndex!])
            guard let lineNumber = Int(str) else {
                return nil
            }
            new.line = lineNumber
            line.removeSubrange(...secondIndex!)
            
            // Parse column number
            let thirdIndex = line.firstIndex(of: ":")
            guard thirdIndex != nil else {
                return nil
            }
            let str2 = String(line[..<thirdIndex!])
            guard let columnNumber = Int(str2) else {
                return nil
            }
            new.column = columnNumber
            line.removeSubrange(...thirdIndex!)
            line.remove(at: line.startIndex) // space
            
            // Parse error type
            let fourthIndex = line.firstIndex(of: ":")
            guard fourthIndex != nil else {
                return nil
            }
            let str3 = String(line[..<fourthIndex!])
            switch str3 {
                case "error":
                    new.type = .error
                case "fatal error":
                    new.type = .fatalError
                case "warning":
                    new.type = .warning
                case "note":
                    new.type = .note
                default:
                    new.type = .unknown
            }
            line.removeSubrange(...fourthIndex!)
            line.remove(at: line.startIndex)
            
            new.message = line
            
            return new
            
        }
        
        var res = [CDCompileError]()
        for line in result.components(separatedBy: .newlines) {
            
            if let error = parseLine(line: line) {
                res.append(error)
            }
            
        }
        let new = CDCompileResult()
        new.errors = res
        new.calculateErrorAndWarningCount()
        return new
        
    }
    
}
