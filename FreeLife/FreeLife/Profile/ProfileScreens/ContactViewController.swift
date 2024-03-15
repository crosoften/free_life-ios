//
//  ContactViewController.swift
//  Jonas
//
//  Created by ihan carlos on 12/09/23.
//

import UIKit

class ContactViewController: UIViewController {
    
    let viewModel = ContactViewModel()

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
    
    lazy var nameTextField: CustomTextFieldUsualy = {
        let textField = CustomTextFieldUsualy()
        textField.titleTextField.text = "Nome"
        textField.textField.placeholder = "Seu nome"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var emailTextField: CustomTextFieldUsualy = {
        let textField = CustomTextFieldUsualy()
        textField.titleTextField.text = "Email"
        textField.textField.placeholder = "mail@email.com"
        textField.textField.autocapitalizationType = .none
        textField.textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var titleTextView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mensagem"
        label.font = .dsFonts(.subTitle)
        label.textColor = .black
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
        button.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedSendButton() {
        guard let name = nameTextField.textField.text, !name.isEmpty,
              let email = emailTextField.textField.text, !email.isEmpty,
              let message = textView.text, !message.isEmpty
        else {
            exibirAlerta(mensagem: "Por favor, preencha todos os campos")
            return
        }
        
        viewModel.postComment(name: name, email: email, message: message) { result in
            switch result {
            case .success(let message):
                self.exibirAlerta(title: "Sucesso", mensagem: message)
                self.clearFields()
            case .failure(let error):
                switch error {
                case .noConnectivity:
                    self.exibirAlerta(mensagem: "Sem conexão com a internet. Por favor, tente novamente mais tarde")
                case .unauthorized(let message):
                    self.exibirAlerta(mensagem: message ?? "Ocorreu um erro. Tente novamente mais tarde")
                default:
                    self.exibirAlerta(mensagem: "Erro interno no servidor.")
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func exibirAlerta(title: String = "Erro", mensagem: String) {
        let alert = UIAlertController(title: title, message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearFields() {
        nameTextField.textField.text = ""
        emailTextField.textField.text = ""
        textView.text = ""
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
