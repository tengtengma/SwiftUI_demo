//
//  HomeViewModel.swift
//  SwiftUI_Demo
//

import Foundation
import Observation

@Observable
class HomeViewModel {
    var news: [HomeNews] = []
    var isLoading = false
    var errorMessage: String?
    
    private let newsService: NewsServiceProtocol
    private(set) var newsResponse: NewsResponse?
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    

    func loadNews() async{
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil
        
        defer{
            isLoading = false
        }
        
        do{
            newsResponse = try await newsService.getNews()
            guard let response = newsResponse
            else {
                print("error")
                return
            }
            news = response.data.articles.map { article in
                HomeNews(article: article)
            }
        }catch{
            print("error")
        }
    }
}
