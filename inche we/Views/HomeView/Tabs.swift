//
//  Tabs.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 30/06/26.
//

import SwiftUI

struct Tabs: View {
    enum AppTab: Hashable {
        case explore, notes, task, groceries, search
    }
    @State private var searchable : String = ""
    @State private var selection: AppTab = .explore


    var body: some View {
        TabView{
            Tab("Explore", systemImage: "house"){
                Explore()
            }
            Tab("Notes", systemImage: "rectangle.and.pencil.and.ellipsis"){
                Notes()
            }
            Tab("Task",systemImage:"lasso.badge.sparkles"){
                NewTask()
                
            }
            Tab("Groceries",systemImage: "fish"){
           //     SummaryGroceriesRow(SelecteProducts: $SelectedProducts)
                GroceriesView()
            }
            Tab("Search",systemImage: "magnifyingglass",role: .search){
                NavigationStack{
                    Text("")
                }
                
                .searchable(text: $searchable,placement:.toolbarPrincipal,prompt: Text("Find any note, task"))
            }
        }
    }
}

#Preview {
    Tabs()
}
