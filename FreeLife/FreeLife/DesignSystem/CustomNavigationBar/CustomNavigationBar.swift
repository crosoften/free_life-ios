//
//  CustomNavigationBar.swift
//  Jonas
//
//  Created by ihan carlos on 07/09/23.
//

import UIKit

class CustomNavigationBar: UIView {
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.ds(.back), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
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

extension CustomNavigationBar: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(backButton)
    }
    
    func setupConstraints() {
        backButton.anchor(
            top: topAnchor,
            left: leftAnchor,
            leftConstant: 20,
            widthConstant: 16,
            heightConstant: 16
        )
        
        titleLabel.anchor(
            centerX: centerXAnchor,
            centerY: backButton.centerYAnchor
        )
    }
}
