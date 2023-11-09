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
    private let shoppingListController: ShoppingListsController
    
    init(){
        FirebaseApp.configure()
        authStateController = AuthStateController()
        shoppingListController = ShoppingListsController()
    }
    var body: some Scene {
        WindowGroup {
            FrontpageView()
                .environmentObject(authStateController)
                .environmentObject(shoppingListController)
        }
    }
}
