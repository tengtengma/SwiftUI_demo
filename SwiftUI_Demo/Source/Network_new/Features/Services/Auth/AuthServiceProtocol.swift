//
//  AuthServiceProtocol.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation

protocol AuthServiceProtocol {
    func login(username: String, password: String) async throws -> AuthResponse

    func register(username: String, password: String) async throws -> AuthResponse
}
