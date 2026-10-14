//
//  NewsService.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation


final class NewsService: NewsServiceProtocol
{
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getNews() async throws -> NewsResponse {
        return try await networkService.request(NewsAPI.getNews)
    }
}
