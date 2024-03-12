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

        guard let url = URL(string:"https://18.206.107.193:8080/swagger/auth/login") else { return }
        let body: Parameters = [
            "email": email,
            "password": password
        ]
        Service.shared.request(in: url, method: .post, parameters: body) { result in
            switch result {
            case .success(let data):
                if let data = data, let loginModel = try? JSONDecoder().decode(LoginModel.self, from: data) {
                    completion(.success(loginModel))
                } else {
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
