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
    class func compileFile(fileURL: URL, alsoRuns: Bool = true, arguments: String = CDSettings.compileArguments, postsNotification: Bool = true) -> (log: String, result: CDCompileResult?) {
        
        let nsString = fileURL.path.nsString
        
        let path = nsString.deletingLastPathComponent
         
        // The path of the file
        let _fileURL = "\"" + nsString.lastPathComponent + "\""
        
        // Create the name of the output exec
        let out = "\"" + nsString.lastPathComponent.nsString.deletingPathExtension + "\""
        
        // The compile command
        let command = "cd \"\(path)\"\n" + "\(CDSettings.compiler) \(arguments) \(_fileURL) -o \(out)"
        
        // Compile
        let compileResult = runShellCommand(command)
        
        var result = ""
        
        if compileResult.count == 1 {
            
            // Success
            result = "Compile Command:\n\n\(command)\n\nCompile Succeed"
            
        } else {
            
            result = "Compile Command:\n\n\(command)\n\nCompile Failed\n\n" + compileResult[1]
            
        }
        
        let res = parseCompileResult(result: result)
        
        /*if postsNotification {
            if res.succeed {
                NSObject().sendUserNotification(title: "Compile Succeed", subtitle: "\(fileURL.lastPathComponent)")
            } else {
                NSObject().sendUserNotification(title: "Compile Failed", subtitle: "\(fileURL.lastPathComponent)")
            }
            
        }*/
        
        if alsoRuns && res.succeed {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.10) {
                // let process = processForShellCommand(command: "cd \"\(path)\"\n" + "./\(out)")
                // process.launch()
                CDRunProcessViewController.run(command: "cd \"\(path)\"\n" + "./\(out)", name: fileURL.deletingPathExtension().lastPathComponent)
            }
        }
        
        return (log: result, result: res)
        
    }
    
    
    
    
    @IBAction func compileFile(_ sender: Any?) {
        
        guard self.fileURL != nil else {
            self.contentViewController?.showAlert("Error", "Please save your file first before compiling.")
            return
        }
        
        let res = CDCodeDocument.compileFile(fileURL: self.fileURL!, alsoRuns: true)
        
        if res.result != nil {
            for error in res.result!.errors {
                guard error.file == self.fileURL?.lastPathComponent else {
                    continue
                }
                switch error.type {
                    case .error, .fatalError:
                        self.contentViewController.lineNumberView.buttonsArray[error.line - 1].markAsErrorLine()
                    case .warning:
                        self.contentViewController.lineNumberView.buttonsArray[error.line - 1].markAsWarningLine()
                    case .note, .unknown:
                        self.contentViewController.lineNumberView.buttonsArray[error.line - 1].markAsNoteLine()
                }
            }
        }
        
        self.contentViewController?.consoleView?.compileResult = res.result
        self.contentViewController?.consoleView?.logView?.string = res.log
        
        let vc = CDCompileResultMessageBox()
        vc.isSuccess = (res.result?.succeed) ?? false
        self.contentViewController?.presentAsSheet(vc)
        
    }
    
    
    
    @IBAction func testFile(_ sender: Any?) {
        
        let vc = CDTestViewController()
        vc.fileURL = fileURL?.path ?? ""
        self.contentViewController.presentAsSheet(vc)
        
    }
    
    
    
    @IBAction func compileWithoutRunning(_ sender: Any?) {
        
        guard self.fileURL != nil else {
            self.contentViewController?.showAlert("Error", "Please save your file first before compiling.")
            return
        }
        
        let res = CDCodeDocument.compileFile(fileURL: self.fileURL!, alsoRuns: false)
        
        if res.result != nil {
            for error in res.result!.errors {
                switch error.type {
                    case .error, .fatalError:
                        self.contentViewController.lineNumberView.buttonsArray[error.line - 1].markAsErrorLine()
                    case .warning:
                        self.contentViewController.lineNumberView.buttonsArray[error.line - 1].markAsWarningLine()
                    case .note, .unknown:
                        self.contentViewController.lineNumberView.buttonsArray[error.line - 1].backgroundColor = .systemGray
                }
            }
        }
        
        self.contentViewController?.consoleView?.compileResult = res.result
        self.contentViewController?.consoleView?.logView?.string = res.log
        
        
        let vc = CDCompileResultMessageBox()
        vc.isSuccess = (res.result?.succeed) ?? false
        self.contentViewController?.presentAsSheet(vc)
        
    }
    
    private class func parseCompileResult(result: String) -> CDCompileResult {
        
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
