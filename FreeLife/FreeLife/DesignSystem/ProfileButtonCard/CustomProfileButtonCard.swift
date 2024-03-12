//
//  CustomProfileButtonCard.swift
//  Jonas
//
//  Created by ihan carlos on 12/09/23.
//

import UIKit

class CustomProfileButtonCard: UIView {
    
    lazy var imageCard: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleCard: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .dsFonts(.text)
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

extension CustomProfileButtonCard: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(imageCard)
        addSubview(titleCard)
    }
    
    func setupConstraints() {
        
        imageCard.anchor(
            left: leftAnchor,
            centerY: centerYAnchor,
            leftConstant: 10,
            widthConstant: 28,
            heightConstant: 28
        )
        
        titleCard.anchor(
            left: imageCard.rightAnchor,
            centerY: imageCard.centerYAnchor,
            leftConstant: 21
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .ds(.lighGray)
        layer.cornerRadius = 12
    }
}
