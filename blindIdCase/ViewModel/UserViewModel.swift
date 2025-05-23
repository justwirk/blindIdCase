//
//  UserViewModel.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//



import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var updateSuccess = false
    
    // Mevcut kullanıcı bilgilerini çek
    func fetchCurrentUser() {
        NetworkManager.shared.request(
            endpoint: "/auth/me",
            requiresAuth: true
        ) { (result: Result<User, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let currentUser):
                    self.user = currentUser
                case .failure(let error):
                    self.errorMessage = "Kullanıcı bilgileri alınamadı: \(error.localizedDescription)"
                }
            }
        }
    }
    
    // Kullanıcı bilgilerini güncelle
    func updateUser(withPassword password: String) {
        guard var user = user else { return }
        
        let body: [String: Any] = [
            "name": user.name,
            "surname": user.surname,
            "email": user.email,
            "password": password.isEmpty ? "123456" : password // boşsa default ver
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            
            NetworkManager.shared.request(
                endpoint: "/users/profile",
                method: "PUT",
                body: jsonData,
                requiresAuth: true
            ) { (result: Result<User, NetworkError>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let updatedUser):
                        self.user = updatedUser
                        self.updateSuccess = true
                    case .failure(let error):
                        self.errorMessage = "Güncelleme başarısız: \(error.localizedDescription)"
                    }
                }
            }
        } catch {
            self.errorMessage = "Veri formatı hatalı"
        }
    }
}

