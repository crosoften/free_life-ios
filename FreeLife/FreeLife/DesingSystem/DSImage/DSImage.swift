//
//  DSImage.swift
//  Jonas
//
//  Created by ihan carlos on 06/09/23.
//

import Foundation
import UIKit

public enum DSImages: String {
    case logo = "image 1"
    case pix = "Group 1551"
    case chart = "Group 1554"
    case down = "Vector-8"
    case ticket = "Vector-9"
    case lock = "lock-6"
    case eye = "olho-7"
    case profileBlue = "perfil-10"
    case back = "Vector-7"
    case home = "Home-5"
    case cash = "Vector-11"
    case profileGray = "Vector-12"
    case debts = "Vector-13"
    case sms = "SMS"
    case exit = "Grupo 34874-2"
    case contact = "Grupo 34874-3"
    case privacy = "Grupo 34874-4"
    case terms = "Grupo 34874-5"
    case help = "Grupo 34874-6"
    case replace = "Grupo 34874"
    case camera = "Grupo 35131"
}

public extension UIImage {
    static func ds( _ image: DSImages) -> UIImage {
        return UIImage(named: image.rawValue) ?? UIImage()
    }
}
