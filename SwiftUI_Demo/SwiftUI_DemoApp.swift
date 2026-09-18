//
//  SwiftUI_DemoApp.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/9/17.
//

import SwiftUI

@main
struct SwiftUI_DemoApp: App {
    @State var loginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            if loginViewModel.isLoginIn {
                NavigationStack {
                    HomeView(viewModel: loginViewModel)
                }
            } else {
                LoginView(viewModel: loginViewModel)
            }
        }
    }
}
