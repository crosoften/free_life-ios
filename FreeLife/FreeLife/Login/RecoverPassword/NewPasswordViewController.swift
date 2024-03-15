//
//  NewPasswordViewController.swift
//  Jonas
//
//  Created by ihan carlos on 13/09/23.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    var viewModel: NewPasswordViewModel?
    
    convenience init(viewModel: NewPasswordViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
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
        label.text = "Nova senha"
        label.font = .dsFonts(.title)
        label.textColor = .ds(.generalBlue)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cadastre a sua nova senha utilizando números e caracteres:"
        label.font = .dsFonts(.text)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var codeTextField: CustomTextFieldUsualy = {
        let textField = CustomTextFieldUsualy()
        textField.titleTextField.text = "Código"
        textField.textField.placeholder = "Insira o código enviado para seu e-mail"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(title: "Senha", placeholderLabel: "**********", imageset: .ds(.lock))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var showPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.ds(.eye), for: .normal)
        button.addTarget(self, action: #selector(showPasswordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func showPasswordButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTextField.textField.isSecureTextEntry = !sender.isSelected
    }
    
    lazy var confirmedPasswordTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(title: "Confirmar senha", placeholderLabel: "**********", imageset: .ds(.lock))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var showConfirmedPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.ds(.eye), for: .normal)
        button.addTarget(self, action: #selector(showConfirmedPasswordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func showConfirmedPasswordButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        confirmedPasswordTextField.textField.isSecureTextEntry = !sender.isSelected
    }
    
    lazy var confirmedButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .containedQuadDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Redefinir", for: .normal)
        button.addTarget(self, action: #selector(tappedConfirmedButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedConfirmedButton() {
        
        guard let password = passwordTextField.textField.text, !password.isEmpty,
              let confirmedPassword = confirmedPasswordTextField.textField.text, !confirmedPassword.isEmpty,
              let code = codeTextField.textField.text, !code.isEmpty else {
            customAlert(title: "Erro ao redefinir", message: "Por favor, preencha todos os campos.")
            return
        }
        
        if !TextFieldValidator.validateText(for: .password, text: password) {
            customAlert(title: "Erro ao redefinir", message: "Sua senha deve conter no mínimo 8 caractéres incluindo uma letra!")
            return
        }
        
        if confirmedPassword != password {
            customAlert(title: "Erro ao redefinir", message: "As senhas não coencidem!")
        }
        
        viewModel?.postResetPassword(password: password, passwordConfirmation: confirmedPassword, code: code, completion: { result in
            switch result {
            case .success(let message):
                self.exibirAlerta(mensagem: message,title: "Senha atualizada.", handler: self.goToLogin)
            case .failure(let error):
                switch error {
                case .noConnectivity:
                    self.exibirAlerta(mensagem: "Sem conexão com a internet. Por favor, tente novamente mais tarde")
                default:
                    self.exibirAlerta(mensagem: "Erro interno no servidor. Por favor, tente novamente mais tarde")
                }
            }
        })
//        customAlert(title: "Sucesso", message: "Sua senha foi redefinida!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        passwordTextField.textField.isSecureTextEntry = true
        passwordTextField.textField.rightView = showPasswordButton
        passwordTextField.textField.rightViewMode = .always
        
        confirmedPasswordTextField.textField.isSecureTextEntry = true
        confirmedPasswordTextField.textField.rightView = showConfirmedPasswordButton
        confirmedPasswordTextField.textField.rightViewMode = .always
    }
    
    private func goToLogin() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func exibirAlerta(mensagem: String, title: String = "Erro", handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension NewPasswordViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(titleView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(codeTextField)
        view.addSubview(passwordTextField)
        view.addSubview(showPasswordButton)
        view.addSubview(confirmedPasswordTextField)
        view.addSubview(showConfirmedPasswordButton)
        view.addSubview(confirmedButton)
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
            rightConstant: 34
        )
        
        codeTextField.anchor(
            top: descriptionLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 54,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 70
        )
        
        passwordTextField.anchor(
            top: codeTextField.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 70
        )
        
        showPasswordButton.anchor(
            right: passwordTextField.rightAnchor,
            centerY: passwordTextField.textField.centerYAnchor,
            rightConstant: 25,
            widthConstant: 20,
            heightConstant: 16
        )
        
        confirmedPasswordTextField.anchor(
            top: passwordTextField.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 15,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 70
        )
        showConfirmedPasswordButton.anchor(
            right: confirmedPasswordTextField.rightAnchor,
            centerY: confirmedPasswordTextField.textField.centerYAnchor,
            rightConstant: 25,
            widthConstant: 20,
            heightConstant: 16
        )
        
        confirmedButton.anchor(
            top: confirmedPasswordTextField.bottomAnchor,
            left: confirmedPasswordTextField.leftAnchor,
            right: confirmedPasswordTextField.rightAnchor,
            topConstant: 40,
            heightConstant: 50
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}
