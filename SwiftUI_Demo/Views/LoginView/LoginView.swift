//
//  LoginView.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/9/17.
//

import SwiftUI

struct LoginView: View {
    // 1. Keep the ViewModel instance
    @Bindable var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Welcome")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 20)
            
            // 2. username textfield
            CustomTextFieldView(
                iconName: "person.fill",
                title: "username",
                placeholder: "please input your username...",
                text: $viewModel.username
            )
            
            // 3. password textfield
            CustomTextFieldView(
                iconName: "lock.fill",
                title: "password",
                placeholder: "please input your password...",
                isSecure: true,
                text: $viewModel.password
            )
            
            // Login button
            Button(action: {
                viewModel.loginAction()
            }) {
                Text("login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(24)
    }
}

// MARK: - Define custom view
struct CustomTextFieldView: View {
    let iconName: String
    let title: String
    let placeholder: String
    var isSecure: Bool = false
    
    // Key point: Receive the bound text passed in from an external source (ViewModel) via `@Binding`.
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack(spacing: 6) {
                Image(systemName: iconName)
                    .imageScale(.medium)
                    .foregroundColor(.blue)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Input area (distinguishing between plaintext and ciphertext)
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}
