//
//  Groceries.swift
//  inche we
//

import SwiftUI
import SwiftData

struct GroceriesView: View {
    @Query(sort: \GroceryList.date, order: .reverse) private var lists: [GroceryList]
    @Environment(\.modelContext) private var modelcontext
    @State private var showCatalog = false
    @State private var newSelection: [Product] = []   // 👈 selección "en blanco" cada vez que se crea una lista nueva

    var body: some View {
        NavigationStack {
            Group {
                if lists.isEmpty {
                    ContentUnavailableView("No hay listas todavía",
                                           systemImage: "basket",
                                           description: Text("Crea tu primera lista con el botón +"))
                } else {
                    List {
                        ForEach(lists) { list in
                            NavigationLink {
                                GroceryListDetailView(list: list)
                            } label: {
                                HStack {
                                    Image(systemName: "basket.fill")
                                        .foregroundStyle(.orange)
                                    VStack(alignment: .leading) {
                                        Text("Groceries")
                                            .font(.headline)
                                        Text("\(list.products.count) elements")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Text(list.date, style: .date)
                                        .font(.caption)
                                        .foregroundStyle(.tertiary)
                                }
                            }
                        }
                        .onDelete(perform: deleteLists)
                    }
                }
            }
            .navigationTitle("Groceries")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Add", systemImage: "plus") {
                        newSelection = []
                        showCatalog = true
                    }
                }
            }
            .sheet(isPresented: $showCatalog) {
                ProductCatalogSheet(mode: .select, SelectedProducts: $newSelection)
            }
        }
    }
    private func deleteLists(at offsets: IndexSet) {
        for index in offsets {
            modelcontext.delete(lists[index])
        }
        do {
            try modelcontext.save()
        } catch {
            print("Error al borrar:", error.localizedDescription)
        }
    }
}

#Preview {
    GroceriesView()
}
