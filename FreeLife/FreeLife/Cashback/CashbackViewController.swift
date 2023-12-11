//
//  CashbackViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 08/12/23.
//

import UIKit

class CashbackViewController: UIViewController {
    
    lazy var cashLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cashback"
        label.font = .dsFonts(.bigTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var invoiceCard: CustomValueCardView = {
        let card = CustomValueCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.moneyLabel.text = "R$ 00,00"
        card.fatureLabel.text = "VALOR PARA SAQUE"
        card.monthLabel.text = "DATA PARA RESGATE: 00/00/00"
        return card
    }()
    
    lazy var lastLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Histórico"
        label.font = .dsFonts(.subTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var historicTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(HistoricTableViewCell.self, forCellReuseIdentifier: HistoricTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    lazy var sendButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .containedQuadDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Solicitar cashback", for: .normal)
        button.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedSendButton() {
        let navigationController = UINavigationController(rootViewController: RequestCashBackViewController())
        present(navigationController, animated: true, completion: nil)
        self.navigationController?.modalPresentationStyle = .pageSheet
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension CashbackViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(cashLabel)
        view.addSubview(invoiceCard)
        view.addSubview(lastLabel)
        view.addSubview(historicTableView)
        view.addSubview(sendButton)
    }
    
    func setupConstraints() {
        cashLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            topConstant: 5,
            leftConstant: 20
        )
        
        invoiceCard.anchor(
            top: cashLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 20,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 120
        )
        
        lastLabel.anchor(
            top: invoiceCard.bottomAnchor,
            left: invoiceCard.leftAnchor,
            topConstant: 20
        )
        
        historicTableView.anchor(
            top: lastLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: sendButton.topAnchor,
            right: view.rightAnchor,
            topConstant: 10,
            bottomConstant: 10
        )
        
        sendButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            leftConstant: 20,
            bottomConstant: 8,
            rightConstant: 20,
            heightConstant: 50
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}

extension CashbackViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoricTableViewCell.identifier, for: indexPath) as? HistoricTableViewCell
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
