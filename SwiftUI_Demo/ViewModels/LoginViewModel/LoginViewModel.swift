//
//  LoginViewModel.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/9/17.
//


import Foundation
import Observation

@Observable
class LoginViewModel {
    var username = ""
    var password = ""
    var isLoginIn = false
    var showSuccessAlert = false
    var message = ""
    
    init(username: String = "", password: String = "", isLoginIn: Bool = false, showSuccessAlert: Bool = false, message: String = "") {
        self.username = username
        self.password = password
        self.isLoginIn = (UserDefaults.standard.object(forKey: KEY_Username) != nil) ? true : false
        self.showSuccessAlert = showSuccessAlert
        self.message = message
    }
    
    func loginAction() {
        print("Click login button: \(self.username) / \(self.password)")
        guard !username.isEmpty && !password.isEmpty else { return }
        
        let loginReq = MLoginReq()
        loginReq.username = self.username
        loginReq.password = self.password
        loginReq.methodType = .POST
        NetManager.shareInstance.sendRequest(req: loginReq) { [unowned self] response in

            guard let result = loginReq.result,
                  let data = result.item,
                  let token = data["token"] as? String else {
                self.message = "failed"
                self.showSuccessAlert = true
                return
            }

            UserDefaults.standard.set(self.username, forKey: KEY_Username)
            UserDefaults.standard.set(self.password, forKey: KEY_Password)
            UserDefaults.standard.set(token, forKey: KEY_Token)

            self.message = result.message ?? ""
            self.isLoginIn = true
            
        } failed: { String, NSError in
            self.message = String
            self.isLoginIn = false
        }
    }
    
    func registerAction() {
        print("Click register button: \(self.username) / \(self.password)")
        guard !username.isEmpty && !password.isEmpty else { return }
        
        let registerReq = MRegisterReq()
        registerReq.username = self.username
        registerReq.password = self.password
        registerReq.methodType = .POST
        NetManager.shareInstance.sendRequest(req: registerReq) { [unowned self] response in
            guard let result = registerReq.result,
                  let data = result.item else{
                self.message = "failed"
                self.showSuccessAlert = true
                return
            }
            self.message = result.message ?? ""
            self.showSuccessAlert = true
            
        } failed: { String, NSError in
            self.message = String
            self.showSuccessAlert = true
            
        }
        
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: KEY_Username)
        UserDefaults.standard.removeObject(forKey: KEY_Password)
        UserDefaults.standard.removeObject(forKey: KEY_Token)
        isLoginIn = false
        password = ""
        
    }
}
