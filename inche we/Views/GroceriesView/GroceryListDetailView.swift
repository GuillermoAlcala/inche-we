//
//  GroceriesDetail.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 12/07/26.
//

import SwiftUI
import SwiftData
struct GroceryListDetailView: View {
    let list : GroceryList
    var body: some View {
        
        List(list.products){ item in
            HStack{
                Text(item.name)
                Spacer()
                Text("\(item.qty)")
                    .font(.footnote)
            }
            
        }.navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

