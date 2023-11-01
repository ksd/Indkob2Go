//
//  LoginView.swift
//  Indkob2Go
//
//  Created by ksd on 30/10/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authController: AuthStateController
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Adresse",
                              placeholder: "name@example.com")
                    .textInputAutocapitalization(.never)
                    
                    InputView(text: $password,
                              title: "Kodeord",
                              placeholder: "Indtast dit kodeord",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // sign in button
                
                Button {
                    Task(priority: .high) {
                        await authController.signIn(emailAdress: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Login")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                // sign up button
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Har du ikke en konto?")
                        Text("Opret ny konto")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
