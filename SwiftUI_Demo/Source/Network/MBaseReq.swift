//
//  MBaseReq.swift
//  Class
//
//  Created by 马腾 on 2023/10/27.
//

import UIKit

class MBaseReq: NSObject {
    var responseCode: response_code = .success //设置成功代码 默认0
    var methodType: request_type = .GET // 设置默认请求类型为 GET
    var timeout: TimeInterval = 45  //默认为45秒
    var result: response?
    
    enum request_type: Int {
        case GET = 0
        case POST = 1
        case PUT = 2
        case DELETE = 3
    }
    
    
    enum response_code: Int {
        case success = 0
        case failed = -1
    }
    
    struct response {
        var item: Dictionary<String, Any>?
        var itemList: Array<Any>?
        var message: String?
        var errorCode: Int?
    }
    
    
    func url() -> String? {
        return nil
    }

    func getRequestParametersDictionary() -> Dictionary<String, Any> {
                
        return Dictionary<String, Any>()
    }
    
    
    func initWithJSONDictionary(dic: Dictionary<String, Any>) -> response{
        return response(item: dic["data"] as? Dictionary<String, Any> , message: dic["message"] as? String ,errorCode: dic["statusCode"] as? Int)
    }
    

}
