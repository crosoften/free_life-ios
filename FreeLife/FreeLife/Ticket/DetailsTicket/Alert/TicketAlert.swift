//
//  TicketAlert.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 19/12/24.
//

import UIKit

class TicketAlert: UIViewController {
    
    lazy var alertView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "ENVIAR BOLETO"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var XButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tappedXButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedXButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var serviceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "Digite o e-mail que você quer receber o boleto:"
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    lazy var serviceTextfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "email@example.com"
        textfield.backgroundColor = .systemGray6
        textfield.layer.cornerRadius = 10
        textfield.autocapitalizationType = .none
        return textfield
    }()
   
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ENVIAR", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "default")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(tappedXButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addsubviews()
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            alertView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -40),
            
            XButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            XButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            
            serviceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            serviceLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            serviceLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            
            serviceTextfield.topAnchor.constraint(equalTo: serviceLabel.bottomAnchor, constant: 10),
            serviceTextfield.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            serviceTextfield.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            serviceTextfield.heightAnchor.constraint(equalToConstant: 50),
                        
            saveButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -30),
            saveButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func addsubviews() {
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(XButton)
        alertView.addSubview(serviceLabel)
        alertView.addSubview(serviceTextfield)
        alertView.addSubview(saveButton)
    }
}



