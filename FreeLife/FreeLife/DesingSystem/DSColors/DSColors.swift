//
//  DSColors.swift
//  Jonas
//
//  Created by ihan carlos on 06/09/23.
//

import Foundation
import UIKit

public enum Colors: String {
    case generalBlue = "#004D7C"
    case lightBlue = "#0564B3"
    case blueVeryLight = "#CAE0F1"
    case red = "#C11E23"
    case lighGray = "#EAEAEA"
    case grayVeryLight = "#F0F1F2"
}

public extension UIColor {
    static func ds( _ color: Colors) -> UIColor {
        return UIColor(hexString: color.rawValue)
    }
}
