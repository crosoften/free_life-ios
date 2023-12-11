//
//  TermsOfUseViewController.swift
//  Jonas
//
//  Created by ihan carlos on 12/09/23.
//

import UIKit

class TermsOfUseViewController: UIViewController {

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

    lazy var TermsLabel: UILabel = {
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
}

extension TermsOfUseViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(navBar)
        view.addSubview(TermsLabel)
    }
    
    func setupConstraints() {
        navBar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 20
        )
        
        TermsLabel.anchor(
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
    
}

