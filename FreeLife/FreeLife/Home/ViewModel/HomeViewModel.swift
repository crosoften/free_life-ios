//
//  HomeViewModel.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 19/12/24.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject{
    func success(value: String)
    func error(message: String)
   
}

class HomeViewModel{
    
    //MARK: Variables and Constants
    weak var delegate: HomeViewModelDelegate?
    let apiService: APIService
    var ticket: [TicketModel] = []
   
    
    //MARK: Initializers
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func getTicket(){
        apiService.getDebitsIxcsoft() { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                ticket.removeAll()
                let ticketResponse = success.data.registros
                for i in ticketResponse{
                    let tickets = TicketModel(
                        date: i.dataVencimento,
                        createDate: i.dataEmissao,
                        value: i.valor,
                        originalValue: i.valor,
                        typePayment: i.tipoPagamento,
                        code: i.codigoBarras
                        )
                    ticket.append(tickets)
                }
                delegate?.success(value:  success.data.registros.first?.valor ?? "")
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
    
    var numberOfTickets: Int{
        return ticket.count
    }
    
    func getTicket(index: Int) -> TicketModel{
        return ticket[index]
    }
    
    func calculateTotalValue() -> Double {
        return ticket.reduce(0) { partialResult, ticket in
            partialResult + (Double(ticket.value) ?? 0)
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



