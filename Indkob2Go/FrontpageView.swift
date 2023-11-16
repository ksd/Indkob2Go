//
//  FrontpageView.swift
//  Indkob2Go
//
//  Created by ksd on 02/11/2023.
//

import SwiftUI

struct FrontpageView: View {
    @EnvironmentObject var stateController: AuthStateController
    var body: some View {
        Group {
            if stateController.userSession != nil {
                ShoppingListView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    FrontpageView()
        .environmentObject(AuthStateController())
        .environmentObject(ShoppingListsController())
}
