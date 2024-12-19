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
   
    
    //MARK: Initializers
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func getCashback(){
        apiService.getCashback() { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                cashback.removeAll()
                for i in success{
                    let cashbacks = CashbackModel(
                        value: i.value,
                        date: i.date)
                    cashback.append(cashbacks)
                    delegate?.success(value: i.value)
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
    
}



