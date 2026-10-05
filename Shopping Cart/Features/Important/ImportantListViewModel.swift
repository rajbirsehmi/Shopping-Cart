import Foundation
import SwiftData

@Observable
class ImportantListViewModel {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func toggleNotification(for item: Item) {
        item.isNotifiable.toggle()
        
        if item.isNotifiable {
            NotificationManager.shared.scheduleNotification(for: item)
        } else {
            NotificationManager.shared.cancelNotification(for: item)
        }
        
        try? modelContext.save()
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
