//
//  CashbackViewModel.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 19/12/24.
//

import UIKit

protocol CashbackViewModelDelegate: AnyObject{
    func success(value: Double)
    func error(message: String)
   
}

class CashbackViewModel{
    
    //MARK: Variables and Constants
    weak var delegate: CashbackViewModelDelegate?
    let apiService: APIService
    var cashback: [CashbackModel] = []
    var companyId: Int? = nil
    var userId: Int? = nil
    
    var value: Double = 0
    
    //MARK: Initializers
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func getCashback(){
        
        apiService.getCashbackListAndValue { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                cashback.removeAll()
                for i in success.separatedCashbacks{
                    let cashbacks = CashbackModel(
                        value: i.payment, cashBackValue: i.cashbackValue,
                        date: i.paymentDate)
                    cashback.append(cashbacks)
                    self.value = success.totalValue
                    delegate?.success(value: success.totalValue)
                }
                
                print(success)
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
    
    var numberOfCashbacks: Int{
        return cashback.count
    }
    
    func getCashbacks(index: Int) -> CashbackModel{
        return cashback[index]
    }
    
    func calculateTotalValue() -> Double {
        return cashback.reduce(0) { partialResult, cashback in
            partialResult + (Double(cashback.value) ?? 0)
        }
    }

    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // Define o formato brasileiro
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$" // Define o símbolo da moeda
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "R$0,00"
    }
    
    
    func getMyself() {
        apiService.getMyself { [weak self ] result in
            switch result {
            case .success(let success):
                self?.companyId = success.companyId
                self?.userId = success.id
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
}



