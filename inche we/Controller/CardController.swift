//
//  CardController.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 03/07/26.
//

import Foundation
enum CreateItem: Identifiable, CaseIterable{
    case note
    case task
    case groceries
    
    var id: Self{self}
    
    
    var title: String{
        switch self{
        case .note :
            return "New note"
        case .task:
            return "New task"
        case .groceries:
            return "New groceries"
        }
        
    }
    
    var icon: String{
        switch self{
        case .note :
            return "pencil.and.scribble"
        case .task:
            return "lasso.badge.sparkles"
        case .groceries:
            return "fish"
        }
    }
    
    var destination : NavigationController.Sheets{
        switch self{
        case .note:
            return .newNote
        case .task:
            return.newTask
        case .groceries:
            return.newGroceries
        }
    }
    
}
