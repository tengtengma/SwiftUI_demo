//
//  NetManager.swift
//  Class
//
//  Created by 马腾 on 2023/10/27.
//

import UIKit
import Alamofire

class NetManager: NSObject {
    
    static let shareInstance = NetManager()  // 使用静态属性来保存唯一实例
    
    lazy var manager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    
    func sendRequest(req: MBaseReq,
                     success: @escaping(MBaseReq) -> Void,
                     failed: @escaping(String, NSError) -> Void) {
        
        self.manager.sessionConfiguration.timeoutIntervalForRequest = req.timeout
        
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
//        if let token = token {
//            headers["Authorization"] = "Bearer \(token)"
//        }
//
        print("Request_Url: \(req.url() ?? "URL: null") \n" + "Request_Body:\(String(describing: req.getRequestParametersDictionary()))")
        
        var reqType: HTTPMethod?
        
        if req.methodType == .GET {
            reqType = .get
                                                       
        } else if req.methodType == .POST {
            reqType = .post
            
        } else if req.methodType == .PUT {
            reqType = .put
            
        } else if req.methodType == .DELETE {
            reqType = .delete
        }
        
        let urlConvertible = URL(string: req.url()!)
        self.manager.request(urlConvertible!,
                             method: reqType!,
                             parameters: req.getRequestParametersDictionary(),
                             encoding: reqType == .get ? URLEncoding.default : JSONEncoding.default,
                             headers: headers).response(completionHandler: { (response) in
            
            
                                if (response.data == nil){
                                    print("请求失败")
                                    let error = NSError.init(domain: "Cannot connect the server", code: -1)
                                    failed(req.url()!, error)
                                    return
                                }else{
                                    
                                    let json:AnyObject! = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as AnyObject
                                    if(json != nil){
                                        
                                        print("Response_Url: \(req.url()!) \n" + "Response_body:\(String(describing: json!))")

                                          
                                        let result = req.initWithJSONDictionary(dic: json as! Dictionary<String, Any>)
                                        
                                        if (req.responseCode.rawValue == result.errorCode){
                                            print("success")

                                            req.result = result
                                            success(req)

                                        }else{
                                            print("failed")
                                            let error = NSError.init(domain: result.message ?? "failed", code: -1)
                                            failed(req.url()!, error)

                                        }
                                    }else{
                                        let error = NSError.init(domain: "Cannot connect the server", code: -1)
                                        failed(req.url()!, error)

                                    }
                                }
                                
                             })
    }
    

}


