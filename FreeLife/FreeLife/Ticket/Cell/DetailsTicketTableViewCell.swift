//
//  DetailsTicketTableViewCell.swift
//  FreeLife
//
//  Created by ihan carlos on 11/12/23.
//

import UIKit

class DetailsTicketTableViewCell: UITableViewCell {
    
    static let identifier: String = "DetailsTicketTableViewCell"
    
    lazy var dayLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vencimento: 00/00/00"
        label.font = .dsFonts(.subText)
        label.textColor = .black
        return label
    }()
    
    lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 00,00"
        label.font = .dsFonts(.subText)
        label.textColor = .black
        return label
    }()
    
    lazy var downImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .ds(.down)
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsTicketTableViewCell: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(dayLabel)
        addSubview(priceLabel)
        addSubview(downImage)
    }
    
    func setupConstraints() {
        dayLabel.anchor(
            left: leftAnchor,
            centerY: centerYAnchor,
            leftConstant: 20
        )
        
        priceLabel.anchor(
            right: downImage.leftAnchor,
            centerY: centerYAnchor,
            rightConstant: 8
        )
        
        downImage.anchor(
            right: rightAnchor,
            centerY: centerYAnchor,
            rightConstant: 20
        )
    }
}
