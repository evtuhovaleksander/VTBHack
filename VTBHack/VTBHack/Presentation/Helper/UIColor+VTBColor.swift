//
//  UIColor+VTBColor.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

extension UIColor {
    struct Color {
        static let darkBlue = UIColor(hex: "#10234D")
        static let blueButtonBorder = UIColor(hex: "#ebebeb") //238,238,238
        static let backgroundGray = UIColor(hex: "#f8f8f8") //248,248,248
        static let statusGreen = UIColor(hex: "#65bc36")
        static let darkGray = UIColor(hex: "#3c3c3c")
        static let blueText = UIColor(hex: "#003ec3")
        
        static let authDarkBlueBackground = UIColor(hex: "#10234d") //    rgb(16, 35, 77)

        
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
