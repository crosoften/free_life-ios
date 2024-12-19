//
//  LoginResponse.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 17/12/24.
//

import Foundation

struct LoginResponse: Codable {
    let token: String
    let account: Account

    struct Account: Codable {
        let id: Int
        let role: String
        let cpf: String
        let companyId: Int
    }
}
