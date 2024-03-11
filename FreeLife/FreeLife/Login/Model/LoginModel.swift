//
//  LoginModel.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 11/03/24.
//

import Foundation

public protocol Model: Codable, Equatable {}

struct LoginModel: Model {
    var token: String
    var user: User
}

struct User: Model {
    var id: Int
    var name: String
    var email: String
    var type: String
}
