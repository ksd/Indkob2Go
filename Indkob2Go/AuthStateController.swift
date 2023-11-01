//
//  AuthStateController.swift
//  Indkob2Go
//
//  Created by ksd on 30/10/2023.
//

import Foundation
import FirebaseAuth

final class AuthStateController: ObservableObject {
    
    @Published var user: User?
    
    @MainActor
    func signIn(emailAdress: String, password: String) async {
        do {
            let authDataResult = try await Auth.auth()
                .signIn(withEmail: emailAdress,
                        password: password)
            self.user = authDataResult.user
            print(String(describing: user?.uid))
        } catch {
            print("UPS!")
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out")
        }
    }
    
    @MainActor
    func signUp(emailAdress: String, password: String) async {
        do {
            let authDataResult = try await Auth.auth()
                .createUser(withEmail: emailAdress,
                            password: password)
            self.user = authDataResult.user
        } catch {
            print("Double UPS!")
        }
    }
}
