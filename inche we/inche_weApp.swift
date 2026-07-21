//
//  inche_weApp.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 30/06/26.
//

import SwiftUI
import SwiftData
@main
struct inche_weApp: App {
    var body: some Scene {
        WindowGroup {
            Tabs()
            
        }
        .modelContainer(for: [Product.self, GroceryList.self, TaskItem.self])

    }
}
