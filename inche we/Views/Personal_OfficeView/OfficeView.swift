//
//  Office.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 06/07/26.
//

import SwiftUI
import SwiftData
struct OfficeView: View {
    enum CatalogMode{
        case view
        case create
    }
    let mode : CatalogMode
    @State private var title : String =  ""
    @State private var createDate : Date = .now
    @Query(sort:\TaskItem.createDate, order: .reverse) private var taskOffice: [TaskItem]
    @Environment(\.modelContext) private var modelcontext
    
    var body: some View {
        NavigationStack{
            VStack{
                if mode == .create{
                    TextField("Add the task", text: $title)
                    DatePicker("Choose the date", selection: $createDate, displayedComponents: .date)
                }
                CustomContent
            }
            
                .listRowBackground(Color.clear)
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
        
            .padding(.horizontal)
            .navigationTitle("Your task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save"){
                      saveTask()
                    }.tint(.pink)
                }
            }
        }
    }
    @ViewBuilder
    private var CustomContent: some View{
        if taskOffice.isEmpty{
            ContentUnavailableView("No data found",
                                   systemImage: "brain.head.profile",
                                   description: Text("Create any record"))
        }else{
            List{
                ForEach(taskOffice){ item in
                    VStack{
                        Text(item.title)
                        Text(item.createDate.formatted(date: .abbreviated, time: .omitted))
                            .font(.footnote)
                            .font(.subheadline)
                    }
                    
                    //agregar el swipe para eliminar
                    .swipeActions(edge: .leading, allowsFullSwipe: false){
                        Button("Delete", systemImage: "trash", role: .destructive){
                            modelcontext.delete(item)
                            do{
                                try modelcontext.save()
                                print("Record was deleted")
                            }
                            catch{
                                print("Error al eliminar", error.localizedDescription)
                            }
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
            }
        }
    }
    func saveTask(){
        let list = TaskItem(category: .Office, title: title, createDate: createDate, dueDate: .now, isCompleted: false, notify: false)
        modelcontext.insert(list)
        try? modelcontext.save()
    }
}
//
//#Preview {
//    OfficeView()
//}
