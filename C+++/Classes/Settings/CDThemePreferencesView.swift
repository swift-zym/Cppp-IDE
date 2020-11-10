//
//  CDThemePreferencesView.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDThemePreferencesView: NSView, NSTableViewDataSource {
    
    private(set) var theme = CDCodeEditorTheme(isDarkMode: false)
    /// False if it is light appearance, true if it is dark appearance.
    private(set) var mode = false
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        switch row {
            case 0:
                return NSAttributedString(string: "Code", attributes: [.font: CDSettings.font(ofSize: 14.0), .foregroundColor: self.theme.codeColor])
            case 1:
                return NSAttributedString(string: "Keyword", attributes: [.font: CDSettings.font(ofSize: 14.0), .foregroundColor: self.theme.keywordColor])
            case 2:
                return NSAttributedString(string: "Comment", attributes: [.font: CDSettings.font(ofSize: 14.0), .foregroundColor: self.theme.commentColor])
            case 3:
                return NSAttributedString(string: "Numbers", attributes: [.font: CDSettings.font(ofSize: 14.0), .foregroundColor: self.theme.numberColor])
            case 4:
                return NSAttributedString(string: "Member functions and variables", attributes: [.font: CDSettings.font(ofSize: 14.0), .foregroundColor: self.theme.identifierColor])
            case 5:
                return NSAttributedString(string: "Preprocessor", attributes: [.font: CDSettings.font(ofSize: 14.0), .foregroundColor: self.theme.preprocessorColor])
            case 6:
                return NSAttributedString(string: "String Literal", attributes: [.font: CDSettings.font(ofSize: 14.0), .foregroundColor: self.theme.stringColor])
            default: return nil
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        // Code
        // Keyword
        // Comment
        // Numbers
        // Member functions and variables
        // Preprocesscor
        // StringLiteral
        return 7
    }
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var backgroundColorWell: NSColorWell!
    private var clickedIndex = -1
    
    func setAppearance(isDarkMode mode: Bool) {
        self.theme = mode ? CDSettings.darkTheme : CDSettings.lightTheme
        self.tableView.reloadData()
        self.mode = mode
    }
    
    @IBAction func tableViewClicked(_ sender: Any?) {
        self.clickedIndex = self.tableView.clickedRow
        NSColorPanel.shared.setTarget(self)
        NSColorPanel.shared.setAction(#selector(colorDidChange))
        switch self.clickedIndex {
            case 0: NSColorPanel.shared.color = self.theme.codeColor
            case 1: NSColorPanel.shared.color = self.theme.keywordColor
            case 2: NSColorPanel.shared.color = self.theme.commentColor
            case 3: NSColorPanel.shared.color = self.theme.numberColor
            case 4: NSColorPanel.shared.color = self.theme.identifierColor
            case 5: NSColorPanel.shared.color = self.theme.preprocessorColor
            case 6: NSColorPanel.shared.color = self.theme.stringColor
            default: break
        }
        NSColorPanel.shared.makeKeyAndOrderFront(nil)
    }
    
    @objc func colorDidChange() {
        
        let color = NSColorPanel.shared.color
        switch self.clickedIndex {
            case 0: self.theme.codeColor = color
            case 1: self.theme.keywordColor = color
            case 2: self.theme.commentColor = color
            case 3: self.theme.numberColor = color
            case 4: self.theme.identifierColor = color
            case 5: self.theme.preprocessorColor = color
            case 6: self.theme.stringColor = color
            default: break
        }
        if self.mode {
            CDSettings.darkTheme = self.theme
        } else {
            CDSettings.lightTheme = self.theme
        }
        self.tableView.reloadData()
        
    }
    
}
