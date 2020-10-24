//
//  LuoguAPIs.swift
//  C+++
//
//  Created by 23786 on 2020/10/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//
//  Reference Materials:
//  - @sjx233 Luogu API Docs: https://github.com/sjx233/luogu-api-docs
//  - @swift-zym luogu-ios: https://github.com/swift-zym/luogu-ios
//

import Cocoa

class LuoguAPIs: NSObject {
    
    class func getCSRFToken() {
        
        let session = URLSession(configuration: .default)
        let url = "https://www.luogu.com.cn/"
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard data != nil else {
                return
            }
            let html = String(data: data!, encoding: .utf8)!
            let tmp=html.findAllIndex("<meta name=\"csrf-token\" content=\"")[0]
            var i = tmp.location + tmp.length
            var token = ""
            while true {
                token += html[
                    html.index(html.startIndex, offsetBy: i)...html.index(html.startIndex, offsetBy: i)
                ]
                if html[html.index(html.startIndex, offsetBy: i)] == "="{
                    break
                }
                i += 1
            }
            UserDefaults.standard.set(token, forKey: "csrf-token")

        }
        task.resume()

    }
    
    class func getCaptchaImage(_ completionHandler: @escaping (NSImage?) -> (Void)) {
        
        let session = URLSession(configuration: .default)
        let url = "https://www.luogu.com.cn/api/verify/captcha"
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            do {
                guard data != nil else {
                    return
                }
                DispatchQueue.main.sync {
                    completionHandler(NSImage(data: data!))
                }
            }
        }
        
        task.resume()
        
    }
    
    class func login(username: String, password: String, captcha: String, result: @escaping (Bool, String) -> (Void) ) {
        
        let session = URLSession(configuration: .default)
        
        let url = "https://www.luogu.com.cn/api/auth/userPassLogin"
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "csrf-token")!, forHTTPHeaderField: "X-CSRF-Token")
        request.httpMethod = "POST"
        request.setValue("https://www.luogu.com.cn/auth/login", forHTTPHeaderField: "Referer")
        let postString = "{\"username\": \"\(username.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)\",\"password\": \"\(password.addingPercentEncoding(withAllowedCharacters: .urlPasswordAllowed)!)\",\"captcha\": \"\(captcha.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)\"}"
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if data == nil {
                result(false, "Please check your internet connection.")
                return
            }
            do {
                let dicArr = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                print(dicArr)
                
                if dicArr["status"] != nil {
                    print("status isn't nil")
                    let code = dicArr["status"] as! Int
                    print(code)
                    if code != 200 {
                        result(false, dicArr["errorMessage"] as! String)
                        return
                    }
                }
                
                result(true, "Login Succeed.")
                UserDefaults.standard.setValue(username, forKey: "LuoguUserName")
                UserDefaults.standard.setValue(password, forKey: "LuoguPassword")
               
            } catch {
                result(false, "Received invalid data from luogu.com.cn.")
                return
            }
            
        }
        task.resume()
        
    }
    
    class func submit(code: String, for problem: String, enableO2: Int, result: @escaping (Int, String) -> (Void) ) {
        
        let session = URLSession(configuration: .default)
        
        let url = "https://www.luogu.com.cn/fe/api/problem/submit/\(problem.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "")"
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "csrf-token")!, forHTTPHeaderField: "X-CSRF-Token")
        request.httpMethod = "POST"
        request.setValue("https://www.luogu.com.cn/", forHTTPHeaderField: "Referer")
        let postString = "{\"code\": \"\(code.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "\"", with: "\\\"").replacingOccurrences(of: "\n", with: "\\n").replacingOccurrences(of: "\t", with: "\\t"))\", \"enableO2\": \"\(enableO2)\"}"
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if data == nil {
                result(-1, "Please check your internet connection.")
                return
            }
            do {
                let dicArr = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                print(dicArr)
                
                if dicArr["status"] != nil {
                    print("status isn't nil")
                    let code = dicArr["status"] as! Int
                    if code != 200 {
                        result(-1, "Error occurred. Code = \(code). Error = \(dicArr["errorMessage"] as! String)")
                        return
                    }
                }
                
                result(dicArr["rid"] as! Int, "Login Succeed.")
               
            } catch {
                result(-1, "Received invalid data from luogu.com.cn.")
                return
            }
            
        }
        task.resume()
        
    }
    
}
