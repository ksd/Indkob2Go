//
//  RegistrationView.swift
//  Indkob2Go
//
//  Created by ksd on 31/10/2023.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var authController: AuthStateController
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
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Bekræft kodeord",
                              placeholder: "Bekræft dit kodeord",
                              isSecureField: true)
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemRed))
                        }
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // sign up button
            Button {
                Task {
                    try await authController.createUser(withEmail:email,
                                                        password:password,
                                                        fullname: fullname)
                }
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

extension RegistrationView: AuthenticationProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

#Preview {
    RegistrationView().environmentObject(AuthStateController())
}
