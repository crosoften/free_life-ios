//
//  RequestCashBackViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 08/12/23.
//

import UIKit

class RequestCashBackViewController: UIViewController {
    
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
        label.text = "Solicite o cashback no seu pix ou abata o valor na próxima fatura"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var pixTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(title: "Pix")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var requestButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .containedQuadDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Solicitar pix", for: .normal)
//        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var nextInvoiceButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .borderButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Abater na proxima fatura", for: .normal)
//        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension RequestCashBackViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(cashLabel)
        containerView.addSubview(moneyLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(pixTextField)
        containerView.addSubview(requestButton)
        containerView.addSubview(nextInvoiceButton)
    }
    
    func setupConstraints() {
        containerView.anchor(
            left: view.leftAnchor,
            right: view.rightAnchor,
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor,
            leftConstant: 35,
            rightConstant: 35,
            heightConstant: 400
        )
        
        cashLabel.anchor(
            top: containerView.topAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            topConstant: 10
        )
        
        moneyLabel.anchor(
            top: cashLabel.bottomAnchor,
            centerX: containerView.centerXAnchor,
            topConstant: 10
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
            leftConstant: 10,
            rightConstant: 10,
            heightConstant: 70
        )
        
        requestButton.anchor(
            left: nextInvoiceButton.leftAnchor,
            bottom: nextInvoiceButton.topAnchor,
            right: nextInvoiceButton.rightAnchor,
            bottomConstant: 10,
            heightConstant: 50
        )
        
        nextInvoiceButton.anchor(
            left: containerView.leftAnchor,
            bottom: containerView.bottomAnchor,
            right: containerView.rightAnchor,
            leftConstant: 10,
            bottomConstant: 10,
            rightConstant: 10,
            heightConstant: 50
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .clear
        view.isOpaque = true
    }
}
