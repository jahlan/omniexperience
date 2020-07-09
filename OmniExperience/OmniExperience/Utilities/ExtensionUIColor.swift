//
//  ExtensionUIColor.swift
//  OmniExperience
//
//  Created by Yalan Bravo Olvera on 09/07/20.
//  Copyright © 2020 Yalan Bravo. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    //Create a color from hexadecimal value
    class func color(_ hexString: String) -> UIColor? {
        if (hexString.count > 7 || hexString.count < 7) {
            return nil
        } else {
            let hexInt = Int(hexString.substring(from: hexString.index(hexString.startIndex, offsetBy: 1)), radix: 16)
            if let hex = hexInt {
                let components = (
                    R: CGFloat((hex >> 16) & 0xff) / 255,
                    G: CGFloat((hex >> 08) & 0xff) / 255,
                    B: CGFloat((hex >> 00) & 0xff) / 255
                )
                return UIColor(red: components.R, green: components.G, blue: components.B, alpha: 1)
            } else {
                return nil
            }
        }
    }
}

