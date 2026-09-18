//
//  HomeView.swift
//  SwiftUI_Demo
//
//  Created by 马腾 on 2026/9/18.
//

import SwiftUI

struct HomeView: View {
    @Bindable var viewModel: LoginViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button(action: viewModel.logout) {
            Text("sign out")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(10).padding(20)
        }
    }
}

