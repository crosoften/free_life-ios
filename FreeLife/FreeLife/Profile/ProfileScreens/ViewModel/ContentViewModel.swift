//
//  ContentViewModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 15/03/24.
//

import Foundation
import Alamofire

struct Content: Codable {
    var id: Int
    var type: String
    var content: String
}

enum ContentType: String {
    case about = "ABOUT"
    case terms = "TERMS"
    case privace = "PRIVACE"
}

class ContentViewModel {
    
    func getContent(type: ContentType, completion: @escaping (Result<Content, DomainError>) -> Void) {
        
        guard let url = URL(string:"https://freelifeconect.app.br:8080/texts") else { return }
        let body: Parameters = [
            "type": type.rawValue
        ]
        
        Service.shared.request(in: url, method: .get, parameters: body, encoding: URLEncoding.queryString) { result in
            switch result {
            case .success(let data):
                if let data = data, let root = try? JSONDecoder().decode(Content.self, from: data) {
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
