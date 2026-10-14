//
//  AuthAPI.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//

import Foundation

enum AuthAPI {
    case login(LoginRequest)
    case register(RegisterRequest)
}

extension AuthAPI: NetworkRequest{
    
    var path: String{
        switch self{
        case .login:
            return "/api/Auth/login"
        case .register:
            return "/api/Auth/register"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        }
    }
    
    var queryParameters: [String : String]? {
         nil
    }
    
    var headers: [String : String]? {
        nil
    }

    var body: (any Encodable)? {
        switch self {
        case .login(let request):
            return request
        case .register(let request):
            return request
        }
    }

    var bodyEncoding: BodyEncoding {
        .json
    }
    

    

}
