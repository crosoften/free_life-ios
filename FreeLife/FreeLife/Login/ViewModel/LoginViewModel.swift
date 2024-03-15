//
//  LoginViewModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 11/03/24.
//

import Alamofire
import Foundation

class LoginViewModel {
    
    func login(email: String, password: String, completion: @escaping (Result<LoginModel, DomainError>) -> Void) {

        guard let url = URL(string:"https://freelifeconect.app.br:8080/auth/login") else { return }
        let body: Parameters = [
            "credential": email,
            "password": password
        ]
        Service.shared.request(in: url, method: .post, parameters: body) { result in
            switch result {
            case .success(let data):
                if let data = data, let loginModel = try? JSONDecoder().decode(LoginModel.self, from: data) {
                    completion(.success(loginModel))
                } else {
                    let jsonObject = try? JSONSerialization.jsonObject(with: data!)
                    print(jsonObject)
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .noConnectivity:
                    completion(.failure(.noConnectivity))
                case .badRequest:
                    completion(.failure(.unauthorized(message: nil)))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
