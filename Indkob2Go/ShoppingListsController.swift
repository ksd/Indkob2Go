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
    private let shoppingListsDbRef = Firestore.firestore().collection("shoppinglists")
    private var shoppingListner: ListenerRegistration?
    private var itemsListner: ListenerRegistration?
    
    var activeShoppingListId: String?
    
    @Published private(set) var items: [Item] = []
    @Published private(set) var shoppingLists: [ShoppingList] = []
    
    init() {
        shoppingListner = ListListner(listDBRef: shoppingListsDbRef, handler: { querySnapshot in
            self.shoppingLists = querySnapshot.documents.compactMap { queryDocumentSnapshot -> ShoppingList? in
                return try? queryDocumentSnapshot.data(as: ShoppingList.self)
            }
        })
        
    }
    
    deinit {
        shoppingListner?.remove()
        itemsListner?.remove()
    }
    
    func addItemsListner() {
        guard let activeShoppingListId = activeShoppingListId else { return }
        let collectionRef = shoppingListsDbRef.document(activeShoppingListId).collection("items")
        print(activeShoppingListId)
        itemsListner?.remove()
        itemsListner = ListListner(listDBRef: collectionRef) { querySnapshot in
            self.items = querySnapshot.documents.compactMap { queryDocumentSnapshot -> Item? in
                return try? queryDocumentSnapshot.data(as: Item.self)
            }
        }
    }
    
    func addShoppingItem(name: String, amount: Int, description: String?, isBought: Bool, imageData: Data?) {
        guard let activeShoppingListId = self.activeShoppingListId else {return}
        let item = Item(name: name, description: description, amount: amount, isBought: isBought, imageData:imageData)
        do {
            let itemsDbRef = shoppingListsDbRef.document(activeShoppingListId).collection("items")
            let _ = try itemsDbRef.addDocument(from: item)
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteShoppingItem(item: Item){
        guard let activeShoppingListId = self.activeShoppingListId else {return}
        guard let id = item.id else { return }
        let itemsDbRef = shoppingListsDbRef.document(activeShoppingListId).collection("items")
        itemsDbRef.document(id).delete() { error in
            if let error {
                fatalError("Error deleting: \(error.localizedDescription)")
            }
        }
    }
    
    func ListListner(listDBRef: CollectionReference, handler: @escaping (QuerySnapshot)->Void) -> ListenerRegistration {
        return listDBRef.addSnapshotListener { querysnapshot, error in
            if let error = error {
                fatalError("Error retreiving collection: \(error)")
            }
            guard let querysnapshot else { return }
            handler(querysnapshot)
        }
    }
}
