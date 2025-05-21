//
//  TokenManager.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//



import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    private let key = "authToken"
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: key)
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
