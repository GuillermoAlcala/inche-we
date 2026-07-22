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
    @State private var dueDate : Date = .now
    @State private var isCompleted : Bool = false
    @State private var nofitied: Bool = false
    
    
    var editInformation : TaskItem?
    @State private var editingTask: TaskItem? = nil   //  nuevo: dispara el sheet de edición
    @Query(sort:\TaskItem.createDate, order: .reverse) private var taskOffice: [TaskItem]
    @Environment(\.modelContext) private var modelcontext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
                Form{
                    if mode == .create{
                        TextField("Add the task", text: $title)
                        DatePicker("Choose the date", selection: $createDate, in: Date()..., displayedComponents: .date)
                            .tint(.pink)
                    }else{
                        CustomContent
                    }
                    
                }
            
              //  .listRowBackground(Color.clear)
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
        
            .padding(.horizontal)
            .navigationTitle("Your task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if mode == .create{
                ToolbarItem(placement: .topBarTrailing){
                    // MARK: - Esta línea de código me permite ocultar el el boton de save en caso que la pantalla este en modo View, en caso contrario deberá mostrarse en modo Create.
                        Button("Save"){
                          saveTask()
                        

                        }.tint(.pink)
                    }
                }
            } //toolbar
            
            .onAppear{ // para mostrar la información al momento de abrir el sheet 👇
                if let editInformation{
                    title = editInformation.title
                    createDate = editInformation.createDate
                    dueDate = editInformation.dueDate
                    isCompleted = editInformation.isCompleted
                    nofitied = editInformation.notify
                    
                }
            }
            .sheet(item: $editingTask){ task in //abre la ventana de creación en modo edición
                    EditOfficeTaskView(task: task)
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
                    VStack(alignment:.leading){
                        Text(item.title)
                            .font(.headline)
                        Text(item.createDate.formatted(date: .abbreviated, time: .omitted))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    .contextMenu{
                        Button("Delete",systemImage: "trash",role:.destructive){
                        deleteTask(task: item)
                        }
                        Button("Edit",systemImage: "pencil"){
                            editingTask = item
                        }
                    }
                    //agregar el swipe para eliminar
                    .swipeActions(edge: .leading, allowsFullSwipe: false){
                        Button("Delete", systemImage: "trash", role: .destructive){
                            deleteTask(task: item)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false){
                        Button("Edit", systemImage: "pencil.line"){
                            // TODO: - AGREGAR FUNCIONALIDAD PARA EDITAR
                            editingTask = item
                        }.tint(.blue)
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
        dismiss()
        }
    
    func deleteTask(task: TaskItem){
        modelcontext.delete(task)
        do{
            try modelcontext.save()
            print("Elemento borrado con éxito")
        }
        catch{
            print("Error al borrar", error.localizedDescription)
        }
        
    }
}
//
//#Preview {
//    OfficeView()
//}
