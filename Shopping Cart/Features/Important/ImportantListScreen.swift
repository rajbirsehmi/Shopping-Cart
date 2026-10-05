import SwiftUI
import SwiftData

struct ImportantListScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    // Automatically queries and listens for changes on important items
    @Query(filter: #Predicate<Item> { $0.isImportant == true },
           sort: [SortDescriptor(\Item.timestamp, order: .reverse)])
    private var items: [Item]
    
    private var viewModel: ImportantListViewModel {
        ImportantListViewModel(modelContext: modelContext)
    }
    
    var body: some View {
        Group {
            if items.isEmpty {
                ImportantListEmptyScreen()
            } else {
                List {
                    ForEach(items) { item in
                        ImportantListItem(
                            item: item,
                            onToggle: {
                                viewModel.toggleItem(for: item)
                            },
                            onToggleNotification: {
                                viewModel.toggleItem(for: item)
                            }
                        )
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                        .transition(.asymmetric(
                                    insertion: .scale(scale: 0.95).combined(with: .opacity).animation(.snappy(duration: 0.3)),
                                    removal: .opacity.animation(.easeOut(duration: 0.2))
                                ))
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            viewModel.deleteItem(items[index])
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Item.self, configurations: config)
    
    let context = container.mainContext
    context.insert(Item(itemName: "Important Meeting", isChecked: false, isImportant: true, isNotifiable: true, timestamp: 1, notifyAt: 0))
    context.insert(Item(itemName: "Important Meeting", isChecked: false, isImportant: true, isNotifiable: true, timestamp: 1, notifyAt: 0))
    
    return ImportantListScreen()
        .modelContainer(container)
}
