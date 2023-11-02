//
//  AuthStateController.swift
//  Indkob2Go
//
//  Created by ksd on 30/10/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol AuthenticationProtocol {
    var formIsValid: Bool { get }
}

@MainActor
final class AuthStateController: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        Task { @MainActor in
            self.userSession = Auth.auth().currentUser
            await fetchUser()
        }
    }
    
    
    func signIn(emailAdress: String, password: String) async {
        do {
            let authDataResult = try await Auth.auth()
                .signIn(withEmail: emailAdress,
                        password: password)
            self.userSession = authDataResult.user
            await fetchUser()
        } catch {
            print("UPS!")
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Error signing out")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func createUser(withEmail emailAdress: String, password: String, fullname: String) async throws {
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: emailAdress,
                            password: password)
            self.userSession = authDataResult.user
            let user = User(id: authDataResult.user.uid, fullname: fullname, email: emailAdress)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            // det er bare en test - kan fjernes, hvis du er tilfreds
            await fetchUser()
        } catch {
            print("DEBUG: failed to create user with error \(error.localizedDescription)")
        }
    }
    
    
    func fetchUser() async {
        guard let uid = self.userSession?.uid else { return }
        guard let snapshot = try? await Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
