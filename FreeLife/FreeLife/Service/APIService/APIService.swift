//
//  APIService.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 17/12/24.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"//LEITURA
    case post = "POST"//GRAVAÇÃO
    case put = "PUT"//EDICAO
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case requestFailed
    case invalidData
    case invalidURL
    case invalidToken
    case responseProblem(Int)
    case encodingProblem
}

struct APIMessageError: Codable, Error {
    let error: String
}

class APIService {
    static let shared = APIService()
    
    
    func request<T: Codable>(method: HTTPMethod, endpoint: String, parameters: [String: Any]? = nil, tokenRequired: Bool? = true, completion: @escaping (Result<T, Error>) -> Void) {
        
        var urlComponents = URLComponents(string: "\(BaseUrlManager.baseUrl)\(endpoint)")!
//        var urlComponents = URLComponents(string: "https://freelifeconect.app.br:8080\(endpoint)")!
        
        if method == .get, let parameters = parameters {
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let stringValue = String(describing: value)
                let queryItem = URLQueryItem(name: key, value: stringValue)
                queryItems.append(queryItem)
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if tokenRequired == true {
            guard let token = AuthManager.shared.getAuthToken() else {return
                print("token inválido")}
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if method == .post || method == .put, let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        //        printRequest(request: request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.requestFailed))
                return
            }
//            if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("Response String: \(responseString)") // Exibe a resposta como string
//            } else {
//                print("No data or unable to convert data to string.")
//            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            
            
            //            self.printResponse(response: response, data: data, request: request)
            
            //            let statusCode = httpResponse.statusCode
            //            if !(200...299).contains(statusCode) {
            //                completion(.failure(APIError.responseProblem(statusCode)))
            //                if let decodedError = try? JSONDecoder().decode(APIMessageError.self, from: data) {
            //                    let message = decodedError.error ?? "Erro desconhecido"
            //                }
            //                return
            //            }
            let statusCode = httpResponse.statusCode
            if !(200...299).contains(statusCode) {
                if let decodedError = try? JSONDecoder().decode(APIMessageError.self, from: data) {
                    completion(.failure(decodedError))
                    // Você pode passar o erro para o completion aqui, se necessário
                } else {
                    print("Não foi possível decodificar a mensagem de erro")
                }
                
                completion(.failure(APIError.responseProblem(statusCode)))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(APIError.invalidData))
            }
        }.resume()
    }
    
    private func upload<T: Codable>(
        fileURL: URL,
        completion: @escaping (Result<T, Error>) -> Void) {
            let boundary = UUID().uuidString
            let fieldName = "file"
            let fileName = fileURL.lastPathComponent
            
            guard let url = URL(string: "https://freelifeconect.app.br:8080/uploadFile") else {
                completion(.failure(APIError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            guard let token = AuthManager.shared.getAuthToken() else {return
                print("token inválido")}
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var body = Data()
            let boundaryPrefix = "--\(boundary)\r\n"
            
            body.append(Data(boundaryPrefix.utf8))
            body.append(Data("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n".utf8))
            body.append(Data("Content-Type: audio/mpeg\r\n\r\n".utf8))
            if let audioData = try? Data(contentsOf: fileURL) {
                body.append(audioData)
            }
            body.append(Data("\r\n".utf8))
            body.append(Data("--\(boundary)--\r\n".utf8))
            
            request.httpBody = body
            
            //        printRequest(request: request)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(APIError.requestFailed))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(APIError.invalidData))
                    return
                }
                
                //            self.printResponse(response: response, data: data, request: request)
                
                let statusCode = httpResponse.statusCode
                if !(200...299).contains(statusCode) {
                    completion(.failure(APIError.responseProblem(statusCode)))
                    if let decodedError = try? JSONDecoder().decode(APIMessageError.self, from: data) {
                        let message = decodedError.error ?? "Erro desconhecido"
                        // Aqui você pode fazer algo com a mensagem de erro, se necessário
                    }
                    return
                }
                
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(APIError.invalidData))
                }
            }.resume()
        }
    
    private func createFormData(parameters: [String: Any], boundary: String) -> Data {
        var body = Data()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.append(Data(boundaryPrefix.utf8))
            
            if let fileData = value as? Data {
                let fileName = UUID().uuidString + ".jpg"
                body.append(Data("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(fileName)\"\r\n".utf8))
                body.append(Data("Content-Type: image/jpeg\r\n\r\n".utf8))
                body.append(fileData)
                body.append(Data("\r\n".utf8))
            } else if let stringValue = value as? String {
                body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
                body.append(Data("\(stringValue)\r\n".utf8))
            }
        }
        
        body.append(Data("--\(boundary)--\r\n".utf8))
        return body
    }
    
    
    func requestWithFormData<T: Codable>(method: HTTPMethod, endpoint: String, parameters: [String: Any], tokenRequired: Bool = true, completion: @escaping (Result<T, Error>) -> Void) {
        
        let boundary = UUID().uuidString
        guard let url = URL(string: "https://freelifeconect.app.br:8080\(endpoint)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if tokenRequired {
            guard let token = AuthManager.shared.getAuthToken() else {
                completion(.failure(APIError.invalidToken))
                return
            }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createFormData(parameters: parameters, boundary: boundary)
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if !(200...299).contains(statusCode) {
                if let decodedError = try? JSONDecoder().decode(APIMessageError.self, from: data) {
                    completion(.failure(decodedError))
                } else {
                    completion(.failure(APIError.responseProblem(statusCode)))
                }
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(APIError.invalidData))
            }
        }.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
    
    // MARK: POST METHODS
        
        func login(modelRequest: LoginRequest, completion: @escaping(Result<LoginResponse,Error>) -> Void) {
            let endpoint = "/auth/login"
            
            let parameters: [String: Any] = [
                "cpf" : modelRequest.cpf,
                "companyId" : modelRequest.companyId,
            ]
            
            request(method: .post, endpoint: endpoint, parameters: parameters, tokenRequired: false, completion: completion)
        }
    
    func postTicket(modelRequest: SendTicketRequest, completion: @escaping(Result<MessageResponse,Error>) -> Void) {
        let endpoint = "/debts/send-boleto"
        // 🔹 Formatador de valor decimal no padrão brasileiro
               let formatter = NumberFormatter()
               formatter.locale = Locale(identifier: "pt_BR")
               formatter.numberStyle = .decimal
               formatter.minimumFractionDigits = 2
               formatter.maximumFractionDigits = 2
               
               // 🔹 Garante que "valor" será string no formato esperado
               var valorFormatado = modelRequest.value
               if let doubleValue = Double(modelRequest.value.replacingOccurrences(of: ",", with: ".")) {
                   valorFormatado = formatter.string(from: NSNumber(value: doubleValue)) ?? modelRequest.value
               }
               
        let parameters: [String: Any] = [
            "valor" : valorFormatado,
           "data_emissao" : modelRequest.issueDate.toBRDateFormat(),   // 31/10/2024
            "data_vencimento" : modelRequest.date.toBRDateFormat(),     // 10/09/2025
            "codigo_barras" : modelRequest.code,
            "email" : modelRequest.email
        ]

               
               print(parameters)
        request(method: .post, endpoint: endpoint, parameters: parameters, tokenRequired: true) { (result: Result<MessageResponse, Error>) in
            
            switch result {
            case .success(let response):
                // Se a função request retornar HTTPURLResponse junto, você poderia acessar statusCode aqui
                print("Requisição bem sucedida")
                print("Retorno da API: \(response)")
                completion(.success(response))
                
            case .failure(let error):
                // Aqui imprimimos o erro da requisição
                print("Erro na requisição: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }



    
    func requestCashBack(modelRequest: RequestCashBack, completion: @escaping(Result<RequestCashbackResponse,Error>) -> Void) {
        let endpoint = "/cashbacks"
        
        var parameters: [String: Any] = [
            "date" : modelRequest.date,
            "value" : modelRequest.value,
            "redeemed" : modelRequest.redeemed,
            "status" : modelRequest.status,
            "solicitation" : modelRequest.solicitation,
            "userId" : modelRequest.userId,
            "companyId" : modelRequest.companyId
        ]

        if let pixKey = modelRequest.pixKey {
            parameters["pixKey"] = pixKey
        }
        
        request(method: .post, endpoint: endpoint, parameters: parameters, tokenRequired: true, completion: completion)
    }

    
    // MARK: GET METHODS
    
    func getDebits(modelRequest: DebitsRequest,completion: @escaping(Result<DebitsResponse,Error>) -> Void){
        let endpoint = "/debts"
        
        var parameters: [String: Any] = [:]
        
        if let search = modelRequest.search{
            parameters["search"] = search
        }
        if let page = modelRequest.page{
            parameters["page"] = page
        } else {
            parameters["page"] = 1
        }
        if let size = modelRequest.size{
            parameters["size"] = size
        } else {
            parameters["size"] = 100
        }
        
        request(method: .get, endpoint: endpoint, parameters: parameters, tokenRequired: true, completion: completion)
        
    }
    
    func getDetailsDebits(modelRequest: DebtsIdRequest, completion: @escaping(Result<DebtIdResponse,Error>) -> Void){
        let endpoint = "/debts/\(modelRequest.id)"
        
        let parameters: [String: Any] = [
            "id" : modelRequest.id,
        ]
        
        request(method: .get, endpoint: endpoint,parameters: parameters,tokenRequired: true, completion: completion)
    }
    
    func getCompany(modelRequest: CompanyRequest,completion: @escaping(Result<[CompanyResponse],Error>) -> Void){
        let endpoint = "/companies"
        
        var parameters: [String: Any] = [:]
        
        if let status = modelRequest.status{
            parameters["status"] = status
        }
        if let search = modelRequest.search{
            parameters["search"] = search
        }
        if let page = modelRequest.page{
            parameters["page"] = page
        }
        if let size = modelRequest.size{
            parameters["size"] = size
        }
        
        request(method: .get, endpoint: endpoint, parameters: parameters, tokenRequired: false, completion: completion)
    }
    
    func getDebitsIxcsoft( completion: @escaping(Result<AccountsPayableResponse,Error>) -> Void){
        let endpoint = "/debts/ixcsoft/pagar"
        
        request(method: .get, endpoint: endpoint,tokenRequired: true, completion: completion)
    }
    
    
    func getDebitsNew( completion: @escaping(Result<FinanceRecordResponse,Error>) -> Void){
        let endpoint = "/pega-debitos"
        
        request(method: .get, endpoint: endpoint,tokenRequired: true, completion: completion)
    }
    
    func getCashback( completion: @escaping(Result<[CashBackData],Error>) -> Void){
        let endpoint = "/cashbacks"
        
        request(method: .get, endpoint: endpoint,tokenRequired: true, completion: completion)
    }
    
    func getCashbackListAndValue( completion: @escaping(Result<CashbackListResponse,Error>) -> Void){
        let endpoint = "/cashbacks/bills-history"
        
        request(method: .get, endpoint: endpoint,tokenRequired: true, completion: completion)
    }
    
    func getMyself( completion: @escaping(Result<MySelfResponse,Error>) -> Void){
        let endpoint = "/auth/myself"
        
        request(method: .get, endpoint: endpoint,tokenRequired: true, completion: completion)
    }
    
}
