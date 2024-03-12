//
//  CustomTextFieldUsualy.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 12/03/24.
//

import UIKit

class CustomTextFieldUsualy: UIView {
    
    lazy var titleTextField: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .dsFonts(.poppinsRegular12)
        label.font = .dsFonts(.subTitle).withSize(14)

        label.textColor = .black
        return label
    }()
    
    lazy var containerTextField: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        view.backgroundColor = .ds(.grayVeryLight)
        return view
    }()
    
    lazy var textField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.tintColor = .black
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextFieldUsualy: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(titleTextField)
        addSubview(containerTextField)
        addSubview(textField)
        addSubview(rightButton)
    }
    
    func setupConstraints() {
        titleTextField.anchor(
            top: topAnchor,
            left: leftAnchor
        )
        
        containerTextField.anchor(
            top: titleTextField.bottomAnchor,
            left: titleTextField.leftAnchor,
            right: rightAnchor,
            bottomConstant: 3,
            heightConstant: 50
        )
        
        textField.anchor(
            left: containerTextField.leftAnchor,
            right: rightButton.leftAnchor,
            centerY: containerTextField.centerYAnchor,
            leftConstant: 10,
            heightConstant: 20
        )
        
        rightButton.anchor(
            right: containerTextField.rightAnchor,
            centerY: containerTextField.centerYAnchor,
            rightConstant: 10,
            widthConstant: 20,
            heightConstant: 20
        )
    }
}
