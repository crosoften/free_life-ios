//
//  DetailsTicketViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 11/12/23.
//

import UIKit

class DetailsTicketViewController: UIViewController {
    
    var ticket: TicketModel
    let viewModel = DetailsTicketViewModel()
    let alertController = TicketAlert()
    
    // MARK: Initializers
    init(ticket: TicketModel) {
        self.ticket = ticket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.ds(.back), for: .normal)
        button.addTarget(self, action: #selector(tapeedBackButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapeedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var titleScreenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Detalhes do documento"
        label.font = .dsFonts(.bigTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var invoiceCard: CustomValueCardView = {
        let card = CustomValueCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        // card.moneyLabel.text = "R$ 00,00"
         card.fatureLabel.text = "VALOR DO DOCUMENTO"
        // card.monthLabel.text = "SETEMBRO"
        return card
    }()
    
    lazy var originalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Valor original"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        return label
    }()
    
    lazy var originalValuePriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.text = "R$ 00,00"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        return label
    }()
    
    lazy var maturityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vencimento:"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        return label
    }()
    
    lazy var maturityDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.text = "00/00/00"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        return label
    }()
    
    lazy var demandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cobrança"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        return label
    }()
    
    lazy var demandMethodsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.text = "Boleto"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        return label
    }()
    
//    lazy var banckTitleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Banco"
//        label.font = .dsFonts(.poppinsNormal12)
//        label.textColor = .black
//        return label
//    }()
//    
//    lazy var banckLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Bradesco"
//        label.font = .dsFonts(.poppinsNormal12)
//        label.textColor = .black
//        return label
//    }()
//    
//    lazy var weNumberLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Nosso número"
//        label.font = .dsFonts(.poppinsNormal12)
//        label.textColor = .black
//        return label
//    }()
//    
//    lazy var weNumberCodeLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "000000"
//        label.font = .dsFonts(.poppinsNormal12)
//        label.textColor = .black
//        return label
//    }()
//    
//    lazy var cashBackLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Cashback"
//        label.font = .dsFonts(.poppinsNormal12)
//        label.textColor = .black
//        return label
//    }()
//    
//    lazy var cashBackValueLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "R$00,00"
//        label.font = .dsFonts(.poppinsNormal12)
//        label.textColor = .black
//        return label
//    }()
//    
    //    lazy var buttonPix: CustomDetailsButton = {
    //        let button = CustomDetailsButton()
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        button.imageButton.image = .ds(.pix)
    //        button.cardLabel.text = "Pagar com pix"
    //        return button
    //    }()
    
    lazy var buttonEmail: CustomDetailsButton = {
        let button = CustomDetailsButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageButton.image = .ds(.ticket)
        button.cardLabel.text = "Enviar boleto por email"
        button.buttonCard.addTarget(self, action: #selector(buttonCardTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonCardTapped(){
        
        alertController.saveButton.addTarget(self, action: #selector(alertTapped), for: .touchUpInside)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func alertTapped() {
        // Verifica se o código está vazio
        if ticket.code.isEmpty {
            // Exibe um alerta caso o código esteja vazio
            let alert = UIAlertController(title: "Erro", message: "O boleto atual não possui um código de barras registrado", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // Se o código não estiver vazio, envia a requisição
        let request = SendTicketRequest(
            value: ticket.value,
            issueDate: ticket.createDate,
            date: ticket.date,
            code: ticket.code,
            email: alertController.serviceTextfield.text ?? ""
        )
        viewModel.postTicket(modelRequest: request)
    }

    
    //    lazy var buttonSms: CustomDetailsButton = {
    //        let button = CustomDetailsButton()
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        button.imageButton.image = .ds(.sms)
    //        button.cardLabel.text = "Enviar linha digitável por sms"
    //        return button
    //    }()
    
    lazy var packageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pacote do documento"
        label.font = .dsFonts(.poppinsBold12)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configLayout()
        //        let request = DebtsIdRequest(id: id)
        //        viewModel.getDetailsTicket(modelRequest: request)
                viewModel.delegate = self
    }
    
    func configLayout(){
        self.invoiceCard.moneyLabel.text = "R$\(ticket.value)"
        self.originalValuePriceLabel.text = "R$\(ticket.originalValue)"
        self.maturityDateLabel.text = ticket.date
        self.demandMethodsLabel.text = ticket.typePayment.isEmpty ? "Boleto" : ticket.typePayment
    }
}

extension DetailsTicketViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(backButton)
        view.addSubview(titleScreenLabel)
        view.addSubview(invoiceCard)
        view.addSubview(originalValueLabel)
        view.addSubview(originalValuePriceLabel)
        view.addSubview(maturityLabel)
        view.addSubview(maturityDateLabel)
        view.addSubview(demandLabel)
        view.addSubview(demandMethodsLabel)
//        view.addSubview(banckTitleLabel)
//        view.addSubview(banckLabel)
//        view.addSubview(weNumberLabel)
//        view.addSubview(weNumberCodeLabel)
//        view.addSubview(cashBackLabel)
//        view.addSubview(cashBackValueLabel)
//        view.addSubview(buttonPix)
        view.addSubview(buttonEmail)
//        view.addSubview(buttonSms)
//        view.addSubview(packageLabel)
    }
    
    func setupConstraints() {
        
        backButton.anchor(
            left: view.leftAnchor,
            centerY: titleScreenLabel.centerYAnchor,
            leftConstant: 20,
            widthConstant: 20,
            heightConstant: 20
        )
        
        titleScreenLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: backButton.rightAnchor,
            topConstant: 5,
            leftConstant: 10
        )
        
        invoiceCard.anchor(
            top: titleScreenLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 20,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 120
        )
        
        originalValueLabel.anchor(
            top: invoiceCard.bottomAnchor,
            left: invoiceCard.leftAnchor,
            topConstant: 20
        )
        
        originalValuePriceLabel.anchor(
            right: view.rightAnchor,
            centerY: originalValueLabel.centerYAnchor,
            rightConstant: 20
        )
        
        maturityLabel.anchor(
            top: originalValueLabel.bottomAnchor,
            left: originalValueLabel.leftAnchor,
            topConstant: 4
        )
        
        maturityDateLabel.anchor(
            right: view.rightAnchor,
            centerY: maturityLabel.centerYAnchor,
            rightConstant: 20
        )
        
        demandLabel.anchor(
            top: maturityLabel.bottomAnchor,
            left: maturityLabel.leftAnchor,
            topConstant: 4
        )
        
        demandMethodsLabel.anchor(
            right: view.rightAnchor,
            centerY: demandLabel.centerYAnchor,
            rightConstant: 20
        )
        
//        banckTitleLabel.anchor(
//            top: demandLabel.bottomAnchor,
//            left: demandLabel.leftAnchor,
//            topConstant: 4
//        )
//        
//        banckLabel.anchor(
//            right: view.rightAnchor,
//            centerY: banckTitleLabel.centerYAnchor,
//            rightConstant: 20
//        )
//        
//        weNumberLabel.anchor(
//            top: banckTitleLabel.bottomAnchor,
//            left: banckTitleLabel.leftAnchor,
//            topConstant: 4
//        )
//        
//        weNumberCodeLabel.anchor(
//            right: view.rightAnchor,
//            centerY: weNumberLabel.centerYAnchor,
//            rightConstant: 20
//        )
        
//        cashBackLabel.anchor(
//            top: weNumberLabel.bottomAnchor,
//            left: weNumberLabel.leftAnchor,
//            topConstant: 4
//        )
//        
//        cashBackValueLabel.anchor(
//            right: view.rightAnchor,
//            centerY: cashBackLabel.centerYAnchor,
//            rightConstant: 20
//        )
        
//        buttonPix.anchor(
//            top: cashBackLabel.bottomAnchor,
//            right: buttonEmail.leftAnchor,
//            topConstant: 20,
//            rightConstant: 20,
//            widthConstant: 90,
//            heightConstant: 110
//        )
//        
        buttonEmail.anchor(
            top: demandLabel.bottomAnchor,
            centerX: view.centerXAnchor,
            topConstant: 20,
            widthConstant: 90,
            heightConstant: 110
        )
        
//        buttonSms.anchor(
//            top: cashBackLabel.bottomAnchor,
//            left: buttonEmail.rightAnchor,
//            topConstant: 20,
//            leftConstant: 20,
//            widthConstant: 90,
//            heightConstant: 110
//        )
//        
//        packageLabel.anchor(
//            top: buttonPix.bottomAnchor,
//            left: view.leftAnchor,
//            topConstant: 20,
//            leftConstant: 20
//        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}

extension DetailsTicketViewController: DetailsTicketViewModelDelegate{
    func success(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style:.default)
        alert.addAction(okButton)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
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

