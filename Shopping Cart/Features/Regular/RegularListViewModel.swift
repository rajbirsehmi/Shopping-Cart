import Foundation
import SwiftData

@Observable
class RegularListViewModel {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func toggleItem(for item: Item) {
        item.isChecked.toggle()
        try? modelContext.save()
    }
    
    func deleteItem(_ item: Item) {
        NotificationManager.shared.cancelNotification(for: item)
        modelContext.delete(item)
        try? modelContext.save()
    }
}
