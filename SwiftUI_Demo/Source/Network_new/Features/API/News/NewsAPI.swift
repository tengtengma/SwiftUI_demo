//
//  NewsAPI.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation

enum NewsAPI {
    case getNews
}

extension NewsAPI: NetworkRequest{
    
    var path: String{
        return "/api/News"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryParameters: [String : String]? {
         nil
    }
    
    var headers: [String : String]? {
        nil
    }

    var body: (any Encodable)? {
        return nil
    }

    var bodyEncoding: BodyEncoding {
        .json
    }

}
