//
//  ViewController.swift
//  C+++
//
//  Created by apple on 2020/3/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

func menloFont(ofSize size: CGFloat) -> NSFont {
    return NSFont(name: "Menlo", size: size)!
}


@available(OSX 10.14, *)
let darkAqua = NSAppearance(named: .darkAqua)
let aqua = NSAppearance(named: .aqua)




class CDMainViewController: NSViewController, NSTextViewDelegate, CDCodeEditorDelegate, NSSplitViewDelegate, SKSyntaxTextViewDelegate, CDScrollViewDelegate {
    
    
    func setStatus(string: String) {
        (self.view.window?.windowController as! CDMainWindowController).statusString = string
    }
    
    /// Whether the window is in dark mode or not.
    /// - If it is true,the appearance is dark aqua.
    /// - if it is false, the appearance is aqua.
    var isDarkMode: Bool = true
    var isOpeningInProjectViewController = false
    
    
    @IBOutlet weak var mainTextView: SKSyntaxTextView!
    @IBOutlet weak var pathControl: NSPathControl!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var linesLabel: NSTextField!
    @IBOutlet weak var charactersLabel: NSTextField!
    @IBOutlet weak var consoleView: CDCompileResultAndDebugView!
    @IBOutlet weak var leftView: NSView!
    @IBOutlet weak var bigSplitView: NSSplitView!
    @IBOutlet weak var smallSplitView: NSSplitView!
    @IBOutlet weak var lineNumberView: CDCodeEditorLineNumberView!
    @IBOutlet weak var lineNumberScrollView: CDScrollView!
    @IBOutlet weak var minimapView: CDMinimapView!
    @IBOutlet weak var minimapViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var sidebarTitleLabel: NSTextField!
    @IBOutlet weak var leftSidebarTableView: NSTableView!
    
    var observation: NSKeyValueObservation?
    lazy var snippetDataSource = CDSnippetTableViewDataSource()
    lazy var recentFilesDataSource = CDRecentFilesTableViewDataSource()
    
    var leftSidebarMode: LeftSidebarMode = .snippets
    
    enum LeftSidebarMode: Int {
        case snippets = 0
        case recentFiles = 1
        case diagnostics = 2
    }

    
    
    
    
// MARK: - Split View Delegate
    
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        
        if subview == self.leftView {
            return true
        } else {
            return false
        }
        
    }
    
    
    
    
// MARK: - viewDidLoad()
    
    let defaultTheme = SKDefaultSourceCodeTheme()
    let lexer = CDCppLexer()
    
    func lexerForSource(_ source: String) -> SKLexer {
        return self.lexer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTextView.theme = defaultTheme
        self.mainTextView.delegate = self
        self.lineNumberView.textView = self.mainTextView.textView
        self.minimapView.scrollView = self.mainTextView.scrollView
        self.sidebarTitleLabel.stringValue = "Snippets"
        self.consoleView.debugConsoleView.font = menloFont(ofSize: 12.0)
        
        self.changeAppearance(newAppearance: self.view.effectiveAppearance.name)
       
        // observe the appearance of the view.
        self.observation = observe(\.view.effectiveAppearance, options: [.old, .new]) { object, change in
            
            // print ("old \(change.oldValue!.name) now \(change.newValue!.name).")
            if change.oldValue!.name != change.newValue!.name {
                self.changeAppearance(newAppearance: change.newValue!.name)
            }
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(settingsDidChange(_:)), name: CDSettings.settingsDidChangeNotification, object: nil)
        
        // TODO: Set the theme and font of the code editor.
        
        self.consoleView.logView.font = menloFont(ofSize: 13.0)
        
        self.leftSidebarTableView.delegate = self.snippetDataSource
        self.leftSidebarTableView.dataSource = self.snippetDataSource
        // initialize the scroll view and the minimap view.
        self.mainTextView.scrollView.scroll(self.mainTextView.scrollView.contentView, to: NSMakePoint(0, 0))
        
    }
    
    
    @IBAction func tableViewClicked(_ sender: Any?) {
        if let delegate = self.leftSidebarTableView.delegate as? CDLeftSidebarTableViewDelegate {
            delegate.didClick(tableView: self.leftSidebarTableView)
        }
    }
    
    func didScroll(to point: NSPoint) {
        self.lineNumberView.enclosingScrollView?.scroll(self.lineNumberView.enclosingScrollView!.contentView, to: point)
        self.minimapView.scrollViewDidScrollToPoint(point: point)
    }
    
    
// MARK: - Code Editor Delegate
    
    func didChangeText(_ syntaxTextView: SKSyntaxTextView) {
        
        syntaxTextView.textView.textStorage?.addAttribute(.toolTip, value: true, range: NSMakeRange(0, syntaxTextView.text.count))
        DispatchQueue.main.async {
            self.lineNumberView.draw()
        }
        
        self.linesLabel.stringValue = "\(syntaxTextView.textView.textStorage?.paragraphs.count ?? 0) lines"
        self.charactersLabel.stringValue = "\(syntaxTextView.text.count) characters"
        
        // minimap
        DispatchQueue.main.async {
            
            let dataOfView = self.mainTextView.textView.dataWithPDF(inside: self.mainTextView.textView.bounds)
            let imageOfView = NSImage(data: dataOfView)!
            self.minimapView.imageView.image = imageOfView
            if self.minimapView.imageView.frame.width != 0 && imageOfView.size.width != 0 {
                self.minimapView.frame.size.height = imageOfView.size.height / (imageOfView.size.width / self.minimapView.imageView.frame.width)
                self.minimapView.imageView.frame.size.height =  imageOfView.size.height / (imageOfView.size.width / self.minimapView.imageView.frame.width)
            }
            
        }
        
        // save document
        guard let document = self.document else {
            return
        }
        document.content.contentString = self.mainTextView.text
        
    }

    @IBOutlet weak var addSnippetButton: NSButton!
    
    
    
    func scrollViewDidScroll(to point: NSPoint) {
        self.mainTextView.scrollView.scroll(self.mainTextView.scrollView.contentView, to: point)
    }
    
   
    
// MARK: - Diagnostics
    var diagnostics = [CKDiagnostic]()
    var diagnosticsCells = [CDSnippetTableViewCell]()
    
    
    
    
// MARK: - Document
    
    weak var document: CDCodeDocument?
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.document = self.view.window?.windowController?.document as? CDCodeDocument
        self.mainTextView.text = document?.content.contentString ?? ""
        
    }
    
    
    
    
    
    
    @IBAction func enterSimpleMode(_ sender: Any?) {
        
        self.leftView.isHidden = true
        self.consoleView.isHidden = true
        
    }
    
    @IBAction func toggleLeftSidebar(_ sender: Any?) {
        if self.leftView.isHidden {
            self.leftView.isHidden = false
        } else {
            self.leftView.isHidden = true
        }
    }
    
    @IBAction func toggleCompileInfoView(_ sender: Any?) {
        if self.consoleView.isHidden {
            self.consoleView.isHidden = false
        } else {
            self.consoleView.isHidden = true
        }
    }
    
    @IBAction func toggleMinimap(_ sender: Any?) {
        if self.minimapView.enclosingScrollView!.isHidden {
            self.minimapView.enclosingScrollView?.isHidden = false
            self.minimapViewConstraint.constant = 123.0
        } else {
            self.minimapView.enclosingScrollView?.isHidden = true
            self.minimapViewConstraint.constant = 0.0
        }
    }
    
}
