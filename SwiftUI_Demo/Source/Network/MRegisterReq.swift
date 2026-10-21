//
//  MRegisterReq.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/9/28.
//

import UIKit

class MRegisterReq: MBaseReq {
    
    var username: String?
    var password: String?
    
    override func url() -> String? {
        return baseURL + registerURL
    }
    
    override func getRequestParametersDictionary() -> Dictionary<String, Any> {
        
        var dic = super.getRequestParametersDictionary()
        
        if (self.username?.count != 0){
            dic.updateValue(self.username!, forKey: "username")
        }
        if(self.password?.count != 0){
            dic.updateValue(self.password!, forKey: "password")
        }

        return dic
    }

    override func initWithJSONDictionary(dic: Dictionary<String, Any>) -> MBaseReq.response {
                
        return super.initWithJSONDictionary(dic: dic)
    }
}
