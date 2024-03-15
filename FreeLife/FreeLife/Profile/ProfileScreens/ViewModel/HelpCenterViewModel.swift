//
//  HelpCenterViewModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 15/03/24.
//

import Foundation

class HelpCenterViewModel {
    
    var dataSource: [Question] = []
    
    func getFAQ(completion: @escaping (Result<Root, DomainError>) -> Void) {

        guard let url = URL(string:"https://freelifeconect.app.br:8080/faqs") else { return }
        
        Service.shared.request(in: url, method: .get) { result in
            switch result {
            case .success(let data):
                if let data = data, let root = try? JSONDecoder().decode(Root.self, from: data) {
                    self.dataSource = root.data
                    completion(.success(root))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .noConnectivity:
                    completion(.failure(.noConnectivity))
                case let .badRequest(data):
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
