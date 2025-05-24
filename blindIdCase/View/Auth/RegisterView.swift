//
//  RegisterView.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//


// View/Auth/RegisterView.swift

import SwiftUI

struct RegisterView: View {
   // @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Kayıt Ol").font(.largeTitle).bold()
            
            // Kullanıcı adı soyadı email şifre alanları
            TextField("Ad", text: $authViewModel.name)
                .textFieldStyle(.roundedBorder)
            TextField("Soyad", text: $authViewModel.surname)
                .textFieldStyle(.roundedBorder)
            TextField("Email", text: $authViewModel.email)
                .textFieldStyle(.roundedBorder)
            SecureField("Şifre", text: $authViewModel.password)
                .textFieldStyle(.roundedBorder)
            
            // Hata varsa göster
            if let error = authViewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            // Kayıt butonu
            Button("Kayıt Ol") {
                authViewModel.register()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            // Giriş ekranına yönlendirme
            NavigationLink("Zaten hesabın var mı? Giriş yap", destination: LoginView())
        }
        .padding()
    }
}
