//
//  HTTPError.swift
//  FreeLife
//
//  Created by Nikolas Gianoglou on 11/03/24.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest(data: Data?)
    case serverError
    case unauthorized(data: Data?)
    case forbidden
}
