//
//  Item.swift
//  Indkob2Go
//
//  Created by ksd on 06/11/2023.
//

import Foundation

import FirebaseFirestoreSwift

struct Item: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let description: String?
    var amount = 1
    var isBought = false
    var imageData: Data?
}
