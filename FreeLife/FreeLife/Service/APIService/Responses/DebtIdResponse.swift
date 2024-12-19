//
//  DebtIdResponse.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 18/12/24.
//

import Foundation

struct DebtIdResponse: Codable {
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
