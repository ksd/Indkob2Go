//
//  ShoppingListsController.swift
//  Indkob2Go
//
//  Created by ksd on 06/11/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ShoppingListsController: ObservableObject {
    private let itemsDbRef = Firestore.firestore().collection("items")
    private var listner: ListenerRegistration?
    
    @Published var items: [Item] = []
    
    init() {
        listListner()
    }
    
    deinit {
        listner?.remove()
    }
    
    func addShoppingItem(name: String, amount: Int, description: String?, isBought: Bool) {
        let item = Item(name: name, description: description, amount: amount, isBought: isBought)
        do {
            let _ = try itemsDbRef.addDocument(from: item)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteShoppingItem(item: Item){
        guard let id = item.id else { return }
        itemsDbRef.document(id).delete() { error in
            if let error {
                print("Error deleting: \(error.localizedDescription)")
            }
        }
    }
    
    func listListner() {
        listner =  itemsDbRef.addSnapshotListener { querysnapshot, error in
            if let error = error {
                print("Error retreiving collection: \(error)")
            }
            guard let querysnapshot else { return }
                self.items = querysnapshot.documents.compactMap { queryDocumentSnapshot -> Item? in
                    return try? queryDocumentSnapshot.data(as: Item.self)
                }
        }
    }
}