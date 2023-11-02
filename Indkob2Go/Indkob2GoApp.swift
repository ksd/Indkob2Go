//
//  Indkob2GoApp.swift
//  Indkob2Go
//
//  Created by ksd on 30/10/2023.
//

import SwiftUI
import FirebaseCore

@main
struct Indkob2GoApp: App {
    private let authStateController: AuthStateController
    
    init(){
        FirebaseApp.configure()
        authStateController = AuthStateController()
    }
    var body: some Scene {
        WindowGroup {
            FrontpageView().environmentObject(authStateController)
        }
    }
}
