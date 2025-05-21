//
//  AuthViewModel.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//

// ViewModel/AuthViewModel.swift

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    // Ekranların erişebileceği @Published değişkenler
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var surname = ""
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    // Kayıt olma işlemi
    func register() {
        guard let url = URL(string: "\(Constants.baseURL)/auth/register") else { return }
        
        // API'ye gönderilecek JSON veri yapısı
        let body: [String: Any] = [
            "name": name,
            "surname": surname,
            "email": email,
            "password": password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            // NetworkManager ile POST isteği
            NetworkManager.shared.request(
                endpoint: "/auth/register",
                method: "POST",
                body: jsonData,
                requiresAuth: false
            ) { (result: Result<AuthResponse, NetworkError>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        TokenManager.shared.token = response.token
                        self.isAuthenticated = true
                    case .failure(let error):
                        self.errorMessage = "Kayıt başarısız: \(error.localizedDescription)"
                    }
                }
            }
            
        } catch {
            self.errorMessage = "JSON formatı hatalı"
        }
    }
    
    // Giriş yapma işlemi
    func login() {
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            NetworkManager.shared.request(
                endpoint: "/auth/login",
                method: "POST",
                body: jsonData,
                requiresAuth: false
            ) { (result: Result<AuthResponse, NetworkError>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        TokenManager.shared.token = response.token
                        self.isAuthenticated = true
                    case .failure(let error):
                        self.errorMessage = "Giriş başarısız: \(error.localizedDescription)"
                    }
                }
            }
        } catch {
            self.errorMessage = "JSON formatı hatalı"
        }
    }
}
