//
//  APIService.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//



import Foundation

class APIService {
    static let shared = APIService()
    private init() {}

    // Film listesini getir
    func getAllMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: "/movies", completion: completion)
    }

    // Beğenilen film ID'leri
    func getLikedMovieIDs(completion: @escaping (Result<[Int], NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: "/users/liked-movie-ids", requiresAuth: true, completion: completion)
    }

    // Film beğen
    func likeMovie(id: Int, completion: @escaping (Result<EmptyResponse, NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: "/movies/like/\(id)", method: "POST", requiresAuth: true, completion: completion)
    }

    // Film beğenmekten vazgeç
    func unlikeMovie(id: Int, completion: @escaping (Result<EmptyResponse, NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: "/movies/unlike/\(id)", method: "POST", requiresAuth: true, completion: completion)
    }

    // Mevcut kullanıcı
    func getCurrentUser(completion: @escaping (Result<User, NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: "/auth/me", requiresAuth: true, completion: completion)
    }

    // Kullanıcı güncelle
    func updateUser(body: Data, completion: @escaping (Result<User, NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: "/users/profile", method: "PUT", body: body, requiresAuth: true, completion: completion)
    }

    // Kayıt ol
    func register(body: Data, completion: @escaping (Result<AuthResponse, NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: "/auth/register", method: "POST", body: body, requiresAuth: false, completion: completion)
    }

    // Giriş yap
    func login(body: Data, completion: @escaping (Result<AuthResponse, NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: "/auth/login", method: "POST", body: body, requiresAuth: false, completion: completion)
    }
    
    func getMovieByID(id: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: "/movies/\(id)", completion: completion)
    }
}
