//
//  LoginViewModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 11/03/24.
//


import Foundation

protocol LoginViewModelDelegate: AnyObject{
    
    func loginSuccess()
    func companySuccess()
    func loginError(message: String)
}

class LoginViewModel{
    
    //MARK: Variable and Constants
    weak var delegate: LoginViewModelDelegate?
    let apiService: APIService
    var companies: [CompanyModel] = []
    
    //MARK: Initializers
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    //MARK: Functions
    func login(modelRequest: LoginRequest){
        apiService.login(modelRequest: modelRequest) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                AuthManager.shared.setAuthToken(success.token)
                delegate?.loginSuccess()
                print(success)
            case .failure(let error):
                if let error = error as? APIMessageError{
                    delegate?.loginError(message: error.error)
                    print(error)
                }else{
                    print(error)
                }
            }
        }
    }
    
    func getCompany(modelRequest: CompanyRequest){
        apiService.getCompany(modelRequest: modelRequest) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                self.companies.removeAll()
                for c in success{
                    let model = CompanyModel(
                        name: c.name,
                        id: c.id
                    )
                    self.companies.append(model)

                }
                delegate?.companySuccess()
                print(success)
            case .failure(let error):
                if let error = error as? APIMessageError{
                    delegate?.loginError(message: error.error)
                    print(error)
                }else{
                    print(error)
                }
            }
        }
    }
    
    
}


