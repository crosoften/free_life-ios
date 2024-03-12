//
//  NewPasswordViewModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 12/03/24.
//

import Alamofire
import Foundation

class NewPasswordViewModel {
    
    let email: String
    public var service = Service.shared
    
    init(email: String) {
        self.email = email
    }
    
    func postResetPassword(password: String, passwordConfirmation: String, code: String, completion: @escaping (Result<String, DomainError>) -> Void) {
        guard let url = URL(string: "https://18.206.107.193:8080/swagger/auth/reset-password") else {return}
        let body: Parameters = [
            "email": email,
            "code": code,
            "password": password,
            "confirmPassword": passwordConfirmation
        ]
//        let headers: HTTPHeaders = [.authorization(bearerToken: code.token)]
        service.request(in: url, method: .post, parameters: body) { result in
            switch result {
            case .success(let data):
                if let data = data, let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let message = dictionary["message"] as? String ?? ""
                    completion(.success(message))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .noConnectivity:
                    completion(.failure(.noConnectivity))
                case .badRequest:
                    completion(.failure(.unauthorized()))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
