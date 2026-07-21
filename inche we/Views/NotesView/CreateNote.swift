//
//  CreateNote.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 01/07/26.
//

import SwiftUI

struct CreateNote: View {
    @State private var textEditor : String = ""
    @State private var isSelected : Bool = false
    @State private var selecion : String = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack{
                Form{
                    TextEditor(text: $textEditor)
                        .frame(height:600)
                        .lineLimit(10)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray).opacity(0.2))
                        .shadow(radius: 0.5)
                        .keyboardType(.emailAddress)
                        
                    
                }
                .navigationTitle("Create Note")
                .toolbar{
//                        
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Button("Save"){
//                            
//                        }.buttonStyle(.borderedProminent)
//                            .tint(.indigo.opacity(0.8))
//                        
//                    }
                    ToolbarItem {
                        Menu {
                            Button("Duplicate", systemImage: "plus.square.on.square") { }

                            Button("Share", systemImage: "square.and.arrow.up") { }

                            Button("Archive", systemImage: "archivebox") { }

                            Divider()

                            Button("Delete", systemImage: "trash", role: .destructive) { }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                    
                    
                    ToolbarItem(placement:.topBarLeading){
                        Button("Close",systemImage: "xmark.circle"){
                            dismiss()
                        }.tint(.red)
                    }
                    
                    ToolbarItemGroup(placement: .secondaryAction){
                        Button("Edit note",systemImage: "pencil"){
                            
                        }
                        Button("Favorites",systemImage:"star.fill"){
                            
                        }.tint(.yellow)
                        
                    }
                    
                }
        }
        
        
        
    }
}

#Preview {
    CreateNote()
}
