//
//  HelpCenterViewController.swift
//  Jonas
//
//  Created by ihan carlos on 12/09/23.
//

import UIKit

class HelpCenterViewController: UIViewController {
    
    var viewModel = HelpCenterViewModel()

    lazy var navBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.titleLabel.text = "Perguntas frequentes"
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
    
    lazy var tableView: UITableView = {
       let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFAQ()
    }
}

extension HelpCenterViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(navBar)
        view.addSubview(searchBar)
        view.addSubview(tableView)
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
        
        tableView.anchor(
            top: searchBar.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 20,
            bottomConstant: 30
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}

extension HelpCenterViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Teste"
        return cell
    }
    
}

extension HelpCenterViewController {
    
    private func getFAQ() {
        viewModel.getFAQ { result in
            switch result {
            case .success(let model):
                self.viewModel.dataSource = model.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                switch error {
                case .noConnectivity:
                    self.exibirAlerta(mensagem: "Sem conexão com a internet. Por favor, tente novamente mais tarde")
                case .unauthorized:
                    self.exibirAlerta(mensagem: "Erro inesperado ao carregar a lista de cameras")
                default:
                    self.exibirAlerta(mensagem: "Ocorreu um erro inesperado. Por favor, tente novamente")
                }
            }
        }
    }
    
    func exibirAlerta(mensagem: String) {
        let alert = UIAlertController(title: "Erro", message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
