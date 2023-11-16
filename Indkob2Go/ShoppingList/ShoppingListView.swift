//
//  ShoppingListView.swift
//  Indkob2Go
//
//  Created by ksd on 06/11/2023.
//

import SwiftUI

enum Routes {
    case detail
    case user
}

struct ShoppingListView: View {
    @EnvironmentObject var listController: ShoppingListsController
    @State private var showAddSheet = false
    @State private var showConfirmDelete = false
    @State private var deleteDetails: Item?
    
    @State private var navigationPaths = [Routes]()
    
    var body: some View {
        NavigationStack(path: $navigationPaths) {
            List {
                ForEach(listController.items) {item in
                    NavigationLink(item.name, value: Routes.detail)
                }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        deleteDetails = listController.items[index]
                        showConfirmDelete = true
                    }
                })
            }
            .navigationTitle("Indkøbsliste")
            .navigationDestination(for: Routes.self, destination: { destination in
                switch(destination) {
                case .detail:
                    Text("detail")
                case .user :
                    ProfileView()
                        .navigationBarBackButtonHidden(true)
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        navigationPaths.append(.user)
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddItemView()
            }
            .confirmationDialog("Bekræft sletning", isPresented: $showConfirmDelete, presenting: deleteDetails) { detail in
                Button(role: .destructive) {
                    listController.deleteShoppingItem(item: detail)
                } label: {
                    Text("Slet \(detail.name)?")
                }
                Button("Cancel", role: .cancel) {
                    deleteDetails = nil
                }
            }
        }
    }
}

#Preview {
    ShoppingListView().environmentObject(ShoppingListsController())
}
