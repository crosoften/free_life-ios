//
//  LoginViewController.swift
//  SurgicalData
//
//  Created by ihan carlos on 21/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()
    
        var selectedCompany: String?
        var selectedCompanyId: Int?
    
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
    
    lazy var cpfTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView(title: "CPF", placeholderLabel: "000.000.000-00", imageset: .ds(.profileBlue))
        textField.textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.text = "111.222.333-96"
        return textField
    }()
    
    lazy var companyPicker: UIPickerView = {
            let picker = UIPickerView()
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.delegate = self
            picker.dataSource = self
            picker.isHidden = true
            return picker
        }()
        
        lazy var showPickerButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Selecionar Empresa", for: .normal)
            button.setTitleColor(UIColor(named: "default"), for: .normal)
            button.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
            return button
        }()
    
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
    
    @objc private func showPicker() {
           companyPicker.isHidden.toggle()
       }
    
    @objc private func tappedLoginButton() {
        
        guard let email = cpfTextField.textField.text, !email.isEmpty else {
            customAlert(title: "Erro de login", message: "Por favor, preencha todos os campos.")
            return
        }
        
        guard let company = selectedCompany else {
                    exibirAlerta(mensagem: "Por favor, selecione uma empresa.")
                    return
                }
        

        
        startAnimation()
        
        let loginRequest = LoginRequest(
            cpf: cpfTextField.textField.text ?? "vazio",
            companyId: selectedCompanyId ?? 0
        )
        
        viewModel.login(modelRequest: loginRequest)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
        
        DispatchQueue.main.async {
            let companyRequest = CompanyRequest(status: nil, search: nil, page: nil, size: nil)
            
            self.viewModel.getCompany(modelRequest: companyRequest)
        }
        
        
    }
    
    private func startAnimation() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        loginButton.isEnabled = false
    }
    
    private func stopAnimation() {
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.isHidden = true
        self.loginButton.isEnabled = true
    }
}

extension LoginViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(logoImage)
        view.addSubview(cpfTextField)
        view.addSubview(loginButton)
        view.addSubview(loadingIndicator)
        view.addSubview(showPickerButton)
               view.addSubview(companyPicker)
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
        
        cpfTextField.anchor(
            top: logoImage.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 18,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 70
        )
        
        showPickerButton.anchor(
                    top: cpfTextField.bottomAnchor,
                    left: cpfTextField.leftAnchor,
                    right: cpfTextField.rightAnchor,
                    topConstant: 10,
                    heightConstant: 44
                )
                
                companyPicker.anchor(
                    top: showPickerButton.bottomAnchor,
                    left: showPickerButton.leftAnchor,
                    right: showPickerButton.rightAnchor,
                    heightConstant: 70
                )
        
        loginButton.anchor(
            top: companyPicker.bottomAnchor,
            left: cpfTextField.leftAnchor,
            right: cpfTextField.rightAnchor,
            topConstant: 70,
            heightConstant: 50
        )
        
        loadingIndicator.anchor(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor
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

extension LoginViewController: LoginViewModelDelegate{
    func companySuccess() {
        DispatchQueue.main.async {
            // Verifique se a lista de empresas está preenchida
            if !self.viewModel.companies.isEmpty {
                self.companyPicker.reloadAllComponents()  // Recarrega o picker
                self.showPickerButton.isHidden = false  // Torna o botão visível
            } else {
                self.showPickerButton.isHidden = true  // Se não houver empresas, esconde o botão
            }
        }
    }
    
    func loginSuccess() {
       
                        DispatchQueue.main.async {
                            let tabBar = TabBarController()
                            self.navigationController?.pushViewController(tabBar, animated: true)
                        }
    }
    
    func loginError(message: String) {
   
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style:.default)
        alert.addAction(okButton)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
                self.stopAnimation()
    }
    
    
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension LoginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.companies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Verifique se a quantidade de empresas é válida antes de acessar
        guard row < viewModel.companies.count else { return nil }
        return viewModel.companies[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row < viewModel.companies.count {
            selectedCompany = viewModel.companies[row].name
            showPickerButton.setTitle(viewModel.companies[row].name, for: .normal)
            companyPicker.isHidden = true
            selectedCompanyId = viewModel.companies[row].id
        }
    }
}
