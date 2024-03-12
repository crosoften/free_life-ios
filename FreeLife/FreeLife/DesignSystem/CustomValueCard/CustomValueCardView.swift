//
//  CustomValueCardViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 08/12/23.
//

import UIKit

class CustomValueCardView: UIView {
    
    lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.poppinsBold24)
        label.textColor = .black
        return label
    }()
    
    lazy var fatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.subTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomValueCardView: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(moneyLabel)
        addSubview(fatureLabel)
        addSubview(monthLabel)
    }
    
    func setupConstraints() {
        moneyLabel.anchor(
            top: topAnchor,
            centerX: centerXAnchor,
            topConstant: 20
        )
        
        fatureLabel.anchor(
            top: moneyLabel.bottomAnchor,
            centerX: centerXAnchor,
            topConstant: 8
        )
        
        monthLabel.anchor(
            top: fatureLabel.bottomAnchor,
            centerX: centerXAnchor,
            topConstant: 8
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .ds(.lighGray)
    }
}
