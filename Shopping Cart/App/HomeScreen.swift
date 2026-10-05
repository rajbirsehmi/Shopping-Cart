import SwiftUI
import SwiftData

struct HomeScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    // Use the shared NotificationManager instance to control the selected tab
    @State private var notificationManager = NotificationManager.shared
    @State private var showingAddSheet = false
    
    // Form fields for the centralized creation sheet
    @State private var newItemName = ""
    @State private var isImportant = false
    @State private var isNotifiable = false
    @State private var notificationDate = Date()
    
    var body: some View {
        NavigationStack {
            TabView(selection: Binding(
                get: { notificationManager.selectedTab },
                set: { notificationManager.selectedTab = $0 }
            )) {
                RegularListScreen()
                    .tabItem {
                        Label("Regular List", systemImage: "list.bullet")
                    }
                    .tag(0)
                 
                ImportantListScreen()
                    .tabItem {
                        Label("Important List", systemImage: "exclamationmark.circle")
                    }
                    .tag(1)
            }
            .navigationTitle(notificationManager.selectedTab == 0 ? "Regular Items" : "Important Items")
            .toolbar {
                // Centralized Add Button in the Top Bar
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingAddSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
            }
            // Centralized Add Item Sheet
            .sheet(isPresented: $showingAddSheet) {
                NavigationStack {
                    Form {
                        Section("Item Details") {
                            TextField("Item Name", text: $newItemName)
                        }
                        
                        Section("Properties") {
                            Toggle("Mark as Important", isOn: $isImportant)
                            if isImportant {
                                Toggle("Enable Notifications", isOn: $isNotifiable)
                            }
                            if isNotifiable {
                                DatePicker(
                                    "Reminder Time",
                                    selection: $notificationDate,
                                    in: Date()...,
                                    displayedComponents: [.date, .hourAndMinute]
                                )
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                    }
                    .navigationTitle("New Item")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                resetForm()
                                showingAddSheet = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                if !newItemName.trimmingCharacters(in: .whitespaces).isEmpty {
                                    let notifyTimestamp: Int64 = isNotifiable ? Int64(notificationDate.timeIntervalSince1970) : 0
                                    
                                    let newItem = Item(
                                        itemName: newItemName,
                                        isChecked: false,
                                        isImportant: isImportant,
                                        isNotifiable: isNotifiable,
                                        timestamp: Int64(Date().timeIntervalSince1970),
                                        notifyAt: notifyTimestamp
                                    )
                                    
                                    modelContext.insert(newItem)
                                    
                                    if isNotifiable {
                                        NotificationManager.shared.scheduleNotification(for: newItem)
                                    }
                                    
                                    try? modelContext.save()
                                }
                                resetForm()
                                showingAddSheet = false
                            }
                        }
                    }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
    
    private func resetForm() {
        newItemName = ""
        isImportant = false
        isNotifiable = false
        notificationDate = Date()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Item.self, configurations: config)
    
    return HomeScreen()
        .modelContainer(container)
}
