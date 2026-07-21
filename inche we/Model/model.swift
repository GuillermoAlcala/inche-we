//
//  model.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 08/07/26.
//

import Foundation
import SwiftData

@Model
class Product: Identifiable{
    var id = UUID()
    var name: String
    var qty : Int
    var date = Date()
    
    @Relationship(inverse: \GroceryList.products)   // 👈 Relación
    var groceryLists: [GroceryList] = []             // 👈 propiedad nueva

    init(id: UUID = UUID(), name: String, qty: Int, date: Date = .now) {
        self.id = id
        self.name = name
        self.qty = qty
        self.date = date
    }
    
}
