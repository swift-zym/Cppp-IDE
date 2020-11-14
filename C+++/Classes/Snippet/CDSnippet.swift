//
//  CDSnippetTableViewCell.swift
//  C+++
//
//  Created by 23786 on 2020/5/7.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDSnippet: NSObject, NSCoding {
    
    // MARK: - Properties
    
    var title: String!
    var code: String!
    var image: NSImage!
    
    func encode(with coder: NSCoder) {
        
        coder.encode(title, forKey: "title")
        coder.encode(code, forKey: "code")
        coder.encode(image, forKey: "image")
        
    }
    
    
    // MARK: - Initializers
    
    init(title: String?, image: NSImage?, code: String?) {
        
        self.title = title
        self.code = code
        self.image = image
        
    }
    
    required convenience init?(coder: NSCoder) {
        
        let title = coder.decodeObject(forKey: "title") as? String
        let code = coder.decodeObject(forKey: "code") as? String
        let image = coder.decodeObject(forKey: "image") as? NSImage
        
        self.init(title: title, image: image, code: code)
        
    }
    
}
