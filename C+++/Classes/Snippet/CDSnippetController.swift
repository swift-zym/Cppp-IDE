//
//  CDSnippetController.swift
//  C+++
//
//  Created by 23786 on 2020/11/14.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

fileprivate var _sharedController = CDSnippetController()

class CDSnippetController: NSObject {
    
    var snippets: [CDSnippet] = []
    
    private static let archivePath = FileManager().urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent("C+++").appendingPathComponent("Snippets")
    
    private let sampleSnippets: KeyValuePairs = [
        "For Statement": "\nfor (<#initalize#>, <#condition#>, <#increment#>) {\n\t<#statements#>\n}",
        "If Statement": "\nif (<#condition#>) {\n\t<#statements#>\n}",
        "While Statement": "\nwhile (<#condition#>) {\n\t<#statements#>\n}",
        "If-else Statement": "\nif (<#condition#>) {\n\t<#statements#>\n} else {\n\t<#statements#>\n}",
        "Struct Declaration": "\nstruct Node {\n\t<#declarations#>\n\tNode(<#parameters#>) {<#initalizer#>}\n};",
        "Switch Statement" : "\nswitch (<#value#>) {\n\tcase <#value#>: break;\n\tcase <#value#>: break;\n}",
        "Function Declaration": "\nvoid func(<#parameters#>) {\n\t<#statements#>\n}",
        "DFS": "\nvoid dfs(int t) {\n\tif (<#end condition#>) {\n\t\t<#output#>\n\t\treturn;\n\t}\n\tfor (<#every possible steps#>) {\n\t\tif (<#condition#>) {\n\t\t\t<#statements#>\n\t\t\tdfs(t + 1);\n\t\t\t<#statements#>\n\t\t}\n\t}\n}",
        "Binary Search": "\nvoid binarySearch(int x) {\n\tint l = 1, r = MAXN, mid;\n\twhile (l < r) {\n\t\tmid = (l + r) / 2;\n\t\tif (x >= n[mid]) {\n\t\t\tl = mid;\n\t\t} else {\n\t\t\tr = mid - 1;\n\t\t}\n\t}\n\t<#l#>\n}"
    ]
    
    func initialize() {
        if let savedSnippets = NSKeyedUnarchiver.unarchiveObject(withFile: CDSnippetController.archivePath.path) as? [CDSnippet] {
            self.snippets = savedSnippets
        } else {
            sampleSnippets.forEach {
                item in
                self.snippets.append( CDSnippet(title: item.key, image: #imageLiteral(resourceName: "Code"), code: item.value) )
            }
            NSKeyedArchiver.archiveRootObject(self.snippets, toFile: CDSnippetController.archivePath.path)
        }
    }
    
    func add(snippet: CDSnippet) {
        self.snippets.append(snippet)
        NSKeyedArchiver.archiveRootObject(self.snippets, toFile: CDSnippetController.archivePath.path)
        GlobalMainWindowController.mainViewController.leftSidebarTableView.reloadData()
    }
    
    func remove(at index: Int) {
        self.snippets.remove(at: index)
        NSKeyedArchiver.archiveRootObject(self.snippets, toFile: CDSnippetController.archivePath.path)
    }
    
    func moveSnippetUp(index: Int) {
        let newIndex = index == 0 ? 0 : index - 1
        snippets.swapAt(index, newIndex)
        NSKeyedArchiver.archiveRootObject(self.snippets, toFile: CDSnippetController.archivePath.path)
    }
    
    func moveSnippetDown(index: Int) {
        let newIndex = index == self.snippets.count - 1 ? self.snippets.count - 1 : index + 1
        snippets.swapAt(index, newIndex)
        NSKeyedArchiver.archiveRootObject(self.snippets, toFile: CDSnippetController.archivePath.path)
    }
    
    class var shared: CDSnippetController {
        return _sharedController
    }
    
}
