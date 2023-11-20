//
//  ShoppingList.swift
//  Indkob2Go
//
//  Created by ksd on 20/11/2023.
//

import Foundation

import FirebaseFirestoreSwift

struct ShoppingList: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let name: String
}
