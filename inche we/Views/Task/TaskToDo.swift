//
//  Task.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 30/06/26.
// aquí van todas las tareas creadas en la vista Task

import SwiftUI
import SwiftData
struct TaskToDo: View {
    @Query(sort:\Product.date, order: .reverse) private var query : [Product]
    @Environment(\.modelContext) private var modelcontext
    var body: some View {
        NavigationStack{
            List{
                ForEach(query) { val in
                        Text(val.name)
                //        Spacer()
                //        Text("\(val.qty)")
                    
                        .swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button("Delete",systemImage: "trash",role: .destructive){
                                modelcontext.delete(val)
                                try? modelcontext.save()
                                
                            }
                        }
                }
                
            }
                .navigationTitle("Task")
        }
        
    }
}

#Preview {
    TaskToDo()
        .modelContainer(for: Product.self)
}
