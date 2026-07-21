//
//  AppProductSheet.swift
//  inche we
//  Vista para agregar productos.
//  Created by GuillermoChaconAlcala on 09/07/26.
//

import SwiftUI
import SwiftData
struct AddProductSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var productName : String = ""
    @State private var qty : Int?
    
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Product name",
                          text: $productName,
                          prompt: Text("Add a new product"))
            }
            .navigationTitle("New product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save",systemImage: "checkmark"){
                        saveData()
                        dismiss()
                    }
                }
            }
        }
    }
    
    func saveData(){
        let product = Product(name: productName, qty: qty ?? 1, date: .now)
        modelContext.insert(product)
        do{
            try modelContext.save()
            print("Information was saved")
        }
        catch{
            print(error.localizedDescription)
        }
        
        dismiss()
    }
} //struct

#Preview {
    AddProductSheet()
}
