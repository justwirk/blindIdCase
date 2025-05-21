//
//  AuthResponse.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//



import Foundation

// API'den başarılı giriş/kayıt sonrası gelen token yapısı
struct AuthResponse: Decodable {
    let token: String
}
