//
//  LoginViewController.swift
//  SurgicalData
//
//  Created by ihan carlos on 21/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LOGIN"
        label.font = UIFont.dsFonts(.title)
        label.textColor = .black
        return label
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .ds(.logo)
        return image
    }()
    
    lazy var emailTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(title: "E-mail", placeholderLabel: "mail@email.com", imageset: .ds(.profileBlue))
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
    
    lazy var loginButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .containedQuadDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .ds(.generalBlue)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var recoverPassword: CustomButton = {
        let button = CustomButton(frame: .zero, style: .containedLight)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueci minha senha", for: .normal)
        button.addTarget(self, action: #selector(tappedRecoverButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedRecoverButton() {
        let vc = RecoverPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func tappedLoginButton() {
        
        guard let email = emailTextField.textField.text, !email.isEmpty,
              let senha = passwordTextField.textField.text, !senha.isEmpty else {
            customAlert(title: "Erro de login", message: "Por favor, preencha todos os campos.")
            return
        }
        
//        if !TextFieldValidator.validateText(for: .mail, text: email) {
//            customAlert(title: "Erro de email", message: "Email incorreto. Por favor, insira um email válido.")
//            return
//        }
//
//        if !TextFieldValidator.validateText(for: .password, text: senha) {
//            customAlert(title: "Erro de senha", message: "Sua senha está incorreta!")
//            return
//        }
        
        startAnimation()
        
        viewModel.login(email: email, password: senha) { result in
            switch result {
            case .success(let model):
                let tabBar = TabBarController()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(tabBar, animated: true)
                }
            case .failure(let error):
                switch error {
                case .noConnectivity:
                    self.exibirAlerta(mensagem: "Sem conexão com a internet. Por favor, tente novamente mais tarde")
                case .unauthorized:
                    self.exibirAlerta(mensagem: "Email ou senha incorretos. Por favor, tente novamente")
                default:
                    self.exibirAlerta(mensagem: "Ocorreu um erro inesperado. Por favor, tente novamente")
                }
            }
            self.stopAnimation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        passwordTextField.textField.isSecureTextEntry = true
        passwordTextField.textField.rightView = showPasswordButton
        passwordTextField.textField.rightViewMode = .always
    }
    
    private func startAnimation() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        loginButton.isEnabled = false
        recoverPassword.isEnabled = false
    }
    
    private func stopAnimation() {
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.isHidden = true
        self.loginButton.isEnabled = true
        self.recoverPassword.isEnabled = true
    }
}

extension LoginViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(logoImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(showPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(loadingIndicator)
        view.addSubview(recoverPassword)
    }
    
    func setupConstraints() {
        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            centerX: view.centerXAnchor
        )
        
        logoImage.anchor(
            top: titleLabel.bottomAnchor,
            centerX: view.centerXAnchor,
            topConstant: 51,
            widthConstant: 282,
            heightConstant: 107
        )
        
        emailTextField.anchor(
            top: logoImage.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 18,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 70
        )
        
        passwordTextField.anchor(
            top: emailTextField.bottomAnchor,
            left: emailTextField.leftAnchor,
            right: emailTextField.rightAnchor,
            topConstant: 20,
            heightConstant: 70
        )
        
        showPasswordButton.anchor(
            right: passwordTextField.rightAnchor,
            centerY: passwordTextField.textField.centerYAnchor,
            rightConstant: 25,
            widthConstant: 20,
            heightConstant: 16
        )
        
        loginButton.anchor(
            top: passwordTextField.bottomAnchor,
            left: passwordTextField.leftAnchor,
            right: passwordTextField.rightAnchor,
            topConstant: 40,
            heightConstant: 50
        )
        
        loadingIndicator.anchor(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor
        )
        
        recoverPassword.anchor(
            top: loginButton.bottomAnchor,
            left: loginButton.leftAnchor,
            right: loginButton.rightAnchor,
            heightConstant: 40
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension LoginViewController {
    func exibirAlerta(mensagem: String) {
        let alert = UIAlertController(title: "Erro de Login", message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
