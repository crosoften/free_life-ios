//
//  ContactViewModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 14/03/24.
//

import Foundation

import Alamofire

class ContactViewModel {
    
    func postComment(name: String, email: String, message: String, completion: @escaping (Result<String, DomainError>) -> Void) {

        guard let url = URL(string:"https://freelifeconect.app.br:8080/contact") else { return }
        let body: Parameters = [
            "name": name,
            "email": email,
            "message": message,
        ]
        
        Service.shared.request(in: url, method: .post) { result in
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
                case let .unauthorized(data):
                    if let data = data, let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(.failure(.unauthorized(message: dictionary["error"] as? String)))
                    }
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
