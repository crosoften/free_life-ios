//
//  CustomButton.swift
//  medPlantoes
//
//  Created by ihan carlos on 11/08/23.
//

import UIKit


public enum Style {
    case containedQuadDark
    case containedLight
    case borderButton
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
            titleLabel?.font = .dsFonts(.button)
            backgroundColor = .ds(.generalBlue)
            setTitleColor(UIColor.white, for: .normal)
            clipsToBounds = true
            layer.cornerRadius = 6
            
        case.containedLight:
            titleLabel?.font = .dsFonts(.subTitle)
            backgroundColor = .clear
            setTitleColor(.ds(.generalBlue), for: .normal)
            
        case.borderButton:
            layer.borderWidth = 1
            layer.borderColor = UIColor.ds(.generalBlue).cgColor
            clipsToBounds = true
            layer.cornerRadius = 6
            titleLabel?.font = .dsFonts(.button)
            setTitleColor(UIColor.ds(.generalBlue), for: .normal)
            backgroundColor = .clear
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

