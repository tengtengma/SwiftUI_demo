//
//  HomeView.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/9/18.
//

import SwiftUI

struct HomeView: View {
    @Bindable var viewModel: LoginViewModel
    @State private var homeViewModel = HomeViewModel()
    
    var body: some View {
        Group {
            if homeViewModel.isLoading && homeViewModel.news.isEmpty {
                ProgressView("Loading news...")
            } else if let errorMessage = homeViewModel.errorMessage,
                      homeViewModel.news.isEmpty {
                ContentUnavailableView {
                    Label("Unable to load news", systemImage: "wifi.exclamationmark")
                } description: {
                    Text(errorMessage)
                } actions: {
                    Button("Try Again", action: homeViewModel.loadNews)
                }
            } else {
                List(homeViewModel.news) { news in
                    NavigationLink {
                        NewsDetailView(news: news)
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            if let imageURL = news.imageURL {
                                AsyncImage(url: imageURL) { image in
                                    image.resizable().scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 88, height: 88)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text(news.title)
                                    .font(.headline)
                                    .lineLimit(3)

                                if !news.summary.isEmpty {
                                    Text(news.summary)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(2)
                                }

                                HStack(spacing: 4) {
                                    Text(news.source)
                                    if !news.author.isEmpty {
                                        Text("· \(news.author)")
                                    }
                                    Spacer()
                                    Text(news.category)
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
                .refreshable {
                    homeViewModel.loadNews()
                }
            }
        }
        .navigationTitle("News")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Sign Out", action: viewModel.logout)
            }
        }
        .onAppear(perform: homeViewModel.loadNews)
    }
}
