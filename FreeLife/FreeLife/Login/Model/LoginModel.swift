//
//  LoginModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 11/03/24.
//

import Foundation

public protocol Model: Codable, Equatable {}

struct LoginModel: Model {
    var account: User
    var token: String
}

struct User: Model {
    var id: Int
    var role: String
    var type: String
    var name: String
}
