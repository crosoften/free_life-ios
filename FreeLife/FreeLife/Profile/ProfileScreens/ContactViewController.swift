//
//  ContactViewController.swift
//  Jonas
//
//  Created by ihan carlos on 12/09/23.
//

import UIKit

class ContactViewController: UIViewController {

    lazy var navBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.titleLabel.text = "CONTATO"
        nav.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return nav
    }()
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fale com a gente!"
        label.font = .dsFonts(.poppinsBold14)
        label.textColor = .ds(.generalBlue)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Duvidas, sugestões ou reclamações? Entre em contato e retornaremos pelo e-mail informado!"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nameTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(title: "Nome", placeholderLabel: "Seu nome")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var emailTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(title: "Senha", placeholderLabel: "mail@email.com", imageset: .ds(.profileBlue))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var titleTextView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mensagem"
        label.font = .dsFonts(.subTitle)
        label.textColor = .ds(.lighGray)
        return label
    }()
    
    lazy var textView: UITextView = {
        let textV = UITextView()
        textV.translatesAutoresizingMaskIntoConstraints = false
        textV.layer.cornerRadius = 8
        textV.backgroundColor = .ds(.lighGray)
        return textV
    }()
    
    lazy var loginButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .containedQuadDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar", for: .normal)
//        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension ContactViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(navBar)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(titleTextView)
        view.addSubview(textView)
        view.addSubview(loginButton)
    }
    
    func setupConstraints() {
        navBar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 20
        )
        
        titleLabel.anchor(
            top: navBar.bottomAnchor,
            centerX: view.centerXAnchor,
            topConstant: 58
        )
        
        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            centerX: view.centerXAnchor,
            topConstant: 18,
            widthConstant: 233
        )
        
        nameTextField.anchor(
            top: descriptionLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 10,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 72
        )
        
        emailTextField.anchor(
            top: nameTextField.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 10,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 72
        )
        
        titleTextView.anchor(
            top: emailTextField.bottomAnchor,
            left: emailTextField.leftAnchor,
            topConstant: 20
        )
        
        textView.anchor(
            top: titleTextView.bottomAnchor,
            left: titleTextView.leftAnchor,
            right: emailTextField.rightAnchor,
            heightConstant: 200
        )
        
        loginButton.anchor(
            top: textView.bottomAnchor,
            left: textView.leftAnchor,
            right: textView.rightAnchor,
            topConstant: 10,
            heightConstant: 50
        )
        
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}
