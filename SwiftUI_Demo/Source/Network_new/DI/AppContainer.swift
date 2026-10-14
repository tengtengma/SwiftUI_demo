//
//  AppContainer.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation
import Alamofire

final class AppContainer {
    // MARK: - Protocol
    let networkService: NetworkServiceProtocol
    
    // MARK: - ViewModels
    let loginViewModel: LoginViewModel
    let homeViewModel: HomeViewModel

    init(configuration: NetworkConfiguration) {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = configuration.requestTimeout
        sessionConfiguration.timeoutIntervalForResource = configuration.resourceTimeout
        
        let session = Session(configuration: sessionConfiguration)
        let networkService = NetworkManager(session: session, configuration: configuration)
        self.networkService = networkService
        
        self.loginViewModel = LoginViewModel(authServrice: AuthService(networkService: networkService))
        self.homeViewModel = HomeViewModel(newsService: NewsService(networkService: networkService))
    }
}

