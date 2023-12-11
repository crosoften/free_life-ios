//
//  TicketViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 08/12/23.
//

import UIKit

class TicketViewController: UIViewController {
    
    lazy var debitsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Débitos pendentes"
        label.font = .dsFonts(.bigTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var invoiceCard: CustomValueCardView = {
        let card = CustomValueCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.moneyLabel.text = "R$ 00,00"
        card.fatureLabel.text = "FATURA PENDENTE"
        card.monthLabel.text = "SETEMBRO"
        return card
    }()
    
    lazy var lastLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Últimos lançamentos"
        label.font = .dsFonts(.subTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var lastTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(DetailsTicketTableViewCell.self, forCellReuseIdentifier: DetailsTicketTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension TicketViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(debitsLabel)
        view.addSubview(invoiceCard)
        view.addSubview(lastLabel)
        view.addSubview(lastTableView)
    }
    
    func setupConstraints() {
        debitsLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            topConstant: 5,
            leftConstant: 20
        )
        
        invoiceCard.anchor(
            top: debitsLabel.bottomAnchor,
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
        
        lastTableView.anchor(
            top: lastLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 20
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}

extension TicketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTicketTableViewCell.identifier, for: indexPath) as? DetailsTicketTableViewCell
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsTicketViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
