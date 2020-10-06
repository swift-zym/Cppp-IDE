//
//  CDCompileError.swift
//  C+++
//
//  Created by 23786 on 2020/10/5.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCompileError: NSObject {
    
    var file: String = ""
    var line: Int = 0
    var column: Int = 0
    var message: String = ""
    var type: Type = .unknown
    
    enum `Type`: Int {
        case error = 0
        case fatalError = 1
        case warning = 2
        case note = 3
        case unknown = 4
        
        var image: NSImage {
            switch self {
                case .error, .fatalError:
                    return #imageLiteral(resourceName: "error")
                case .warning:
                    return #imageLiteral(resourceName: "warning")
                case .note:
                    return #imageLiteral(resourceName: "note")
                default:
                    return #imageLiteral(resourceName: "Help")
            }
        }
        
    }
    
    var image: NSImage {
        return self.type.image 
    }

}
