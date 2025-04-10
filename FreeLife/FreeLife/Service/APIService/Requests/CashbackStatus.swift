//
//  CashbackStatus.swift
//  FreeLife
//
//  Created by Jeferson Dias dos Santos on 09/04/25.
//


import Foundation

enum CashbackStatus: String {
    case solicitado = "solicitado"
    case aprovado = "aprovado"
    case recusado = "recusado"
    // adicione outros casos se houver
}

enum SolicitationType: String {
    case PIX = "PIX"
    case NEXT_BILL = "NEXT_BILL"
}

struct RequestCashBack: Codable {
    let date: String
    let value: Double
    let redeemed: Bool
    let status: CashbackStatus.RawValue
    let solicitation: SolicitationType.RawValue
    let userId: Int
    let companyId: Int
}
