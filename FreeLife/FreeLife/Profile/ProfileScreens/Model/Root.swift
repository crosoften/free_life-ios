//
//  Root.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 15/03/24.
//

import Foundation

struct Root: Codable {
    var data: [Question]
    var countFaqs: Int
}

struct Question: Codable {
    var id: Int
    var question: String
    var answer: String
    var createdAt: String
    var updatedAt: String
}
