//
//  Item.swift
//  Shopping Cart
//
//  Created by Rajbir Singh Sehmi on 10/4/26.
//

import Foundation
import SwiftData

@Model
class Item {
    
    var id: UUID = UUID()
    var itemName: String
    var isChecked: Bool
    var isImportant: Bool
    var isNotifiable: Bool
    var timestamp: Int64
    var notifyAt: Int64
        
    init(id: UUID = UUID(), itemName: String, isChecked: Bool, isImportant: Bool,
        isNotifiable: Bool, timestamp: Int64, notifyAt: Int64 = 0) {
            self.id = id
            self.itemName = itemName
            self.isChecked = isChecked
            self.isImportant = isImportant
            self.isNotifiable = isNotifiable
            self.timestamp = timestamp
            self.notifyAt = notifyAt
    }
}
