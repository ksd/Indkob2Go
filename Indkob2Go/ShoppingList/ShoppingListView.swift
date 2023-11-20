//
//  ShoppingListView.swift
//  Indkob2Go
//
//  Created by ksd on 20/11/2023.
//

import SwiftUI

enum Routes: Hashable {
    case detail
    case user
    case items(ShoppingList?)
}

struct ShoppingListView: View {
    @EnvironmentObject var listController: ShoppingListsController
    @State private var navigationPaths = [Routes]()
    
    var body: some View {
        NavigationStack(path: $navigationPaths) {
            List {
                ForEach(listController.shoppingLists) { list in
                    NavigationLink(value: Routes.items(list)) {
                        Text(list.name)
                    }
                }
            }
            .navigationTitle("ShoppingLists")
            .navigationDestination(for: Routes.self, destination: { destination in
                switch(destination) {
                case .items(let shoppingList):
                    ShoppingListItemView(navigationPaths: $navigationPaths, shoppingList: shoppingList)
                case .user :
                    ProfileView()
                        .navigationBarBackButtonHidden(true)
                default:
                    ShoppingListView()
                }
            })
        }
    }
}

#Preview {
    ShoppingListView().environmentObject(ShoppingListsController())
}
