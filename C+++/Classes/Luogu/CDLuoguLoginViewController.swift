//
//  CDLuoguLoginViewController.swift
//  C+++
//
//  Created by 23786 on 2020/10/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDLuoguLoginViewController: NSViewController {
    
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var captchaTextField: NSTextField!
    @IBOutlet weak var captchaImageButton: NSButton!
    
    @IBAction func login(_ sender: Any?) {
        LuoguAPIs.login(
            username: self.usernameTextField.stringValue,
            password: self.passwordTextField.stringValue,
            captcha: self.captchaTextField.stringValue
        ) { (result, string) in
            DispatchQueue.main.async {
                self.showAlert(string, "")
            }
        }
    }
    
    @IBAction func changeCaptcha(_ sender: Any?) {
        LuoguAPIs.getCaptchaImage {
            (image) in
            self.captchaImageButton.image = image
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        changeCaptcha(nil)
    }
    
}
