//
//  NetworkRequest.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum BodyEncoding {
    case json
    case urlEncoded
    case none
}

protocol NetworkRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: String]? { get }
    var body: (any Encodable)? { get }
    var headers: [String: String]? { get }
    var bodyEncoding: BodyEncoding { get }
}
