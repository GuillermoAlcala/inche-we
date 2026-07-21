//
//  SummaryGroceriesRow.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 11/07/26.
//

import SwiftUI
import SwiftData
struct SummaryGroceriesRow: View {
    @Query(sort: \Product.date, order:.reverse) private var products : [Product]
    @State private var showCatalog = false
    @Binding var SelecteProducts : [Product]
    
    var body: some View {
        Button{
            showCatalog = true
        }label: {
            HStack{
                Image(systemName: "basket.fill")
                    .foregroundStyle(.orange)
                VStack(alignment: .leading){
                    Text("Groceries").font(.headline)
                    //validando que haya información en el modelo
                    Text(products.isEmpty ? "No data found" : "\(products.count) elements")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.pink)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))

        }.buttonStyle(.plain)
            .sheet(isPresented: $showCatalog){
                ProductCatalogSheet(mode: .select,
                                    SelectedProducts: $SelecteProducts)
            }
    }
}
//
//#Preview {
//    SummaryGroceriesRow()
//}
