//
//  CDCompileResultMessageBox.swift
//  C+++
//
//  Created by 23786 on 2020/10/27.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCompileResultMessageBox: NSViewController {
    
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    
    var isSuccess: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        switch isSuccess {
            case true:
                self.label?.stringValue = "Compile Succeed"
                self.imageView?.image = #imageLiteral(resourceName: "success")
            case false:
                self.label?.stringValue = "Compile Failed"
                self.imageView?.image = #imageLiteral(resourceName: "fail")
                
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {
            self.dismiss(self)
        }
    }
    
}
