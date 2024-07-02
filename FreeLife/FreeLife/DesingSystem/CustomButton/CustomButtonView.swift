//
//  CustomButton.swift
//
//  Created by ihan carlos on 11/08/23.
//

import UIKit


public enum Style {
    case containedQuadDark
    case containedLight
    case borderButton
    case containedGray
    case black
}

class CustomButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            updateButtonAppearance()
        }
    }
    
    init(frame: CGRect, style: Style) {
        super.init(frame: frame)
        setupButton(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupButton(style: Style) {
        translatesAutoresizingMaskIntoConstraints = false
    
        switch style {

        case .containedQuadDark:
            titleLabel?.font = .dsFonts(.poppinsBold14)
            backgroundColor = .ds(.generalBlue)
            setTitleColor(UIColor.white, for: .normal)
            clipsToBounds = true
            layer.cornerRadius = 6
            
        case.containedLight:
            titleLabel?.font = .dsFonts(.poppinsBold12)
            backgroundColor = .clear
            setTitleColor(.ds(.generalBlue), for: .normal)
            
        case.borderButton:
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
            clipsToBounds = true
            layer.cornerRadius = 6
            titleLabel?.font = .dsFonts(.poppinsBold14)
            setTitleColor(UIColor.black, for: .normal)
            backgroundColor = .clear
            
        case .containedGray:
            titleLabel?.font = .dsFonts(.poppinsNormal12)
            backgroundColor = .ds(.lighGray)
            setTitleColor(UIColor.black, for: .normal)
            clipsToBounds = true
            layer.cornerRadius = 6
            
        case .black:
            titleLabel?.font = .dsFonts(.poppinsBold14)
            backgroundColor = .black
            setTitleColor(UIColor.white, for: .normal)
            clipsToBounds = true
            layer.cornerRadius = 6
        }
    }
    
    private func updateButtonAppearance() {
        if isEnabled {
            alpha = 1.0
        } else {
            alpha = 0.5
        }
    }
}

