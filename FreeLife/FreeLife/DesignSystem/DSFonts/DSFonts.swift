//
//  Fonts.swift
//  Jonas
//
//  Created by ihan carlos on 06/09/23.
//

import UIKit

public enum DSFonts {
    case bigTitle
    case title
    case text
    case subText
    case poppinsNormal12
    case subTitle
    case button
    case poppinsBold12
    case poppinsBold14
    case poppinsBold24
}

public extension UIFont {
    static func dsFonts( _ font: DSFonts) -> UIFont {
        let fontDefalt: UIFont = systemFont(ofSize: 20)
        switch font {
        case.bigTitle:
            return UIFont(name: "Poppins-Bold", size: 22) ?? fontDefalt
        case.poppinsBold24:
            return UIFont(name: "Poppins-Bold", size: 24) ?? fontDefalt
        case.title:
            return UIFont(name: "Roboto-Bold", size: 14) ?? fontDefalt
        case.text:
            return UIFont(name: "Roboto-Light", size: 12) ?? fontDefalt
        case.subText:
            return UIFont(name: "Poppins-Medium", size: 12) ?? fontDefalt
        case.poppinsNormal12:
            return UIFont(name: "Poppins-ExtraLight", size: 12) ?? fontDefalt
        case .subTitle:
            return UIFont(name: "Poppins-Medium", size: 14) ?? fontDefalt
        case .button:
            return UIFont(name: "Poppins-Bold", size: 20) ?? fontDefalt
        case .poppinsBold12:
            return  UIFont(name: "Poppins-Bold", size: 12) ?? fontDefalt
        case .poppinsBold14:
            return  UIFont(name: "Poppins-Bold", size: 14) ?? fontDefalt
        }
    }
}
