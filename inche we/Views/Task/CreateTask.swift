//
//  CreateTask.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 02/07/26.
//

import SwiftUI
import SwiftData
struct CreateTask: View {
    
    // MARK: - States Zone -> PersonalView

    
    @State private var calendar : Date = .now
    @State private var category : categories = .office
    @State private var openSheetCategory : Bool = false
    @State private var openSheetCalendar : Bool = false
    @Query(sort:\TaskItem.createDate, order:.reverse) private var personal : [TaskItem]
    @Query(sort:\TaskItem.createDate, order:.reverse) private var offices : [TaskItem]
    
    @Environment(\.modelContext) private var modelcontext

//    @State private var name : String = ""
//    @State private var pendigStask : String = ""
//    @State private var personal : String = ""
//    
    // MARK: - RELATION TO BINDING
    @State private var title : String = ""
    @State private var qty: Int = 0
    @Environment(\.dismiss) private var dismiss // usarlo al momento de guardar
    
    enum categories: String, CaseIterable, Identifiable{
        case office = "Office"
        case personal = "Personal"
        
        var id: Self { self }

    }
    var body: some View {
        NavigationStack{
            VStack(alignment:.center){
                PickerCategories
                Spacer()
                    AllCategories
            
                Spacer()
                 CustomContent
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .scrollContentBackground(.hidden)
            }
                .navigationTitle("New task")
                .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("New",systemImage: "plus"){
                        openSheetCategory = true
                    }.tint(.orange)
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Calendar",systemImage: "calendar.badge"){                    
                        //MARK: - agregar estado para abrir un sheet del calendario
                        openSheetCalendar.toggle()
                    }
                }
                
            }
            .sheet(isPresented: $openSheetCalendar){
                Calendar
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            
            .sheet(isPresented: $openSheetCategory){
                if category == .office{
                    OfficeView(mode: .create)
                }else if category == .personal{
                    PersonalView(mode: .create)
                }
                //MARK: -  falta agregar la categoria personal
            }
        
        }//navigationStack
        
    }
    @ViewBuilder
    private var Calendar: some View{
        DatePicker("Calendar",
                   selection: $calendar,
                   in: Date()..., displayedComponents: .date)
        .datePickerStyle(.graphical)
            .tint(.orange)
    }
    
    
    @ViewBuilder
    private var PickerCategories: some View{
        Picker("Categories", selection: $category){
            ForEach(categories.allCases){ value in
                Text(value.rawValue).tag(value)
            }
        }.pickerStyle(.segmented)
    }
    // MARK: - ALL CATEGORIES SEGMENTED
    @ViewBuilder
    private var AllCategories: some View{
                switch category {
                case .office:
                    OfficeView(mode: .view)
                case .personal:
                    PersonalView(mode: .view)
                }
    
        
    }
    @ViewBuilder
    private var CustomContent: some View{
//                if offices.isEmpty && category == .office{
//                    ContentUnavailableView("No data found",
//                                           systemImage: "brain.head.profile",
//                                           description: Text("Create any record"))
//                }
         if personal.isEmpty && category == .personal{
                    ContentUnavailableView("No data found",
                                           systemImage: "hand.thumbsup", description: Text("Create any record"))
                }
        //end if
                    
//        switch category {
//        case .groceries :
//            if products.isEmpty{
//                ContentUnavailableView("No data found",
//                                       systemImage: "basket",
//                                       description: Text("Create any record"))
//            }
//        case .office:
//            if offices.isEmpty{
//                ContentUnavailableView("No data found",
//                                       systemImage: "brain.head.profile",
//                                       description: Text("Create any record"))
//            }
//        case .personal:
//            if products.isEmpty{
//                ContentUnavailableView("No data found",
//                                       systemImage: "hand.thumbsup",
//                                       description: Text("Create any record"))
//            }
//        }
    } //
    // MARK: - CATEGORIES
//    @ViewBuilder
//    private var CategoryGroceries: some View{
//        if category == .groceries{
//            TextField("Name", text: $name)
//        }
//    }
//    
//    @ViewBuilder
//    private var CategoryOffice: some View{
//        if category == .office{
//            TextField("Activiades pendientes", text: $pendigStask)
//        }
//        
//    }
//    
//    @ViewBuilder
//    private var CategoryPersonal: some View{
//        if category == .personal{
//            TextField("Activiades personales", text: $personal)
//
//        }
//    }
    
    
}

//#Preview {
//    CreateTask()
//}
