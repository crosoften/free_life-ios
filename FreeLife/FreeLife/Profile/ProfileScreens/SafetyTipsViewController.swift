//
//  SafetyTipsViewController.swift
//  Jonas
//
//  Created by ihan carlos on 12/09/23.
//

import UIKit

class SafetyTipsViewController: UIViewController {

    lazy var navBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.titleLabel.text = "DICAS DE SEGURANÇA"
        nav.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return nav
    }()
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var searchBar: CustomSearchBar = {
        let search = CustomSearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension SafetyTipsViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(navBar)
        view.addSubview(searchBar)
    }
    
    func setupConstraints() {
        navBar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 20
        )
        
        searchBar.anchor(
            top: navBar.bottomAnchor,
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
    }
}

