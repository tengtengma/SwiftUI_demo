//
//  AppContainer.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation
import Alamofire

final class AppContainer {
    let networkService: NetworkServiceProtocol
    let authService: AuthServiceProtocol
    let newsService: NewsServiceProtocol

    init(configuration: NetworkConfiguration) {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = configuration.requestTimeout
        sessionConfiguration.timeoutIntervalForResource = configuration.resourceTimeout
        
        let session = Session(configuration: sessionConfiguration)
        
        let networkService = NetworkManager(
            session: session,
            configuration: configuration
        )
        
        self.networkService = networkService
        
        self.authService = AuthService(networkService: networkService)
        self.newsService = NewsService(networkService: networkService)
    }
}

