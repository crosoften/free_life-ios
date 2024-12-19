//
//  DetailsTicketViewModel.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 18/12/24.
//

import UIKit

protocol DetailsTicketViewModelDelegate: AnyObject{
    func success(message: String)
    func error(message: String)
}

class DetailsTicketViewModel{
    
    //MARK: Variables and Constants
    weak var delegate: DetailsTicketViewModelDelegate?
    let apiService: APIService
   
    //MARK: Initializers
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func postTicket(modelRequest: SendTicketRequest){
        apiService.postTicket(modelRequest: modelRequest) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                delegate?.success(message: success.message)
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



