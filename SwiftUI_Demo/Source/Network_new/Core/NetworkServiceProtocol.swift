//
//  NetworkServiceProtocol.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>( _ request: any NetworkRequest) async throws -> T
}
