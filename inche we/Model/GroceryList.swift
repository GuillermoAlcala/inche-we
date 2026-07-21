//
//  GroceryList.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 14/07/26.
//

import Foundation
import SwiftData

@Model
class GroceryList: Identifiable {          // 🆕 NUEVO archivo/modelo completo
    var id = UUID()
    var date = Date()
    var products: [Product] = []            // relación con el modelo Product

    init(id: UUID = UUID(), date: Date = .now, products: [Product] = []) {
        self.id = id
        self.date = date
        self.products = products
    }
}
