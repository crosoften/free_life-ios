//
//  HomeViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 08/12/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var userImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 24
        image.backgroundColor = .lightGray
        return image
    }()
    
    lazy var welcomeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Seja bem vindo(a)!"
        label.font = .dsFonts(.text)
        label.textColor = .black
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lucas Cesar"
        label.font = .dsFonts(.subTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var invoiceCard: CustomValueCardView = {
        let card = CustomValueCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.moneyLabel.text = "R$ 00,00"
        card.fatureLabel.text = "FATURA"
        card.monthLabel.text = "SETEMBRO"
        return card
    }()
    
    lazy var chartImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .ds(.chart)
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension HomeViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(userImage)
        view.addSubview(welcomeLabel)
        view.addSubview(userNameLabel)
        view.addSubview(invoiceCard)
        view.addSubview(chartImage)
    }
    
    func setupConstraints() {
        userImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            topConstant: 20,
            leftConstant: 20,
            widthConstant: 50,
            heightConstant: 50
        )
        
        welcomeLabel.anchor(
            left: userImage.rightAnchor,
            bottom: userImage.centerYAnchor,
            leftConstant: 8
        )
        
        userNameLabel.anchor(
            top: welcomeLabel.bottomAnchor,
            left: welcomeLabel.leftAnchor,
            topConstant: 4
        )
        
        invoiceCard.anchor(
            top: userImage.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 20,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 120
        )
        
        chartImage.anchor(
            top: invoiceCard.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 20,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 226
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}
