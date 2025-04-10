//
//  CashbackResponse 2.swift
//  FreeLife
//
//  Created by Jeferson Dias dos Santos on 09/04/25.
//


import Foundation

struct CashbackListResponse: Codable {
    let userId: Int
    let totalValue: Double
    let separatedCashbacks: [SeparatedCashback]
}

struct SeparatedCashback: Codable {
    let paymentDate: String
    let payment: String
    let cashbackValue: Double
}
