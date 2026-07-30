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
    @State private var dueDate = Calendar.current.date(byAdding: .hour, value: 1, to: .now) ?? .now
    @State private var isCompleted : Bool = false
    @State private var nofitied: Bool = false
    @State private var isPresentedAlert : Bool = false
    
    @State private var editingTask: TaskItem? = nil   //  nuevo: dispara el sheet de edición
    
    // MARK: - SWIFDATA
    @Query(sort:\TaskItem.createDate, order: .reverse) private var taskOffice: [TaskItem]
    @Environment(\.modelContext) private var modelcontext
    @Environment(\.dismiss) private var dismiss

    
    // MARK: - FILTER
    var filteredResult: [TaskItem]{ // reemplace taskOffice con filteredResult para filtrar únicammente por la categoria office
        taskOffice.filter{$0.category == .Office}
    }
    
    
    
    var body: some View {
        NavigationStack{
                Form{
                    if mode == .create {
                        TextField("Add the task", text: $title)
                        DatePicker("Choose the due date", selection: $dueDate, in: Date()..., displayedComponents: [.date,.hourAndMinute])
                            .tint(.pink)
                            Toggle("Notification", isOn: $nofitied)
                        
                    }else{
                        CustomContent
                    }
                    
                }
            
              //  .listRowBackground(Color.clear)
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
        
            .padding(.horizontal)
            .navigationTitle("New task")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar{
                if mode == .create{
                ToolbarItem(placement: .topBarTrailing){
                    // MARK: - Esta línea de código me permite ocultar el el boton de save en caso que la pantalla este en modo View, en caso contrario deberá mostrarse en modo Create.
                        Button("Save"){
                          saveTask()
                        }.tint(.pink)
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty || dueDate < Date())   // 29072026

                    }
                }
                
                if mode == .view{
                    ToolbarItem(placement: .secondaryAction){
                        ButtonCleanAll
                    }
                }
                
            } //toolbar
            
            .sheet(item: $editingTask){ task in //abre la ventana de creación en modo edición para editar
                    EditOfficeTaskView(task: task)
            }
            
        }
    }
    @ViewBuilder
    private var CustomContent: some View{
        if filteredResult.isEmpty{
            ContentUnavailableView("No data found",
                                   systemImage: "brain.head.profile",
                                   description: Text("Create any record"))
        }else{
            List{
                ForEach(filteredResult){ item in
                    HStack{ // el boton se posiciona al lado izquierdo de la lista
                        Button("",systemImage: item.isCompleted ? "checkmark.circle.fill" : "circle"){
                            toggleIsCompleted(item: item)
                        }
                        .foregroundStyle(item.isCompleted ? .green : .secondary)
                        .buttonStyle(.plain)
                        
                        VStack(alignment:.leading){
                            
                            Text(item.title)
                                .font(.headline)
                                .strikethrough(item.isCompleted, color: .secondary)
//                            Text("Creation date: \(item.createDate.formatted(date: .abbreviated, time: .omitted))")
//                                .font(.subheadline)
//                                .foregroundStyle(.secondary)
                            Text("Due date: \(item.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                .font(.subheadline)
                                .foregroundStyle(isOverdue(item: item) ? .red : .secondary)
                            
//
//                            Text("\(item.dueDate, style: .relative)")
//                                .font(.subheadline)
//                                .foregroundStyle(isOverdue(item: item) ? .red : .secondary)
//
                            //revisar, si la fecha fin es > a hoy, mostrar en tiempo
                            if item.dueDate > Date(){
                                Text("In time \(item.dueDate, style: .relative)")
                                    .font(.subheadline)
                                   // .foregroundStyle(isOverdue(item: item) ? .red : .secondary)
                                    .foregroundStyle(.secondary)

                                
                            }else{
                                Text("Time over \(item.dueDate, style: .relative)")
                                    .font(.subheadline)
                                //    .foregroundStyle(isOverdue(item: item) ? .red : .secondary)
                                    .foregroundStyle(.red)

                            }
                        }//Vstack
                    }//Hstack
                    .contextMenu{
                        Button("Delete",systemImage: "trash",role:.destructive){
                        deleteTask(task: item)
                        }
                        Button("Edit",systemImage: "pencil"){
                            editingTask = item
                        }
                    }
                    //agregar el swipe para eliminar
                    .swipeActions(edge: .trailing, allowsFullSwipe: false){
                        Button("Delete", systemImage: "trash", role: .destructive){
                            deleteTask(task: item)
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false){
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
    
    // MARK: - FUNCTIONS
    func isOverdue(item: TaskItem) -> Bool{
        item.dueDate < Date() && !item.isCompleted
    }
    func toggleIsCompleted(item: TaskItem){ //24072026
        // cambia a true
        item.isCompleted.toggle()
        do{
            try modelcontext.save()
            print("Se cambió a completado")
        }
        catch{
            print("Error en actualizar", error.localizedDescription)
        }
    }
    func saveTask(){
        let list = TaskItem(category: .Office,
                            title: title,
                            createDate: .now,
                            dueDate: dueDate,
                            isCompleted: isCompleted,
                            notify: nofitied)
        
        modelcontext.insert(list)
        do{
            try modelcontext.save()
            dismiss()
        }
        catch{
            print("Error al guardar", error.localizedDescription)
        }
        
        
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
    
    func DeleteAllTask(){
        for item in filteredResult{
            modelcontext.delete(item)
        }
        do{
            try modelcontext.save()
            print("All the information were cleaned")
        }
        catch{
            print("Failed to delete TaskItems.", error.localizedDescription)

        }
    }
    
 // MARK: - DECORATORS
    
    @ViewBuilder
    private var ButtonCleanAll: some View{
        Button("Clean all", systemImage: "trash"){
            isPresentedAlert = true
        }
        .disabled(filteredResult.isEmpty) // me deshabilita el boton ya que el modelo esta vacio.
        .tint(filteredResult.isEmpty ? .secondary : .red)
        
        // MARK: - CONFIRM DIALOG
        .confirmationDialog("¿Are you sure?", isPresented: $isPresentedAlert, titleVisibility: .visible, actions: {
                Button("Delete",role:.destructive){
                    //withAnimation{DeleteAllTask()}
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)){
                        DeleteAllTask(
                        )}
                }
                Button("Cancel", role: .cancel){
                    
                }
            }, message:{
                Text("This action cannot be undone.")
            })
    }
}
//
//#Preview {
//    OfficeView()
//}
