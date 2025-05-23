//
//  ProfileView.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 22.05.2025.
//


// View/Profile/ProfileView.swift

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = UserViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 16) {
            if let user = viewModel.user {
                TextField("Ad", text: Binding(
                    get: { user.name },
                    set: { viewModel.user?.name = $0 }
                ))
                .textFieldStyle(.roundedBorder)

                TextField("Soyad", text: Binding(
                    get: { user.surname },
                    set: { viewModel.user?.surname = $0 }
                ))
                .textFieldStyle(.roundedBorder)

                TextField("Email", text: Binding(
                    get: { user.email },
                    set: { viewModel.user?.email = $0 }
                ))
                .textFieldStyle(.roundedBorder)
                
                SecureField("Yeni Şifre", text: $password)
                    .textFieldStyle(.roundedBorder)

                // Güncelleme
                Button("Bilgileri Güncelle") {
                    viewModel.updateUser(withPassword: password)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)

                if viewModel.updateSuccess {
                    Text("Bilgiler güncellendi ✅").foregroundColor(.green)
                }

                // Çıkış
                Button("Çıkış Yap") {
                    TokenManager.shared.clear()
                    authViewModel.isAuthenticated = false
                }
                .foregroundColor(.red)
                .padding(.top)
            } else {
                ProgressView("Yükleniyor...")
            }

            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Profilim")
        .onAppear {
            viewModel.fetchCurrentUser()
        }
    }
}

