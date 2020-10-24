//
//  CDLuoguSubmitViewController.swift
//  C+++
//
//  Created by 23786 on 2020/10/24.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDLuoguSubmitViewController: NSViewController {
    
    @IBOutlet weak var pidTextField: NSTextField!
    @IBOutlet weak var enableO2: NSButton!
    var code: String = ""
    
    @IBAction func submit(_ sender: Any?) {
        LuoguAPIs.submit(
            code: code,
            for: self.pidTextField.stringValue,
            enableO2: (self.enableO2.state == .on ? 1 : 0)
        ) {
            (rid, message) in
            print("rid: \(rid)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
