//
//  MLoginReq.swift
//  Class
//
//  Created by 马腾 on 2023/10/28.
//

import UIKit

class MLoginReq: MBaseReq {
    
    var username: String?
    var password: String?
    
    override func url() -> String? {
        return baseURL + loginURL
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
        
        var result = super.initWithJSONDictionary(dic: dic)
        
        let itemDic = dic["item"] as? Dictionary<String, Any>
        let token = dic["token"] as? String
        
        UserDefaults.standard.setValue(token, forKey: KEY_Token)
        UserDefaults.standard.synchronize()
        
        result.item = itemDic
        
        return result
    }
}
