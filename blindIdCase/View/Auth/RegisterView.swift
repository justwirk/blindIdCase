//
//  RegisterView.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//


// View/Auth/RegisterView.swift

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Kayıt Ol").font(.largeTitle).bold()
            
            // Kullanıcı adı soyadı email şifre alanları
            TextField("Ad", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
            TextField("Soyad", text: $viewModel.surname)
                .textFieldStyle(.roundedBorder)
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
            SecureField("Şifre", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            
            // Hata varsa göster
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            // Kayıt butonu
            Button("Kayıt Ol") {
                viewModel.register()
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
