//
//  LoginView.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//

// View/Auth/LoginView.swift

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Giriş Yap").font(.largeTitle).bold()
            
            // Email ve şifre girişi
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
            SecureField("Şifre", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            
            // Hata mesajı varsa göster
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            // Giriş butonu
            Button("Giriş Yap") {
                viewModel.login()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            // Kayıt ekranına yönlendirme
            NavigationLink("Hesabın yok mu? Kayıt ol", destination: RegisterView())
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
