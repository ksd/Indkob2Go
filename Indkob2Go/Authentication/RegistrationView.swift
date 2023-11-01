//
//  RegistrationView.swift
//  Indkob2Go
//
//  Created by ksd on 31/10/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFill()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 120)
                .padding(.vertical, 32)
            
            VStack {
                InputView(text: $email,
                          title: "Email Adresse",
                          placeholder: "name@example.com")
                .textInputAutocapitalization(.never)
                
                InputView(text: $fullname,
                          title: "Fulde navn",
                          placeholder: "Skriv dit navn")
                
                InputView(text: $password,
                          title: "Kodeord",
                          placeholder: "Skriv dit kodeord",
                          isSecureField: true)
                
                InputView(text: $confirmPassword,
                          title: "Bekræft kodeord",
                          placeholder: "Bekræft dit kodeord",
                          isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // sign up button
            Button {
                print("Sign user up ...")
            } label: {
                HStack {
                    Text("Opret mig")
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
            
            // login button
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Har du allerede en konto?")
                    Text("Login")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
            
        }
    }
}

#Preview {
    RegistrationView()
}
