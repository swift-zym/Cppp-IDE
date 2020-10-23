//
//  LuoguAPIs.swift
//  C+++
//
//  Created by 23786 on 2020/10/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class LuoguAPIs: NSObject {
    
    class func getCSRFToken() {

        let session = URLSession(configuration: .default)
        let url = "https://www.luogu.com.cn/"
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = session.dataTask(with: urlRequest) {(data, response, error) in
            
            if data == nil {
                return
            }
            let html = String.init(data: data!, encoding: .utf8)!
            
            let index = html.firstIndexOf("<meta name=\"csrf-token\" content=\"")
            let str = html[ html.index(html.startIndex, offsetBy: index + "<meta name=\"csrf-token\" content=\"".count)... ]
            let token = str[ ..<str.firstIndex(of: "=")! ]
            UserDefaults.standard.set(token, forKey: "csrf-token")
            
        }
        task.resume()

    }
    
    class func login(username: String, password: String, captcha: String) {
        
        let session = URLSession(configuration: .default)
        
        let url = "https://www.luogu.com.cn/api/auth/userPassLogin"
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "csrf-token")!, forHTTPHeaderField: "X-CSRF-Token")
        request.httpMethod = "POST"
        request.setValue("https://www.luogu.com.cn/auth/login", forHTTPHeaderField: "Referer")
        let postString = "{\"username\": \"\(username)\",\"password\": \"\(password)\",\"captcha\": \"\(captcha)\"}"
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if data == nil {
                DispatchQueue.main.async {
                    
                }
                return
            }
            do {
                let dicArr = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                do {
                    let r = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(r)
                } catch {
                    return
                }
                
                if dicArr["status"] != nil{
                    let code = dicArr["status"] as! Int
                    if code != 200 {
                        DispatchQueue.main.async {
                        }
                        return
                    }
                }
                
                DispatchQueue.main.async {
                    
                }
               
            } catch {
                return
            }
            
        }
        task.resume()
    }
    
}
