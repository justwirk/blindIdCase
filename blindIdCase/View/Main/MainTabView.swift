//
//  MainTabView.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 22.05.2025.
//


// View/Main/MainTabView.swift

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Label("Filmler", systemImage: "film")
                }
            
            LikedMoviesView()
                .tabItem {
                    Label("Beğenilenler", systemImage: "heart.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
        }
    }
}
