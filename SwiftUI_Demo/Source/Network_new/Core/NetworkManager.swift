//
//  NetworkManager.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//


import Foundation
import Alamofire

final class NetworkManager: NetworkServiceProtocol {

    private let session: Session
    private let configuration: NetworkConfiguration

    init(session: Session, configuration: NetworkConfiguration) {
        self.session = session
        self.configuration = configuration
    }

    func request<T: Decodable>( _ request: any NetworkRequest) async throws -> T {
        do {
            let urlRequest = try makeURLRequest(request)

            let data = try await session
                .request(urlRequest)
                .validate()
                .serializingData()
                .value

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Decoding target type:", T.self)
                    print("Decoding error:", error)
                    print("Response JSON:", String(data: data, encoding: .utf8) ?? "")
                throw NetworkError.decodingError(underlying: error)
            }
        } catch let error as NetworkError {
            throw error
        } catch let error as AFError {
            if let statusCode = error.responseCode {
                throw NetworkError.httpError(statusCode: statusCode)
            }

            throw NetworkError.transportError(underlying: error)
        } catch {
            throw NetworkError.unknown(underlying: error)
        }
    }

    private func makeURLRequest(
        _ request: any NetworkRequest
    ) throws -> URLRequest {
        let url = configuration.baseURL.appending(
            path: request.path
        )

        guard var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        ) else {
            throw NetworkError.invalidURL
        }

        // 合并 URL 查询参数
        if let parameters = request.queryParameters {
            let queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }

            components.queryItems = (components.queryItems ?? [])
                + queryItems
        }

        guard let finalURL = components.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.timeoutInterval = configuration.requestTimeout

        // 设置请求头
        request.headers?.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        // 编码请求体
        if let body = request.body {
            do {
                switch request.bodyEncoding {
                case .json:
                    urlRequest.httpBody = try JSONEncoder().encode(body)
                    urlRequest.setValue(
                        "application/json",
                        forHTTPHeaderField: "Content-Type"
                    )

                case .urlEncoded:
                    let data = try JSONEncoder().encode(body)
                    let object = try JSONSerialization.jsonObject(with: data)

                    guard let dictionary = object as? [String: Any] else {
                        throw NetworkError.encodingError(
                            underlying: NSError(
                                domain: "NetworkManager",
                                code: 1,
                                userInfo: [
                                    NSLocalizedDescriptionKey:
                                        "URL-encoded body must be a JSON object."
                                ]
                            )
                        )
                    }

                    var formComponents = URLComponents()
                    formComponents.queryItems = dictionary.map {
                        URLQueryItem(name: $0.key, value: String(describing: $0.value))
                    }

                    urlRequest.httpBody = formComponents.percentEncodedQuery?
                        .data(using: .utf8)

                    urlRequest.setValue(
                        "application/x-www-form-urlencoded",
                        forHTTPHeaderField: "Content-Type"
                    )

                case .none:
                    break
                }
            } catch let error as NetworkError {
                throw error
            } catch {
                throw NetworkError.encodingError(underlying: error)
            }
        }

        return urlRequest
    }
}
