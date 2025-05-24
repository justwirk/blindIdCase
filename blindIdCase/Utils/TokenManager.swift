//
//  TokenManager.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//



import Foundation

final class TokenManager {
    static let shared = TokenManager()
    
    private let key = "user_token"
    
    private init() {}

    /// Kullanıcının token'ını UserDefaults'a kaydeder
    func save(token: String) {
        UserDefaults.standard.set(token, forKey: key)
    }
    
    /// Kayıtlı token'ı getirir
    var token: String? {
        UserDefaults.standard.string(forKey: key)
    }
    
    /// Token'ı siler (çıkış işlemi için)
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
