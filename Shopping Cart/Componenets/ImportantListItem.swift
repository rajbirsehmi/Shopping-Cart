//
//  ImportantListItem.swift
//  Shopping Cart
//
//  Created by Rajbir Singh Sehmi on 10/4/26.
//

import SwiftUI

struct ImportantListItem: View {
    var item: Item
    var onToggle: () -> Void
    var onToggleNotification: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.15))
                    .frame(width: 36, height: 36)
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                    .font(.subheadline)
            }
            
            Text(item.itemName)
                .strikethrough(item.isChecked, color: .secondary)
                .foregroundColor(item.isChecked ? .secondary : .primary)
                .font(.body)
                .fontWeight(.medium)
            
            Spacer()
            
            if let onToggleNotification = onToggleNotification {
                Button(action: onToggleNotification) {
                    Image(systemName: item.isNotifiable ? "bell.fill" : "bell.slash.fill")
                        .foregroundColor(item.isNotifiable ? .blue : .secondary.opacity(0.5))
                        .font(.subheadline)
                        .padding(8)
                        .background(Color.secondary.opacity(0.1))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
            
            Button(action: onToggle) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(item.isChecked ? .orange : .secondary)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
        )
        .animation(.snappy, value: item.isChecked)
    }
}

#Preview {
    ImportantListItem(
        item: Item(
            itemName: "Organic Coffee Beans",
            isChecked: false,
            isImportant: true,
            isNotifiable: true,
            timestamp: Int64(Date().timeIntervalSince1970)
        ),
        onToggle: {},
        onToggleNotification: {}
    )
    .padding()
}
