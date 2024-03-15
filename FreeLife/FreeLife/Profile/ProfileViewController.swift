//
//  ProfileViewController.swift
//  FreeLife
//
//  Created by ihan carlos on 11/12/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var data : [ProfileCardsModel] = [
        ProfileCardsModel(title: "Alterar Senha", image: .ds(.replace)),
        ProfileCardsModel(title: "Sobre"),
        ProfileCardsModel(title: "Central de ajuda", image: .ds(.help)),
        ProfileCardsModel(title: "Termos de uso", image: .ds(.terms)),
        ProfileCardsModel(title: "Políticas de privacidade", image: .ds(.privacy)),
        ProfileCardsModel(title: "Contato", image: .ds(.contact)),
        ProfileCardsModel(title: "Sair", image: .ds(.exit)),
    ]
    
    lazy var profileImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        image.backgroundColor = .ds(.lighGray)
        return image
    }()
    
    lazy var addProfileButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.ds(.camera), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.layer.cornerRadius = 23
        button.addTarget(self, action: #selector(tappedAddProfile), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedAddProfile() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    lazy var profileLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome do usuário"
        label.font = .dsFonts(.subTitle)
        label.textColor = .black
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.separatorStyle = .none
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension ProfileViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(profileImage)
        view.addSubview(addProfileButton)
        view.addSubview(profileLabel)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        
        profileImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            centerX: view.centerXAnchor,
            topConstant: 30,
            widthConstant: 123,
            heightConstant: 123
        )
        
        addProfileButton.anchor(
            bottom: profileImage.bottomAnchor,
            right: profileImage.rightAnchor,
            widthConstant: 40,
            heightConstant: 40
        )
        
        profileLabel.anchor(
            top: profileImage.bottomAnchor,
            centerX: profileImage.centerXAnchor,
            topConstant: 18
        )
        
        tableView.anchor(
            top: profileLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 30
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell
        cell?.setUpCell(data: self.data[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
//        case 0:
//            let vc = FirstViewController()
//            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = AboutViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let vc = HelpCenterViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc = TermsOfUseViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = PrivacyPoliciesViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = ContactViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 6:
            navigationController?.popViewController(animated: true)
            
        default:
            break
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

