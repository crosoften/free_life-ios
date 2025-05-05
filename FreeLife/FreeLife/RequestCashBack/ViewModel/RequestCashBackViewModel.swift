//
//  RequestCashBackViewModel.swift
//  FreeLife
//
//  Created by Jeferson Dias dos Santos on 09/04/25.
//

import UIKit

protocol RequestCashBackViewModelDelegate: AnyObject{
    func success()
    func error(message: String)
   
}

class RequestCashBackViewModel{
    
    //MARK: Variables and Constants
    weak var delegate: RequestCashBackViewModelDelegate?
    let apiService: APIService

    //MARK: Initializers
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func requestCashback(pixKey: String?, value: Double, status: CashbackStatus = .solicitado, solicitationType: SolicitationType, userId: Int, companyId: Int ){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.string(from: Date())

        let request = RequestCashBack(
            date: todayString,
            value: value,
            redeemed: true,
            status: status.rawValue,
            solicitation: solicitationType.rawValue,
            userId: userId,
            companyId: companyId,
            pixKey: pixKey
        )
        
        
        apiService.requestCashBack(modelRequest: request) {  [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(_):
                    delegate?.success()
                
                
            case .failure(let error):
                if let error = error as? APIMessageError{
                    delegate?.error(message: error.error)
                    print(error)
                }else{
                    print(error)
                }
            }
        }
    }
    
    
}



