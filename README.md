# Shopping Cart 🛒

A modern, sleek, and intuitive iOS shopping list application built using **SwiftUI** and **SwiftData**. Designed with clean card layouts, dynamic dark/light mode adaptivity, micro-interactions, and prioritized item tracking with local reminders.

---

## ✨ Features

- **Dual-List Management**: Effortlessly switch between your **Regular** everyday shopping items and **Important** priority items via a responsive navigation layout.
- **Smart Reminders**: Attach date and time alerts to priority items leveraging local push notifications so you never forget crucial purchases.
- **SwiftData Persistence**: Built on Apple's latest persistence framework for seamless offline data synchronization and swift queries.
- **Polished UI & Animations**: Custom elevated card components, dynamic haptics, spring animations, and informative empty state screens.
- **Full Theme Support**: Flawless compatibility across both Light Mode and Dark Mode environments.

---

## 📁 Project Structure

```text
Shopping Cart/
├── App/
│   ├── Shopping_CartApp.swift       # Application entry point & ModelContainer setup
│   └── HomeScreen.swift             # Main tab navigation & centralized item creation modal
├── Features/
│   ├── Important/
│   │   ├── ImportantListScreen.swift
│   │   └── ImportantListViewModel.swift
│   └── Regular/
│       ├── RegularListScreen.swift
│       └── RegularListViewModel.swift
├── Models/
│   └── Item.swift                   # SwiftData Item schema
├── Componenets/
│   ├── RegularListItem.swift        # Card view for standard items
│   ├── ImportantListItem.swift      # Card view for high-priority items with notification indicators
│   └── EmptyScreen.swift            # Styled placeholder states for empty lists
└── Utils/
    └── NotificationManager.swift    # UserNotifications wrapper for scheduling reminders
```

---

## 🛠 Tech Stack & Requirements

- **Language**: Swift 5.9+
- **Framework**: SwiftUI
- **Persistence**: SwiftData
- **Notifications**: UserNotifications Framework
- **Minimum iOS Version**: iOS 17.0+
- **IDE**: Xcode 15.0+

---

## 🚀 Getting Started

1. Clone or download the repository into your local environment.
2. Open `Shopping Cart.xcodeproj` using **Xcode**.
3. Select an iOS 17+ Simulator or a connected physical device.
4. Press `⌘ + R` (Build & Run) to start exploring the app.

---

## 💡 Usage

- **Add Item**: Tap the blue/orange **`+`** button in the top navigation bar.
- **Mark Priority**: Toggle "Mark as Important" during item creation to send it to the Important list.
- **Set Reminders**: Enable "Enable Reminder" on important items to pick a specific date and time for notifications.
- **Check Off**: Tap the checkbox on any item to mark it as completed.
