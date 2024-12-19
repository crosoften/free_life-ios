//
//  CashbackResponse.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 19/12/24.
//

import Foundation

struct CashBackResponse: Codable {
    let data: [CashBackData]
//    let totalItems: Int
//    let totalPages: Int
//    let itemsPerPage: Int
//    let page: Int
}

struct CashBackData: Codable {
//    let id: Int
    let date: String
    let value: Double
//    let status: String
//    let redeemed: Bool
//    let solicitation: String
//    let createdAt: String
//    let updatedAt: String
//    let user: User
}


