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
            print(req.postBodyString ?? "NULL")
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
