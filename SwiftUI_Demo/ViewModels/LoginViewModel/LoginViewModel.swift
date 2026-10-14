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
    
    private let authService: AuthServiceProtocol
    private(set) var authResponse: AuthResponse?
    
    init(authSevice: AuthServiceProtocol) {
        self.authService = authSevice
        
        guard let username = UserDefaults.standard.object(forKey: KEY_Username) as? String else { return }
        _isLoginIn = !username.isEmpty
    }
    
    func loginAction() async {
        print("Click login button: \(self.username) / \(self.password)")
        guard !username.isEmpty && !password.isEmpty else { return }
        
        do {
            authResponse = try await authService.login(
                username: username,
                password: password
            )

            guard let response = authResponse,
                  !response.data.token.isEmpty else {
                message = "Token is empty"
                return
            }
            saveToStorage(response: response)
            isLoginIn = true
            
        }catch{
            message = error.localizedDescription
            print(message)
        }
        
        
    }
    
    func registerAction() async {
        print("Click register button: \(self.username) / \(self.password)")
        guard !username.isEmpty && !password.isEmpty else { return }
        
        do{
            authResponse = try await authService.register(username: username, password: password)
            
        }catch{
            message = error.localizedDescription
        }
        
        
    }
    
    func saveToStorage(response: AuthResponse) {
        UserDefaults.standard.set(response.data.token, forKey: KEY_Token)
        UserDefaults.standard.set(response.data.username, forKey: KEY_Username)

    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: KEY_Username)
        UserDefaults.standard.removeObject(forKey: KEY_Password)
        UserDefaults.standard.removeObject(forKey: KEY_Token)
        isLoginIn = false
        password = ""
        
    }
}
