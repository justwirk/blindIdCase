//
//  Movie.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//

import Foundation

// API'den dönecek film verisini temsil eder
struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let image: String
}
