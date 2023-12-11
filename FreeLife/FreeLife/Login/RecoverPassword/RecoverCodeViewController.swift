//
//  RecoverCodeViewController.swift
//  Jonas
//
//  Created by ihan carlos on 13/09/23.
//

import UIKit

class RecoverCodeViewController: UIViewController {

    lazy var titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RECUPERAR SENHA"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var confirmedEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Confirmação via e-mail"
        label.font = .dsFonts(.title)
        label.textColor = .ds(.generalBlue)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Para confirmar se seu e-mail é válido, insira o código que você recebeu na sua caixa de entrada:"
        label.font = .dsFonts(.text)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var containerTextField: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pinTextField1: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.ds(.generalBlue).cgColor
        textField.layer.cornerRadius = 8
        textField.delegate = self
        textField.tag = 1
        return textField
    }()
    
    lazy var pinTextField2: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.ds(.generalBlue).cgColor
        textField.layer.cornerRadius = 8
        textField.delegate = self
        textField.tag = 2
        return textField
    }()
    
    lazy var pinTextField3: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.ds(.generalBlue).cgColor
        textField.layer.cornerRadius = 8
        textField.delegate = self
        textField.tag = 3
        return textField
    }()
    
    lazy var pinTextField4: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.ds(.generalBlue).cgColor
        textField.layer.cornerRadius = 8
        textField.delegate = self
        textField.tag = 4
        return textField
    }()
    
    lazy var confirmedButton: CustomButton = {
        let button = CustomButton(frame: .zero, style: .containedQuadDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirmar", for: .normal)
        button.addTarget(self, action: #selector(tappedConfirmedButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedConfirmedButton() {
        let vc = NewPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupTextFieldActions() {
        pinTextField1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        pinTextField2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        pinTextField3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        pinTextField4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let tag = textField.tag
        
        if let text = textField.text, !text.isEmpty {
            // Se o usuário digitou um número, vá para o próximo campo ou conclua se for o último.
            if tag < 4 {
                let nextTag = tag + 1
                if let nextTextField = view.viewWithTag(nextTag) as? UITextField {
                    nextTextField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                    // Aqui você pode verificar o PIN inserido pelos usuários.
                    // Compare o valor atual dos quatro campos de texto.
                }
            }
        } else {
            // Se o campo de texto está vazio (apagado), vá para o campo anterior.
            if tag > 1 {
                let previousTag = tag - 1
                if let previousTextField = view.viewWithTag(previousTag) as? UITextField {
                    previousTextField.becomeFirstResponder()
                }
            }
        }
    }
}


extension RecoverCodeViewController: ViewCodeType {
    
    func buildViewHierarchy() {
        view.addSubview(titleView)
        view.addSubview(confirmedEmailLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(containerTextField)
        containerTextField.addSubview(pinTextField1)
        containerTextField.addSubview(pinTextField2)
        containerTextField.addSubview(pinTextField3)
        containerTextField.addSubview(pinTextField4)
        view.addSubview(confirmedButton)
    }
        
    func setupConstraints() {
        titleView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            centerX: view.centerXAnchor,
            topConstant: 10
        )
        
        confirmedEmailLabel.anchor(
            top: titleView.bottomAnchor,
            centerX: view.centerXAnchor,
            topConstant: 53
        )
        
        descriptionLabel.anchor(
            top: confirmedEmailLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            centerX: view.centerXAnchor,
            topConstant: 10,
            leftConstant: 34,
            rightConstant: 34
        )
        
        containerTextField.anchor(
            top: descriptionLabel.bottomAnchor,
            centerX: view.centerXAnchor,
            topConstant: 36,
            widthConstant: 252,
            heightConstant: 50
        )
        
        pinTextField1.anchor(
            top: containerTextField.topAnchor,
            left: containerTextField.leftAnchor,
            widthConstant: 48,
            heightConstant: 48
        )
        
        pinTextField2.anchor(
            left: pinTextField1.rightAnchor,
            centerY: pinTextField1.centerYAnchor,
            leftConstant: 20,
            widthConstant: 48,
            heightConstant: 48
        )
        
        pinTextField3.anchor(
            left: pinTextField2.rightAnchor,
            centerY: pinTextField1.centerYAnchor,
            leftConstant: 20,
            widthConstant: 48,
            heightConstant: 48
        )
        
        pinTextField4.anchor(
            left: pinTextField3.rightAnchor,
            centerY: pinTextField1.centerYAnchor,
            leftConstant: 20,
            widthConstant: 48,
            heightConstant: 48
        )
        
        confirmedButton.anchor(
            top: containerTextField.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 40,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 50
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        setupTextFieldActions()
    }
}
    
extension RecoverCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

