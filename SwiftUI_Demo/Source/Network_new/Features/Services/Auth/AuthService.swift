//
//  AuthService.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation

final class AuthService: AuthServiceProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func login(username: String, password: String) async throws -> AuthResponse {
        return try await networkService.request(AuthAPI.login(LoginRequest(username: username, password: password)))
    }

    func register(username: String, password: String) async throws -> AuthResponse {
        return try await networkService.request(AuthAPI.register(RegisterRequest(username: username, password: password)))
    }
}
