//
//  User.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//

// Model/User.swift

import Foundation

struct User: Codable {
    let id: Int?
    var name: String
    var surname: String
    var email: String
}
