//
//  LoginViewModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 11/03/24.
//

import Foundation

class LoginViewModel {
    
    func login(email: String, password: String, completion: @escaping (Result<LoginModel, Error>) -> Void) {
        let body: Parameters = [
            "email": email,
            "password": password
        ]
        
        Service.shared.request(url: "v1/sessions/standard", method: .post, parameters: body, response: LoginModel.self) { result in
            switch result {
            case .success(let loginModel):
                completion(.success(loginModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func login2(email: String, password: String, completion: @escaping (Result<LoginModel, DomainError>) -> Void) {

        guard let url = URL(string:"https://directnuv.com.br:8080/v1/sessions/standard") else { return }
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
