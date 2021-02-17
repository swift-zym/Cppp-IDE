//
//  CDServer.swift
//  C+++
//
//  Created by 张一鸣 on 2021/2/17.
//  Copyright © 2021 Zhu Yixuan. All rights reserved.
//

import Foundation
import PerfectLib
import PerfectNet
import PerfectThread
import PerfectHTTP
import PerfectHTTPServer

fileprivate var _sharedServer = CDServer()

class CDServer : NSObject{
    func start(){
        let ccRoute=Route(method: .post, uri: "/", handler: {
            req,res in
            if req.postBodyString == nil{
                return
            }
            let json = try! JSONSerialization.jsonObject(with: (req.postBodyString?.data(using: .utf8))!, options: .mutableContainers) as AnyObject
            let tests = json["tests"] as! [AnyObject]
            var inputs=[String](),outputs=[String]()
            for test in tests{
                inputs.append(test["input"] as! String)
                outputs.append(test["output"] as! String)
            }
            DispatchQueue.main.async {
                let newDocument = CDCodeDocument()
                newDocument.content=CDDocumentContent(contentString: """
                //
                // problem name:\(json["name"] as! String)
                // problem link:\(json["url"] as! String)
                // memory limit:\(json["memoryLimit"] as! Int)
                // time limit:\(json["timeLimit"] as! Int)
                //
                """)
                
                GlobalMainWindowController.addDocument(newDocument)
                if inputs.count != 0{
                    GlobalMainWindowController.mainViewController.consoleView.runView.input?.text=inputs[0]
                    GlobalMainWindowController.mainViewController.consoleView.runView.expectedOutput?.text=outputs[0]
                }
            }
        })
        let serialQueue = DispatchQueue.init(label: "", qos: .default, attributes: [.concurrent], autoreleaseFrequency: .inherit, target: nil)
        serialQueue.async {
            do {
                try HTTPServer.launch(name: "localhost", port: 10047, routes: [ccRoute])
            } catch {
                print(error)
            }
        }
    }
    class var shared: CDServer {
        return _sharedServer
    }
}
