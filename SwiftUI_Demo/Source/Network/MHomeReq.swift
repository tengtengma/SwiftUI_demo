//
//  MHomeReq.swift
//  Class
//
//  Created by 马腾 on 2023/10/28.
//

import UIKit

class MHomeReq: MBaseReq {
    
    override func url() -> String? {
        return getNewsURL + APIKEY_Mediastack
    }
    
    override func getRequestParametersDictionary() -> Dictionary<String, Any> {
        
        let dic = super.getRequestParametersDictionary()
        
        return dic
    }

    /// mediastack 成功时返回的新闻列表位于 `data`，并不包含项目通用的 `code` 字段。
    override func initWithJSONDictionary(dic: Dictionary<String, Any>) -> response {
        if let data = dic["data"] as? [[String: Any]] {
            return response(itemList: data, message: nil, errorCode: responseCode.rawValue)
        }

        let error = dic["error"] as? [String: Any]
        let message = error?["message"] as? String ?? "Unable to load news."
        return response(message: message, errorCode: -1)
    }

}
