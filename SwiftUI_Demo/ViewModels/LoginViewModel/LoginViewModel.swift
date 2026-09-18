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
    
    init(username: String = "", password: String = "", isLoginIn: Bool = false) {
        if let savedUser = UserDefaults.standard.string(forKey: KEY_Username), !savedUser.isEmpty
        {
            self.username = savedUser
            self.password = password
            self.isLoginIn = true
        } else {
            self.isLoginIn = false
        }
    }
    
    
    func loginAction() {
        print("Click login button: \(self.username) / \(self.password)")
        guard !username.isEmpty && !password.isEmpty else { return }
        
        UserDefaults.standard.set(self.username, forKey: KEY_Username)
        UserDefaults.standard.set(self.password, forKey: KEY_Password)
        UserDefaults.standard.synchronize()
        self.isLoginIn = true
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: KEY_Username)
        UserDefaults.standard.removeObject(forKey: KEY_Password)
        isLoginIn = false
        password = ""
        
    }
}
