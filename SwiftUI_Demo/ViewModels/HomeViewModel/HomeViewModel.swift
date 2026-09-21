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

    func loadNews() {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        let request = MHomeReq()
        NetManager.shareInstance.sendRequest(req: request) { [weak self] request in
            let items = (request.result?.itemList ?? []).compactMap { item -> HomeNews? in
                guard let dictionary = item as? [String: Any] else { return nil }
                return HomeNews(dictionary: dictionary)
            }

            DispatchQueue.main.async {
                self?.news = items
                self?.isLoading = false
            }
        } failed: { [weak self] _, error in
            DispatchQueue.main.async {
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            }
        }
    }
}
