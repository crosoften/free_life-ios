//
//  Service.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 11/03/24.
//

import Alamofire
import Foundation

class Service {
    
    static let shared = Service()
    private let session: Session = .default
    
    private init() {}
    
    func request(in url: URL,
               method: HTTPMethod,
               parameters: Parameters? = nil,
               headers: HTTPHeaders? = nil,
               encoding: JSONEncoding = .default,
               completion: @escaping (Result<Data?, HttpError>) -> Void) {
        session.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else {
                return completion(.failure(.noConnectivity)) }
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    if let data = dataResponse.data {
                        completion(.failure(.unauthorized(data: data)))
                    } else {
                        completion(.failure(.unauthorized(data: nil)))
                    }
                case 403:
                    completion(.failure(.forbidden))
                case 400...499:
                    if let data = dataResponse.data {
                        completion(.failure(.badRequest(data: data)))
                    } else {
                        completion(.failure(.badRequest(data: nil)))
                    }
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            }
        }
    }
}
