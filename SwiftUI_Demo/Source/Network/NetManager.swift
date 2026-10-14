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
        return Alamofire.Session(configuration: configuration)
    }()
    
    func sendRequest(req: MBaseReq,
                     success: @escaping (MBaseReq) -> Void,
                     failed: @escaping (String, NSError) -> Void) {
        
        // 1. 安全获取 URL 字符串，防止崩溃
        guard let urlString = req.url(), let url = URL(string: urlString) else {
            let error = NSError(domain: "Invalid URL", code: -1)
            failed("", error)
            return
        }
        
        self.manager.sessionConfiguration.timeoutIntervalForRequest = req.timeout
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        // 如果后续需要 Token，可以直接在这里解开注释并赋值
        
        print("Request_Url: \(urlString) \nRequest_Body: \(String(describing: req.getRequestParametersDictionary()))")
        
        // 2. 用 switch 优雅转换 HTTPMethod，替代冗长的 if-else
        let httpMethod: Alamofire.HTTPMethod = {
            switch req.methodType {
            case .GET:
                return .get
            case .POST:
                return .post
            case .PUT:
                return .put
            case .DELETE:
                return .delete
            @unknown default:
                return .get
            }
        }()
        
        // 3. 确定编码格式
        let encoding: ParameterEncoding = (httpMethod == .get) ? URLEncoding.default : JSONEncoding.default
        
        // 4. 发起请求
        self.manager.request(url,
                             method: httpMethod,
                             parameters: req.getRequestParametersDictionary(),
                             encoding: encoding,
                             headers: headers)
        .response { [weak self] response in
            guard let self = self else { return }
            
            // 5. 统一错误处理：检查 data 是否为空
            guard let data = response.data else {
                print("请求失败：无数据返回")
                let error = NSError(domain: "Cannot connect the server", code: -1)
                failed(urlString, error)
                return
            }
            
            // 6. JSON 解析
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    let error = NSError(domain: "Invalid JSON format", code: -1)
                    failed(urlString, error)
                    return
                }
                
                print("Response_Url: \(urlString) \nResponse_body: \(json)")
                
                // 7. 业务逻辑处理
                let result = req.initWithJSONDictionary(dic: json)
                
                if req.responseCode.rawValue == result.errorCode {
                    print("success")
                    req.result = result
                    success(req)
                } else {
                    print("failed")
                    let errorMessage = result.message ?? "failed"
                    let error = NSError(domain: errorMessage, code: -1)
                    failed(urlString, error)
                }
                
            } catch {
                let parseError = NSError(domain: "JSON Parse Error: \(error.localizedDescription)", code: -1)
                failed(urlString, parseError)
            }
        }
    }
}
