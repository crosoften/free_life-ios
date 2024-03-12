//
//  RecoverPasswordViewController.swift
//  Jonas
//
//  Created by ihan carlos on 13/09/23.
//

import UIKit

class RecoverPasswordViewController: UIViewController {
    
    let viewModel: RecoverPasswordViewModel = RecoverPasswordViewModel()
    
    lazy var titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RECUPERAR SENHA"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Esqueceu sua senha?"
        label.font = .dsFonts(.title)
        label.textColor = .ds(.generalBlue)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite seu e-mail para que possamos enviar um codigo de verificação:"
        label.font = .dsFonts(.text)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(title: "E-mail", placeholderLabel: "mail@email.com", imageset: .ds(.profileBlue))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var sendButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .containedQuadDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedSendButton() {
        
        guard let email = emailTextField.textField.text, !email.isEmpty else {
            customAlert(title: "Erro ao recuperar", message: "Por favor, preencha todos os campos.")
            return
        }

        if !TextFieldValidator.validateText(for: .mail, text: email) {
            customAlert(title: "Erro ao recuperar", message: "Email incorreto. Por favor, insira um email válido.")
            return
        }
        
        viewModel.postGetCode(email: email) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let message):
                self.exibirAlerta(mensagem: message, title: "Verifique seu email", handler: self.presentNewPasswordViewController)
                let vc = NewPasswordViewController(viewModel: NewPasswordViewModel(email: email))
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                switch error {
                case .noConnectivity:
                    self.exibirAlerta(mensagem: "Sem conexão com a internet. Por favor, tente novamente mais tarde")
                case .unauthorized:
                    self.exibirAlerta(mensagem: "Usuário não encontrado na base de dados.")
                default:
                    self.exibirAlerta(mensagem: "Erro interno no servidor.")
                }
            }
        }
    }
    
    func exibirAlerta(mensagem: String) {
        let alert = UIAlertController(title: "Erro de Login", message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func exibirAlerta(mensagem: String, title: String = "Erro", handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentNewPasswordViewController() {
        let vc = NewPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RecoverPasswordViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(titleView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(emailTextField)
        view.addSubview(sendButton)
    }
    
    func setupConstraints() {
        titleView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            centerX: view.centerXAnchor,
            topConstant: 10
        )
        
        titleLabel.anchor(
            top: titleView.bottomAnchor,
            centerX: view.centerXAnchor,
            topConstant: 53
        )
        
        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            centerX: view.centerXAnchor,
            topConstant: 10,
            leftConstant: 34,
            rightConstant: 34,
            widthConstant: 270
        )
        
        emailTextField.anchor(
            top: descriptionLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 18,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 70
        )
        
        sendButton.anchor(
            top: emailTextField.bottomAnchor,
            left: emailTextField.leftAnchor,
            right: emailTextField.rightAnchor,
            topConstant: 40,
            heightConstant: 50
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}
