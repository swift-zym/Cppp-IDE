//
//  CDLuoguRecordViewer.swift
//  C+++
//
//  Created by 23786 on 2020/10/25.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDLuoguRecordViewer: NSViewController {
    
    @IBOutlet weak var titleLabel: NSTextField!
    var rid: Int = -1
    var count: Int = 0
    var testCases: [String : (status: Int, time: Int, memory: Int, score: Int, subtaskID: Int, description: String)] = [ : ]
    
    /*
     currentData: {
         record: {
             detail: {
                compileResult: {
                    success, message;
                }
                judgeResult: {
                    subtasks: [ {
                        id, score, status, testcases: [ {
                            id, status, time, memory, score, signal, exitCode, description, subtaskID;
                        ] }, time, memory;
                    } ]
                    finishedCaseCount;
                }
                time, memory, contest, status, enableO2, score;
            }
        },
        testCaseGroup;
     }
     */
    
    func parseDictionary(dic: Dictionary<String, AnyObject>) {
        
        let currentData = dic["currentData"] as! [String : AnyObject]
        let detail = currentData["record"] as! [String : AnyObject]
        /*let compileResult = detail["compileResult"] as! [String : AnyObject]*/
        /*let testCaseGroupCount = (currentData["testCaseGroup"] as! [ Any ]).count*/
        let judgeResult = detail["judgeResult"] as! [String : AnyObject]
        let subtasks = judgeResult["subtasks"] as! [ [String : AnyObject] ]
        let count = judgeResult["finishedCaseCount"] as! Int
        
        self.count = count
        
        for subtask in subtasks {
            
            let testCases = subtask["testCases"] as! [ [String : AnyObject] ]
            for testCase in testCases {
                self.testCases[testCase["id"] as! String] = (
                     status: testCase["status"] as! Int,
                     time: testCase["time"] as! Int,
                     memory: testCase["memory"] as! Int,
                     score: testCase["score"] as! Int,
                     subtaskID: testCase["subtaskID"] as! Int,
                     description: subtask["description"] as! String
                )
            }
            
        }
        print(self.testCases)
        
    }
    
    func readData() {
        LuoguAPIs.viewRecord(rid: rid) {
            (success, message, dic)  in
            if !success {
                self.showAlert("Error Ocurred.", message)
                return
            }
            self.parseDictionary(dic: dic!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
    }
    
}
