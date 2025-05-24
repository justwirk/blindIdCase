//
//  LoginView.swift
//  blindIdCase
//
//  Created by Emre Yılmaz on 21.05.2025.
//

// View/Auth/LoginView.swift

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Giriş Yap").font(.largeTitle).bold()
            
            TextField("Email", text: $authViewModel.email)
                .textFieldStyle(.roundedBorder)
            SecureField("Şifre", text: $authViewModel.password)
                .textFieldStyle(.roundedBorder)
            
            if let error = authViewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            Button("Giriş Yap") {
                authViewModel.login()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            NavigationLink("Hesabın yok mu? Kayıt ol", destination: RegisterView())
        }
        .padding()
    }
}

#Preview {
    LoginView().environmentObject(AuthViewModel())
}
