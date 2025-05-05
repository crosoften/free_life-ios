//
//  CashbackViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 08/12/23.
//

import UIKit

class CashbackViewController: UIViewController {
    
    let viewModel = CashbackViewModel()
    
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
       // card.moneyLabel.text = "R$ 00,00"
        card.fatureLabel.text = "VALOR PARA SAQUE"
       // card.monthLabel.text = "DATA PARA RESGATE: 00/00/00"
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
        table.allowsSelection = false
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
        
        guard let companyId = viewModel.companyId else {
            return
        }
        
        guard let userId = viewModel.userId else {
            return
        }
        if viewModel.value > 0 {
            
            let cashBackVC = RequestCashBackViewController(companyId: companyId, userId: userId, value: viewModel.value )
            cashBackVC.delegate = self
            let navigationController = UINavigationController(rootViewController: cashBackVC)
            navigationController.modalPresentationStyle = .pageSheet
            
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.large()] // Ocupa a tela inteira
                sheet.prefersGrabberVisible = true // Mostra a barrinha de arrastar
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.preferredCornerRadius = 20
            }
            
            present(navigationController, animated: true, completion: nil)
        } else {
            showAlert(message: "Você não tem saldo para solicitar")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getCashback()
        viewModel.getMyself()

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
        return viewModel.numberOfCashbacks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoricTableViewCell.identifier, for: indexPath) as? HistoricTableViewCell
        let cashback = viewModel.getCashbacks(index: indexPath.row)
        cell?.setupCell(cashback: cashback)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension CashbackViewController: CashbackViewModelDelegate{
    func success(value: Double) {
        DispatchQueue.main.async {
            self.historicTableView.reloadData()
            let formattedValue = self.viewModel.formatCurrency(value: value)
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


extension CashbackViewController: RequestCashBackViewModelDelegate {
    func success() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            self.viewModel.getCashback()
        }
    }
    
    
    // Função para mostrar um alerta
    func showAlert(title: String = "", message: String,  completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            completion?()
        }
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    

    
}
