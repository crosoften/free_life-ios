//
//  AuthManager.swift
//  EzRent
//
//  Created by Rafaella Rodrigues Santos on 15/08/24.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()

    private init() {}

    private let userDefaults = UserDefaults.standard

    private var authToken: String? {
        get {
            return userDefaults.string(forKey: "AuthToken")
        }
        set {
            userDefaults.set(newValue, forKey: "AuthToken")
        }
    }

    func setAuthToken(_ token: String) {
        authToken = token
    }

    func getAuthToken() -> String? {
        return authToken
    }

    func logout() {
        authToken = nil
        userDefaults.synchronize()
    }

    static func isTokenEmpty() -> Bool {
        return shared.authToken == nil || shared.authToken?.isEmpty ?? true
    }
}
