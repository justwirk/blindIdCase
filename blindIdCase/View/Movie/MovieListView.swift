//
//  MovieListView.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 22.05.2025.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.movies.isEmpty {
                    if let error = viewModel.errorMessage {
                        Text("Hata: \(error)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ProgressView("Yükleniyor...")
                            .padding()
                    }
                } else {
                    List(viewModel.movies) { movie in
                        HStack(alignment: .top) {
                            // AsyncImage ile görseli yükle
                            AsyncImage(url: URL(string: movie.posterURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                // Yüklenene kadar geçici görüntü
                                ProgressView()
                            }
                            .frame(width: 80, height: 120)
                            .cornerRadius(8)

                            VStack(alignment: .leading, spacing: 8) {
                                Text(movie.title)
                                    .font(.headline)
                                Text(movie.description)
                                    .font(.subheadline)
                                    .lineLimit(3)
                            }

                            Spacer()

                            // Kalp ikonu
                            Button(action: {
                                if viewModel.likedMovieIDs.contains(movie.id) {
                                    viewModel.unlikeMovie(id: movie.id)
                                } else {
                                    viewModel.likeMovie(id: movie.id)
                                }
                            }) {
                                Image(systemName: viewModel.likedMovieIDs.contains(movie.id) ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Filmler")
            .onAppear {
                viewModel.fetchMovies()
                viewModel.fetchLikedMovieIDs()
            }
        }
    }
}

