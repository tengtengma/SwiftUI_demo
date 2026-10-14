//
//  NetworkError.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(underlying: Error)
    case transportError(underlying: Error)
    case encodingError(underlying: Error)
    case unknown(underlying: Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request URL."
        case .invalidResponse:
            return "Invalid server response."
        case .httpError(let statusCode):
            return "HTTP error: \(statusCode)."
        case .decodingError:
            return "Failed to decode response."
        case .transportError:
            return "Network connection failed."
        case .encodingError:
            return "Failed to encode request."
        case .unknown:
            return "Unknown network error."
        }
    }
}
