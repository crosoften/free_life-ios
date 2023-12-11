//
//  UIView+ShadowBorder.swift
//  Jonas
//
//  Created by ihan carlos on 07/09/23.
//

import UIKit

extension UIView {
    func addShadow(color: UIColor = .gray,
                   opacity: Float = 0.5,
                   offset: CGSize = CGSize(width: 0, height: 2),
                   radius: CGFloat = 4,
                   masksToBounds: Bool = false) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = masksToBounds
    }
}
