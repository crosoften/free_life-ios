//
//  UITextField.swift
//  Soc
//
//  Created by Jeferson Dias dos Santos on 16/01/25.
//


import UIKit


extension UITextField {
    func applyMask(mask: String, replacementChar: Character = "#") {
        addTarget(self, action: #selector(formatText), for: .editingChanged)
        self.maskPattern = mask
        self.maskReplacementChar = replacementChar
    }

    private struct AssociatedKeys {
        static var maskPattern = "maskPattern"
        static var maskReplacementChar = "maskReplacementChar"
    }

    private var maskPattern: String? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.maskPattern) as? String }
        set { objc_setAssociatedObject(self, &AssociatedKeys.maskPattern, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var maskReplacementChar: Character {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.maskReplacementChar) as? Character ?? "#" }
        set { objc_setAssociatedObject(self, &AssociatedKeys.maskReplacementChar, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    @objc private func formatText() {
        guard let text = self.text, let maskPattern = self.maskPattern else { return }
        
        let digits = text.filter { $0.isNumber }
        var formattedText = ""
        var digitIndex = digits.startIndex

        for char in maskPattern {
            if digitIndex == digits.endIndex { break }
            if char == maskReplacementChar {
                formattedText.append(digits[digitIndex])
                digitIndex = digits.index(after: digitIndex)
            } else {
                formattedText.append(char)
            }
        }
        
        self.text = formattedText
    }
}
