//
//  RegularListItem.swift
//  Shopping Cart
//
//  Created by Rajbir Singh Sehmi on 10/4/26.
//

import SwiftUI

struct RegularListItem: View {
    var item: Item
    var onToggle: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            Spacer()
                .frame(width: 0, height: 36)
                .hidden()
            
            Text(item.itemName)
                .strikethrough(item.isChecked, color: .secondary)
                .foregroundColor(item.isChecked ? .secondary : .primary)
                .font(.body)
                .fontWeight(.medium)
            
            Spacer()
            
            Button(action: onToggle) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(item.isChecked ? .blue : .secondary)
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
    RegularListItem(
        item: Item(itemName: "Milk", isChecked: false, isImportant: false, isNotifiable: false, timestamp: Int64(Date().timeIntervalSince1970)),
        onToggle: {}
    )
    .padding()
}
