//
//  BaseResponse.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/10/14.
//


import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let statusCode: Int
    let message: String
    let data: T?
}
