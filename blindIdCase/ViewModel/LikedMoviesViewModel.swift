//
//  LikedMoviesViewModel.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 22.05.2025.
//


// ViewModel/LikedMoviesViewModel.swift

import Foundation

class LikedMoviesViewModel: ObservableObject {
    @Published var likedMovies: [Movie] = []
    @Published var errorMessage: String?
    
    // Beğenilen filmleri API'den çeker
    func fetchLikedMovies() {
        NetworkManager.shared.request(
            endpoint: "/users/liked-movies",
            requiresAuth: true
        ) { (result: Result<[Movie], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.likedMovies = movies
                case .failure(let error):
                    self.errorMessage = "Beğenilen filmler alınamadı: \(error.localizedDescription)"
                }
            }
        }
    }
}
