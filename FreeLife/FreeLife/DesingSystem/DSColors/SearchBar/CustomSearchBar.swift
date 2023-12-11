//
//  CustomSearchBar.swift
//  Jonas
//
//  Created by ihan carlos on 07/09/23.
//

import UIKit

class CustomSearchBar: UIView {
    
    lazy var textField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "O que você procura?"
        text.backgroundColor = .ds(.lighGray)
        return text
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.tintColor = .ds(.lighGray)
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

extension CustomSearchBar: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(searchButton)
        addSubview(lineView)
        addSubview(textField)
    }
    
    func setupConstraints() {
        
        searchButton.anchor(
            left: leftAnchor,
            centerY: centerYAnchor,
            leftConstant: 10,
            widthConstant: 14,
            heightConstant: 14
        )
        
        lineView.anchor(
            top: topAnchor,
            left: searchButton.rightAnchor,
            bottom: bottomAnchor,
            topConstant: 4,
            leftConstant: 8,
            bottomConstant: 4,
            widthConstant: 1
        )
        
        textField.anchor(
            left: lineView.rightAnchor,
            right: rightAnchor,
            centerY: searchButton.centerYAnchor,
            leftConstant: 8,
            heightConstant: 17
        )
    }
    
    func setupAdditionalConfiguration() {
        layer.cornerRadius = 6
        backgroundColor = .ds(.lighGray)
        textField.delegate = self
    }
}

extension CustomSearchBar: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
