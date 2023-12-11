//
//  ProfileTableViewCell.swift
//  FreeLife
//
//  Created by ihan carlos on 11/12/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier: String = "ProfileTableViewCell"
    
    lazy var cards: CustomProfileButtonCard = {
        let card = CustomProfileButtonCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    public func setUpCell(data: ProfileCardsModel) {
        cards.titleCard.text = data.title
        cards.imageCard.image = data.image
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileTableViewCell: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(cards)
    }
    
    func setupConstraints() {
        cards.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 50
        )
    }
}
