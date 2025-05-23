//
//  blindIdCaseApp.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//

// MovieAppApp.swift

import SwiftUI

@main
struct blindIdCaseApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authViewModel.isAuthenticated || TokenManager.shared.token != nil {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(authViewModel)
        }
    }
}

