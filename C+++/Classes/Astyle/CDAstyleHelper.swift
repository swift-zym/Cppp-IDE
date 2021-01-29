//
//  CDAstyleHelper.swift
//  C+++
//
//  Created by 23786 on 2021/1/29.
//  Copyright © 2021 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDAstyleHelper: NSObject {
    
    class func astyleFile(code: String, options: String = CDSettings.astyleOptions, handler: @escaping ( (String?, Bool) -> Void) ) {
        
        let filePath = "/Users/apple/Library/C+++/AstyleTemp.cpp".nsString.expandingTildeInPath
        
        FileManager.default.createFile(atPath: filePath, contents: code.data(using: .utf8))
        
        let task = Process()
        task.launchPath = "~/Library/C+++/bin/astyle"
        task.arguments = options.components(separatedBy: .whitespacesAndNewlines) + [filePath]
        task.launch()
        
        task.terminationHandler = { (task) in
            
            NSLog("Astyle process exited with exit code \(task.terminationStatus)")
            let content = FileManager.default.contents(atPath: filePath)
            guard content != nil else {
                handler(nil, false)
                return
            }
            guard let str = String(data: content!, encoding: .utf8) else {
                handler(nil, false)
                return
            }
            handler(str, true)
            
        }
        
    }
    
}
