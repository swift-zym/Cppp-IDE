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
    
    var title: String = ""
    var code: String = ""
    var image: NSImage?
    
    var completion: String?
    
    func encode(with coder: NSCoder) {
        
        coder.encode(title, forKey: "title")
        coder.encode(code, forKey: "code")
        coder.encode(image, forKey: "image")
        coder.encode(completion, forKey: "completion")
        
    }
    
    
    // MARK: - Initializers
    
    init(title: String, image: NSImage?, code: String, completion: String? = nil) {
        
        self.title = title
        self.code = code
        self.image = image
        self.completion = completion
        
    }
    
    required init?(coder: NSCoder) {
        
        let title = coder.decodeObject(forKey: "title") as? String
        let code = coder.decodeObject(forKey: "code") as? String
        let image = coder.decodeObject(forKey: "image") as? NSImage
        let completion = coder.decodeObject(forKey: "completion") as? String
        
        guard title != nil && code != nil else {
            return
        }
        
        self.title = title!
        self.code = code!
        self.image = image
        self.completion = completion
        
    }
    
}
