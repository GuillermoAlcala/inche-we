//
//  TaskItem.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 13/07/26.
//

import Foundation
import SwiftData

@Model
final class TaskItem{
    var id: UUID = UUID()
    var category : TaskCategories = TaskCategories.Office
    var title : String = ""
    var createDate = Date()
    var dueDate  = Date()
    var isCompleted : Bool = false
    var notify : Bool = false
    
    init(
    category: TaskCategories = .Office,
    title : String = "",
    createDate : Date = .now,
    dueDate: Date = Date(),
    isCompleted : Bool = false,
    notify: Bool){
     
        self.category = category
        self.title = title
        self.createDate = createDate
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.notify = notify
    }
    
    
}

enum TaskCategories: String, Codable,CaseIterable,Identifiable{
    case Office
    case Personal
    
    var id: Self{self}

}
