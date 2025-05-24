//
//  blindIdCaseApp.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//

import SwiftUI

@main
struct blindIdCaseApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authViewModel.isAuthenticated {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
            .onAppear {
                // Eğer token zaten varsa, kullanıcıyı otomatik giriş yapmış say
                if TokenManager.shared.token != nil {
                    authViewModel.isAuthenticated = true
                }
            }
            .environmentObject(authViewModel)
        }
    }
}


