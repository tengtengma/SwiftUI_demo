//
//  MHomeReq.swift
//  Class
//
//  Created by 马腾 on 2023/10/28.
//

import UIKit

class MHomeReq: MBaseReq {
    
    override func url() -> String? {
        return baseURL + loginURL
    }
    
    override func getRequestParametersDictionary() -> Dictionary<String, Any> {
        
        let dic = super.getRequestParametersDictionary()
        
        return dic
    }

}
