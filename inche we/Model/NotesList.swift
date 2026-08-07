//
//  Notes.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 06/08/26.
//

import Foundation
import SwiftData

@available(iOS 17, *)
@Model
final class ModelNotes: Identifiable{
     var id : UUID = UUID()
     var content : String = ""
    var CreationDate = Date()
    
    
    init(id: UUID, content: String, CreationDate: Date) {
        self.id = id
        self.content = content
        self.CreationDate = CreationDate
    }
}
