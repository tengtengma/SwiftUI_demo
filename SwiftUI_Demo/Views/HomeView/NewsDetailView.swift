//
//  NewsDetailView.swift
//  SwiftUI_Demo
//

import SwiftUI
import WebKit

struct NewsDetailView: View {
    let news: HomeNews

    var body: some View {
        Group {
            if let url = URL(string: news.url), !news.url.isEmpty {
                NewsWebView(url: url)
            } else {
                ContentUnavailableView(
                    "Invalid news link",
                    systemImage: "exclamationmark.triangle",
                    description: Text("This news item does not contain a valid URL.")
                )
            }
        }
        .navigationTitle(news.source)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewsWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard webView.url != url else { return }
        webView.load(URLRequest(url: url))
    }
}
