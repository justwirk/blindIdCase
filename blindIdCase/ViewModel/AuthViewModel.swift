//
//  AuthViewModel.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//

// ViewModel/AuthViewModel.swift

import Foundation

class AuthViewModel: ObservableObject {
    // Ekranlarda kullanılan değerler
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var surname = ""
    
    // Giriş durumu ve hata yönetimi
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    // Kayıt olma işlemi
    func register() {
        let body: [String: Any] = [
            "name": name,
            "surname": surname,
            "email": email,
            "password": password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            APIService.shared.register(body: jsonData) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        TokenManager.shared.save(token: response.token)
                        self.isAuthenticated = true
                    case .failure(let error):
                        self.errorMessage = "Kayıt başarısız: \(error.localizedDescription)"
                    }
                }
            }
        } catch {
            self.errorMessage = "JSON oluşturulamadı"
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
            
            APIService.shared.login(body: jsonData) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        TokenManager.shared.save(token: response.token)
                        self.isAuthenticated = true
                    case .failure(let error):
                        self.errorMessage = "Giriş başarısız: \(error.localizedDescription)"
                    }
                }
            }
        } catch {
            self.errorMessage = "JSON oluşturulamadı"
        }
    }
    
    // Çıkış yapma
    func logout() {
        TokenManager.shared.clear()
        self.isAuthenticated = false
    }
}

