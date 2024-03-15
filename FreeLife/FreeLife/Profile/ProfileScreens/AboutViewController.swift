//
//  AboutViewController.swift
//  Jonas
//
//  Created by ihan carlos on 12/09/23.
//

import UIKit

class AboutViewController: UIViewController {
    
    var viewModel = ContentViewModel()
    
    lazy var navBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.titleLabel.text = "SOBRE"
        nav.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return nav
    }()
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }

    lazy var titleVersion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Versão instalada"
        label.font = .dsFonts(.poppinsBold14)
        label.textColor = .black
        return label
    }()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1.5.00.1"
        label.font = .dsFonts(.poppinsNormal12)
        label.textColor = .black
        return label
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .ds(.logo)
        return image
    }()
    
    lazy var aboutTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sobre"
        label.font = .dsFonts(.poppinsBold14)
        label.textColor = .black
        return label
    }()
    
    lazy var aboutLabel: UILabel = {
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

extension AboutViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(navBar)
        view.addSubview(titleVersion)
        view.addSubview(versionLabel)
        view.addSubview(logoImage)
        view.addSubview(aboutTitleLabel)
        view.addSubview(aboutLabel)
    }
    
    func setupConstraints() {
        navBar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 20
        )
        
        titleVersion.anchor(
            top: navBar.bottomAnchor,
            left: view.leftAnchor,
            topConstant: 60,
            leftConstant: 20
        )
        
        versionLabel.anchor(
            top: titleVersion.bottomAnchor,
            left: titleVersion.leftAnchor,
            topConstant: 8
        )
        
        aboutTitleLabel.anchor(
            top: versionLabel.bottomAnchor,
            left: versionLabel.leftAnchor,
            topConstant: 12
        )
        
        logoImage.anchor(
            top: titleVersion.topAnchor,
            right: view.rightAnchor,
            rightConstant: 20,
            widthConstant: 166,
            heightConstant: 63
        )
        
        aboutLabel.anchor(
            top: aboutTitleLabel.bottomAnchor,
            left: aboutTitleLabel.leftAnchor,
            right: logoImage.rightAnchor,
            heightConstant: 100
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
    
    private func getContent() {
        viewModel.getContent(type: .about) { result in
            switch result {
            case .success(let model):
                self.aboutLabel.text = model.content
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
