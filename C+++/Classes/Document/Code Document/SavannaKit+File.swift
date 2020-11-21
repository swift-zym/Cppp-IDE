//
//  SavannaKit+File.swift
//  C+++
//
//  Created by 23786 on 2020/11/3.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension SKSyntaxTextView {
    
    func setDocument(newDocument: CDCodeDocument) {
        self.textView.document = newDocument
        self.text = newDocument.content.contentString
    }
    
}
