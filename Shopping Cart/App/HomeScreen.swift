import SwiftUI
import SwiftData

struct HomeScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var notificationManager = NotificationManager.shared
    @State private var showingAddSheet = false
    
    // Form fields for centralized creation sheet
    @State private var newItemName = ""
    @State private var isImportant = false
    @State private var isNotifiable = false
    @State private var notificationDate = Date()
    
    var body: some View {
        NavigationStack {
            TabView(selection: Binding(
                get: { notificationManager.selectedTab },
                set: { newValue in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        notificationManager.selectedTab = newValue
                    }
                }
            )) {
                RegularListScreen()
                    .tabItem {
                        Label("Regular", systemImage: "list.bullet.circle.fill")
                    }
                    .tag(0)
                 
                ImportantListScreen()
                    .tabItem {
                        Label("Important", systemImage: "exclamationmark.circle.fill")
                    }
                    .tag(1)
            }
            .accentColor(notificationManager.selectedTab == 0 ? .blue : .orange)
            .navigationTitle(notificationManager.selectedTab == 0 ? "Shopping List" : "Priority Items")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            showingAddSheet = true
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(
                                Circle()
                                    .fill(notificationManager.selectedTab == 0 ? Color.blue : Color.orange)
                            )
                    }
                }
            }
            // Add Item Sheet
            .sheet(isPresented: $showingAddSheet) {
                NavigationStack {
                    Form {
                        Section {
                            TextField("What do you need?", text: $newItemName)
                                .font(.body)
                                .padding(.vertical, 4)
                        } header: {
                            Text("Item Details")
                        }
                        
                        Section {
                            Toggle(isOn: $isImportant) {
                                Label("Mark as Important", systemImage: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                            }
                            
                            if isImportant {
                                Toggle(isOn: $isNotifiable) {
                                    Label("Enable Reminder", systemImage: "bell.fill")
                                        .foregroundColor(.blue)
                                }
                                .transition(.opacity.combined(with: .move(edge: .top)))
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
                        } header: {
                            Text("Configuration")
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
                            .foregroundColor(.secondary)
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
                            .fontWeight(.bold)
                            .disabled(newItemName.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                    }
                }
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(24)
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
