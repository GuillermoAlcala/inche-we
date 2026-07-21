//
//  NavigationController.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 01/07/26.
//

import Foundation

@Observable
final class NavigationController{
    var activeSheet : Sheets?
    
    enum Sheets: Identifiable{
        case profile
        case alerts
        case newNote
        case newTask
        case newGroceries
        
        var id: Self{self}
        
        
    }
}
