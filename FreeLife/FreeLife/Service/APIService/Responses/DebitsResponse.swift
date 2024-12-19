//
//  DebitsResponse.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 17/12/24.
//

import Foundation

struct DebitsResponse: Codable {
    let data: [Debit]
    let totalItems: Int
    let totalPages: Int
    let itemsPerPage: Int
    let page: Int
}

struct Debit: Codable {
    let id: Int
    let description: String
    let value: Double
    let dueDate: String
    let paymentDate: String
    let paymentMethod: String
    let referenceDate: String
    let status: String
    let userId: Int
    let createdAt: String
    let updatedAt: String
}

