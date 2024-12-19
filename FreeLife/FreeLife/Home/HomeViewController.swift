//
//  HomeViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 08/12/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    
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
        //card.moneyLabel.text = "R$ 00,00"
        card.fatureLabel.text = "FATURAS PENDENTES"
       // card.monthLabel.text = "SETEMBRO"
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
        viewModel.getTicket()
        viewModel.delegate = self
    }
}

extension HomeViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(welcomeLabel)
        view.addSubview(userNameLabel)
        view.addSubview(invoiceCard)
//        view.addSubview(chartImage)
    }
    
    func setupConstraints() {
        
        welcomeLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            leftConstant: 20
        )
        
        userNameLabel.anchor(
            top: welcomeLabel.bottomAnchor,
            left: welcomeLabel.leftAnchor,
            topConstant: 4
        )
        
        invoiceCard.anchor(
            top: userNameLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 80,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 120
        )
        
//        chartImage.anchor(
//            top: invoiceCard.bottomAnchor,
//            left: view.leftAnchor,
//            right: view.rightAnchor,
//            topConstant: 20,
//            leftConstant: 20,
//            rightConstant: 20,
//            heightConstant: 226
//        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}

extension HomeViewController: HomeViewModelDelegate{
    func success(value: String) {
        DispatchQueue.main.async {
            let totalValue = self.viewModel.calculateTotalValue()
            let formattedValue = self.viewModel.formatCurrency(value: totalValue)
                    self.invoiceCard.moneyLabel.text = formattedValue      }
    }
    
    func error(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style:.default)
        alert.addAction(okButton)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
