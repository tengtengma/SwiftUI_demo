//
//  NewsServiceProtocol.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation

protocol NewsServiceProtocol {
    func getNews() async throws -> NewsResponse
}
