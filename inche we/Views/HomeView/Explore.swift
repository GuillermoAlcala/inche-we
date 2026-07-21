//
//  ContentView.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 30/06/26.
//

import SwiftUI

struct Explore: View {
    @State private var searchable : String = ""
    @State private var isPresented : Bool = false
    @State private var navigationController = NavigationController()
   // @Binding var SelecteProducts : [Product]
    @State private var selection : [Product] = []
    var body: some View {
        NavigationStack{
            VStack(alignment: .center){
                HelloGood()
                ScrollView(.vertical){
                    RowCard
                }
            }.toolbar{
                ToolbarItem(placement: .topBarTrailing ){
                    Menu("menu", systemImage: "ellipsis"){
                        Button("Profile",systemImage: "person.crop.circle"){
                        navigationController.activeSheet = .profile
                        }
                        Divider()
                        
                        Button("New note",systemImage: "square.and.pencil"){
                            navigationController.activeSheet = .newNote
                        }
                        Button("New task",systemImage:"lasso.badge.sparkles"){
                            navigationController.activeSheet = .newTask
                        }
                        Button("Groceries", systemImage: "fish"){
                            navigationController.activeSheet = .newGroceries
                        }
                    }
                }
//                ToolbarItemGroup(placement: .topBarTrailing){
//                    
//                    Button("Alert",systemImage: "bell"){
//                        navigationController.activeSheet = .alerts
//                    }
//                    Button("Profile",systemImage: "person.crop.circle"){
//                        navigationController.activeSheet = .profile
//
//                    }
//                    
//                }
                
            }//.toolbarRole(.navigationStack)
                
            .sheet(item: $navigationController.activeSheet){ destination in
                switch destination{
                case .newNote:CreateNote()
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)

                case .alerts : Alerts()
                case .profile : Profile()
                    
                case .newTask : CreateTask()
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                
                case .newGroceries:
              
                    //GroceriesView()
                    ProductCatalogSheet(mode: .select,
                                        SelectedProducts: $selection)
                    
                }
            }

            
        }
        
    }
    
    @ViewBuilder
    var RowCard: some View {
        LazyVGrid(columns: [
//            GridItem(.flexible(),spacing: 8),
            GridItem(.flexible(),spacing: 8)],spacing: 12){
                ForEach(CreateItem.allCases){ item in
                    NewCard(note: item.title,
                            img: item.icon,
                            overlay: item.icon,
                            action: {
//                        navigationController.activeSheet = .newNote
                        navigationController.activeSheet = item.destination
                    })
                
                    
                }
            }.padding(.horizontal,16)
    }
}

//#Preview {
//    Explore()
//}

