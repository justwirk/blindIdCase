//
//  Movie.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let posterURL: String
    
    // Eğer JSON’daki key’ler struct’taki isimlerle aynı değilse, CodingKeys tanımlanır
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case posterURL = "poster_url"
    }
}
