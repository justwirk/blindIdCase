//
//  MovieViewModel.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.


import Foundation

class MovieViewModel: ObservableObject {
    // Yayınlanan değişkenler
    @Published var movies: [Movie] = []
    @Published var likedMovieIDs: [Int] = []
    @Published var errorMessage: String?

    // Film listesini APIService üzerinden çek
    func fetchMovies() {
        APIService.shared.getAllMovies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    print("🎬 Film sayısı: \(list.count)")
                    self.movies = list
                case .failure(let error):
                    self.errorMessage = "Film listesi alınamadı: \(error.localizedDescription)"
                    print("❌ Hata:", error)
                }
            }
        }
    }

    // Beğenilen film ID'lerini çek
    func fetchLikedMovieIDs() {
        APIService.shared.getLikedMovieIDs { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ids):
                    self.likedMovieIDs = ids
                case .failure:
                    break // hata gösterilmeyebilir
                }
            }
        }
    }

    // Film beğenme
    func likeMovie(id: Int) {
        APIService.shared.likeMovie(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    if !self.likedMovieIDs.contains(id) {
                        self.likedMovieIDs.append(id)
                    }
                case .failure(let error):
                    print("❤️ Beğenme hatası:", error)
                }
            }
        }
    }

    // Beğenmekten vazgeçme
    func unlikeMovie(id: Int) {
        APIService.shared.unlikeMovie(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.likedMovieIDs.removeAll { $0 == id }
                case .failure(let error):
                    print("💔 Beğenme kaldırma hatası:", error)
                }
            }
        }
    }
}

// Boş response dönen endpointler için dummy struct
struct EmptyResponse: Decodable {}
