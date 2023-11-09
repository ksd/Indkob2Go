//
//  ShoppingListView.swift
//  Indkob2Go
//
//  Created by ksd on 06/11/2023.
//

import SwiftUI

struct ShoppingListView: View {
    @EnvironmentObject var listController: ShoppingListsController
    @State private var showAddSheet = false
    @State private var showConfirmDelete = false
    @State private var deleteDetails: Item?
    var body: some View {
        NavigationStack{
            List {
                ForEach(listController.items) {item in
                    Text(item.name)
                }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        deleteDetails = listController.items[index]
                        showConfirmDelete = true
                    }
                })
            }
            .navigationTitle("Indkøbsliste")
            .toolbar {
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
                    Text("Slet \(detail.name)")
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
