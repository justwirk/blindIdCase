// View/Movie/MovieListView.swift

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.headline)
                        Text(movie.description)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    // Kalp butonu ile beğen/beğenme
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
            .navigationTitle("Filmler")
            .onAppear {
                viewModel.fetchMovies()
                viewModel.fetchLikedMovieIDs()
            }
        }
    }
}
