//
//  TicketViewModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 15/03/24.
//

import Foundation
import Alamofire

struct Debts: Codable {
    var id: Int
    var value: Int
    var status: String
    var paymentMethod: String
}

class TicketViewModel {
    
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func getDebts(completion: @escaping (Result<Debts, DomainError>) -> Void) {

        guard let url = URL(string:"https://freelifeconect.app.br:8080/debts") else { return }
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        Service.shared.request(in: url, method: .get, headers: headers) { result in
            switch result {
            case .success(let data):
                if let data = data, let root = try? JSONDecoder().decode(Debts.self, from: data) {
                    completion(.success(root))
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
