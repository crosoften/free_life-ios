//
//  CustomDetailsButton.swift
//  FreeLife
//
//  Created by ihan carlos on 11/12/23.
//

import UIKit

class CustomDetailsButton: UIView {
    
    lazy var blueView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ds(.generalBlue)
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var imageButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var buttonCard: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cardLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
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

extension CustomDetailsButton: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(blueView)
        blueView.addSubview(imageButton)
        addSubview(cardLabel)
        addSubview(buttonCard)
    }
    
    func setupConstraints() {
        
        blueView.anchor(
            top: topAnchor,
            left: leftAnchor,
            widthConstant: 90,
            heightConstant: 90
        )
        
        imageButton.anchor(
            centerX: blueView.centerXAnchor,
            centerY: blueView.centerYAnchor,
            widthConstant: 27,
            heightConstant: 27
        )
        
        buttonCard.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        cardLabel.anchor(
            top: blueView.bottomAnchor,
            left: blueView.leftAnchor,
            right: blueView.rightAnchor
        )
    }
    
    func setupAdditionalConfiguration() {

    }
}
