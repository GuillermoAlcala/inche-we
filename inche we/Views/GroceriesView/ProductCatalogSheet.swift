//
//  ProductCatalogSheet.swift
//  inche we
//Vista para mostrar todos los productos
//  Created by GuillermoChaconAlcala on 08/07/26.
//

import SwiftUI
import SwiftData

struct ProductCatalogSheet: View {
    enum CatalogMode{
        case manage
        case select
    }
    let mode: CatalogMode

    @Binding var SelectedProducts : [Product]
    @Query(sort:\Product.date, order:.reverse) private var products:[Product]
    @Environment(\.modelContext) private var modelcontext
    @Environment(\.dismiss) private var dismiss
    @State private var showAddProduct : Bool = false
    
    
    //MARK: - Variable para filtrar los productos
    var filteredProducts: [Product]{
        if searchable.isEmpty{return products}
        return products.filter{
            $0.name.localizedCaseInsensitiveContains(searchable)
        }
    }
    @State private var searchable : String = ""
    var body: some View {
        NavigationStack{
            List{
                //MARK: - ViewBuilder
                RowProducts
                    
            }
            //MARK: - Buscador de productos
            .searchable(text: $searchable,placement: .automatic,prompt: Text("Find your products or add any"))
            
            //MARK: - Title
            .navigationTitle(mode == .manage ? "Catalog" : "Select products")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: - Barra de botones
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add item",systemImage: "plus"){
                    showAddProduct = true
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    Button("Done"){
                      SaveCatalog()
                        
                        dismiss()
                    }.disabled(mode == .select && SelectedProducts.isEmpty)
                }
                
                
            })
        }//navigationStack
        .sheet(isPresented: $showAddProduct){
            NavigationStack{
                AddProductSheet()
            }
            .presentationDetents([.height(750)])
            .presentationDragIndicator(.visible)
        }
        .overlay{
            CustomContent
        }
    }
    
    @ViewBuilder
    private var RowProducts : some View{
            ForEach(filteredProducts){ item in
                HStack{
                    Text("\(item.name)")
                    Spacer()
                    //MARK: - Checkmark de selección (solo en modo .select)
                    if mode == .select {
                                       Image(systemName: isSelected(item) ? "checkmark.circle.fill" : "circle")
                                           .foregroundStyle(.green)
                                  }
                }.contextMenu(){
                    Button("Delete", systemImage: "trash"){
                        DeleteCatalog(item: item)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if mode == .select {
                    toggleSelection(item)
                   }
                }
                
                .swipeActions(edge: .leading, allowsFullSwipe: false){
                    if mode == .manage{
                        Button("Delete",systemImage: "trash"){
                            DeleteCatalog(item: item)
                        }
                    }
                }.tint(.pink)
            }
    }
    @ViewBuilder
    private var CustomContent: some View{
        VStack(alignment: .center){
            if products.isEmpty{
                ContentUnavailableView("No data found", systemImage: "basket", description: Text("Please add your products on plus button"))
            }
        }.frame(maxWidth: .infinity)
            .padding()
    }
    
    // MARK: - FUNCIONES
    private func SaveCatalog(){
        // MARK: - PENDIENTE MODIFICAR
        guard mode == .select else{
            dismiss(); return
        }
        
        let list = GroceryList(date: .now, products: SelectedProducts)
        modelcontext.insert(list)
        do{
            try modelcontext.save()
            print("Producto was inserted")

        }
        catch{
            print("There is an error", error.localizedDescription)
        }
    }
    private func DeleteCatalog(item: Product){
        modelcontext.delete(item)
        do{
            try modelcontext.save()
            print("Information was deleted")
        }
        catch{
            print("There is an error", error.localizedDescription)
        }
    }
    
    // MARK: - FUNCIONES DE SELECCIÓN
    private func isSelected(_ product: Product)-> Bool{
        SelectedProducts.contains(where: {$0.id == product.id})
    }
    private func toggleSelection(_ product: Product){
          if let index = SelectedProducts.firstIndex(where: { $0.id == product.id }){
              SelectedProducts.remove(at: index)
          } else {
              SelectedProducts.append(product)
          }
      }
    
    
}//struct
//
#Preview {
    ProductCatalogSheet(mode: .manage, SelectedProducts: .constant([]))
}

//to do: alertas al guardar, mensaje de que ya existe un producto, editar, eliminar
