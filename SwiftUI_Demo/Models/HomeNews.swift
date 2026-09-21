//
//  HomeNews.swift
//  SwiftUI_Demo
//

import Foundation

struct HomeNews: Identifiable {
    let id: String
    let author: String
    let title: String
    let summary: String
    let source: String
    let imageURL: URL?
    let category: String
    let language: String
    let country: String
    let publishedAt: String
    let url: String

    init(dictionary: [String: Any]) {
        let url = dictionary["url"] as? String ?? ""
        self.id = url.isEmpty ? UUID().uuidString : url
        self.author = dictionary["author"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? "Untitled"
        self.summary = dictionary["description"] as? String ?? ""
        self.source = dictionary["source"] as? String ?? "Unknown source"
        self.imageURL = URL(string: dictionary["image"] as? String ?? "")
        self.category = dictionary["category"] as? String ?? "general"
        self.language = dictionary["language"] as? String ?? ""
        self.country = dictionary["country"] as? String ?? ""
        self.publishedAt = dictionary["published_at"] as? String ?? ""
        self.url = url
    }
}
