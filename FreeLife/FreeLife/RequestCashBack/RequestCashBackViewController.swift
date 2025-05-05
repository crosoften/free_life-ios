//
//  RequestCashBackViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 08/12/23.
//

import UIKit

protocol RequestCashBackViewControllerDelegate: AnyObject {
    func success()
    func error(message: String)
}

class RequestCashBackViewController: UIViewController {
    
    weak var delegate: RequestCashBackViewModelDelegate?
    
    var companyId: Int
    var userId: Int
    var value: Double
    var viewModel = RequestCashBackViewModel()
    
    init(companyId: Int, userId: Int, value: Double) {
        self.companyId = companyId
        self.userId = userId
        self.value = value
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.isOpaque = false
        return view
    }()
    
    lazy var cashLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Solicitar Cashback"
        label.font = .dsFonts(.bigTitle)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 00,00"
        label.font = .dsFonts(.bigTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Solicite o cashback no seu pix ou abata o valor na próxima fatura. \n\nImportante: A chave pix deve ser do titular! Não será enviado pix em nome de terceiros!"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var pixTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(title: "Chave Pix(caso opte por PIX)")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
//    
    lazy var requestPixButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .containedQuadDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Solicitar pix", for: .normal)
        button.addTarget(self, action: #selector(requestPixButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var nextInvoiceButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .borderButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Abater na proxima fatura", for: .normal)
        button.addTarget(self, action: #selector(nextInvoiceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        viewModel.delegate = self
        moneyLabel.text = formatCurrency(value) // "R$ 1.234,56"
        
    }
    func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR") // Brasil
        return formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func requestPixButtonTapped(){
        guard let pixKey = pixTextField.textField.text,
              !pixKey.isEmpty else {
            showAlert(message: "Para solicitar o PIX, digite sua chave!")
            return
        }
        
        viewModel.requestCashback(pixKey: pixKey, value: value, solicitationType: .PIX, userId: userId, companyId: companyId)
    }
    
    @objc func nextInvoiceButtonTapped(){
        viewModel.requestCashback(pixKey: nil, value: value, solicitationType: .NEXT_BILL, userId: userId, companyId: companyId)
        
    }
    
//    func getPixValue() -> Double? {
//        guard let text = pixTextField.textField.text?
//            .replacingOccurrences(of: ",", with: ".")
//            .replacingOccurrences(of: "R$", with: "")
//            .trimmingCharacters(in: .whitespacesAndNewlines),
//              !text.isEmpty,
//              let value = Double(text) else {
//            showAlert(message: "Digite um valor válido")
//            return nil
//        }
//        
//        if value <= self.value{
//            return value
//        } else {
//            showAlert(message: "O valor solicitado é maior que o valor disponível.")
//            return nil
//        }
//    }
    
    
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

extension RequestCashBackViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(cashLabel)
        containerView.addSubview(moneyLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(pixTextField)
        containerView.addSubview(requestPixButton)
        containerView.addSubview(nextInvoiceButton)
    }
    
    func setupConstraints() {
        containerView.anchor(
            left: view.leftAnchor,
            right: view.rightAnchor,
            centerY: view.centerYAnchor,
            leftConstant: 35,
            rightConstant: 35,
        )
        
        cashLabel.anchor(
            top: containerView.topAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            topConstant: 30
        )
        
        moneyLabel.anchor(
            top: cashLabel.bottomAnchor,
            centerX: containerView.centerXAnchor,
            topConstant: 40
        )
        
        descriptionLabel.anchor(
            top: moneyLabel.bottomAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor
        )
        
        pixTextField.anchor(
            top: descriptionLabel.bottomAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            topConstant: 18,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 70
        )
        
        requestPixButton.anchor(
            top: pixTextField.bottomAnchor,
            left: nextInvoiceButton.leftAnchor,
            right: nextInvoiceButton.rightAnchor,
            topConstant: 40,
            heightConstant: 50
        )
        
        nextInvoiceButton.anchor(
            top: requestPixButton.bottomAnchor,
            left: containerView.leftAnchor,
            bottom: containerView.bottomAnchor,
            right: containerView.rightAnchor,
            topConstant: 20,
            leftConstant: 20,
            bottomConstant: 50,
            rightConstant: 20,
            heightConstant: 50
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.isOpaque = true
    }
}

extension RequestCashBackViewController: RequestCashBackViewModelDelegate {
    func success() {
        
        showAlert(message: "Solicitado com sucesso!") { [weak self] in
            guard let self else {return}
            self.dismiss(animated: true)
            delegate?.success()
        }
        
    }
    
    func error(message: String) {
        showAlert(message: message)
    }
}
