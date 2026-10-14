
import Foundation

struct NewsRequest: Encodable {
}

struct NewsResponse: Decodable {
    let statusCode: Int
    let message: String
    let data: NewsData
    let timestamp: String
}

struct NewsData: Decodable {
    let total: Int
    let articles: [NewsArticle]
}

struct NewsArticle: Decodable, Identifiable {
    let id: Int
    let author: String?
    let title: String
    let description: String
    let url: String
    let source: String
    let image: String?
    let category: String
    let language: String
    let country: String
    let publishedAt: String
}
