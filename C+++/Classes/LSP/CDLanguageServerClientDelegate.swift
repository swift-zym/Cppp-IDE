//
//  CDLanguageServerDelegate.swift
//  C+++
//
//  Created by 23786 on 2021/2/7.
//  Copyright © 2021 Zhu Yixuan. All rights reserved.
//

import Cocoa

protocol CDLanguageServerClientDelegate {
    
    func receivedDiagnostics(for: String, diagnostics: [CDDiagnostic])

}

extension CDLanguageServerClientDelegate {
    
    func receivedDiagnostics(for: String, diagnostics: [CDDiagnostic]) {
        // do nothing
    }
    
}
