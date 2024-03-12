//
//  CustomTextFieldView.swift
//  UberHub
//
//  Created by ihan carlos on 11/08/23.
//

import UIKit

class CustomTextFieldView: UIView {

    struct Constants {
        static let heightView: CGFloat = 1
    }
    
    var titleLabel: String?
    var imageSet: UIImage?
    var placeholderLabel: String?
    var validatorRegex: TextFieldValidator.PatternValidatorRegex?

    var isValid: Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }

        guard let regex = validatorRegex else {
            return true
        }

        return TextFieldValidator.validateText(for: regex, text: text)
    }

    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.subTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var imageDescription: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = imageSet
        return image
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        view.backgroundColor = .ds(.grayVeryLight).withAlphaComponent(1)
        return view
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTextField()
        textField.delegate = self
    }

    convenience init(title: String?,
                     placeholderLabel: String? = nil,
                     imageset: UIImage? = nil) {

        self.init(frame: .zero)
        self.title.text = title
        self.imageDescription.image = imageset
        self.placeholderLabel = placeholderLabel

        textField.placeholder = placeholderLabel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField() {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderLabel ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }
}

extension CustomTextFieldView: ViewCodeType {

    func buildViewHierarchy() {
        addSubview(title)
        addSubview(borderView)
        borderView.addSubview(imageDescription)
        borderView.addSubview(textField)
    }

    func setupConstraints() {
        title.anchor(
            top: topAnchor,
            left: leftAnchor,
            topConstant: 8
        )
        
        borderView.anchor(
            top: title.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            topConstant: 8,
            heightConstant: 50
        )
        
        imageDescription.anchor(
            left: leftAnchor,
            centerY: textField.centerYAnchor,
            leftConstant: 10,
            widthConstant: 20,
            heightConstant: 20
        )

        textField.anchor(
            top: borderView.bottomAnchor,
            left: imageDescription.rightAnchor,
            right: borderView.rightAnchor,
            centerY: borderView.centerYAnchor,
            topConstant: 8,
            leftConstant: 25,
            rightConstant: 5,
            heightConstant: 20
        )
    }
}

extension CustomTextFieldView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
