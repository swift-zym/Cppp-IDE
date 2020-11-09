//
//  NSColor Extension.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa
 
extension NSColor {
     
    convenience init(hexString: String) {
        
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: 1)
        
    }
    
    var hexString: String {
        
        let color = self.usingColorSpace(.sRGB)!
        
        let red = color.redComponent
        let green = color.greenComponent
        let blue = color.blueComponent
        let alpha = color.alphaComponent
         
        let multiplier = CGFloat(255.999999)
         
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        } else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
        
    }
    
}
