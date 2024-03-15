//
//  TermsOfUseViewController.swift
//  Jonas
//
//  Created by ihan carlos on 12/09/23.
//

import UIKit

class TermsOfUseViewController: UIViewController {
    
    let viewModel = ContentViewModel()

    lazy var navBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.titleLabel.text = "TERMOS DE USO"
        nav.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return nav
    }()
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }

    lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Exemple"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getContent()
    }
}

extension TermsOfUseViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(navBar)
        view.addSubview(termsLabel)
    }
    
    func setupConstraints() {
        navBar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 20
        )
        
        termsLabel.anchor(
            top: navBar.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            leftConstant: 20,
            rightConstant: 20
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
    
    private func getContent() {
        viewModel.getContent(type: .terms) { result in
            switch result {
            case .success(let model):
                self.termsLabel.text = model.content
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
        }
    }
    
    func exibirAlerta(title: String = "Erro", mensagem: String) {
        let alert = UIAlertController(title: title, message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

