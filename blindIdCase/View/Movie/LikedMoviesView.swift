//
//  LikedMoviesView.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 22.05.2025.
//


// View/Movie/LikedMoviesView.swift

import SwiftUI

struct LikedMoviesView: View {
    @StateObject private var viewModel = LikedMoviesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.likedMovies) { movie in
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.description)
                        .font(.subheadline)
                        .lineLimit(2)
                }
            }
            .navigationTitle("Beğenilen Filmler")
            .onAppear {
                viewModel.fetchLikedMovies()
            }
        }
    }
}
