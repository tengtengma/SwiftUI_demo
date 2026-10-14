//
//  AuthModels.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct RegisterRequest: Encodable {
    let username: String
    let password: String
}

struct AuthResponse: Decodable {
    let statusCode: Int
    let message: String
    let data: AuthUser
    let timestamp: String
}

struct AuthUser: Decodable, Identifiable {
    let id: Int
    let username: String
    let token: String
}
