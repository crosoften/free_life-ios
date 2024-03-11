//
//  DomainError.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 11/03/24.
//

import Foundation

public enum DomainError: Error {
    case unexpected
    case emailInUse
    case expiredSession
    case noConnectivity
    case unauthorized(message: String? = nil)
}
