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
        HStack(spacing: 16) {
            Text(item.itemName)
                .strikethrough(item.isChecked, color: .secondary)
                .foregroundColor(item.isChecked ? .secondary : .primary)
                .font(.body)
                .fontWeight(.medium)
                .animation(.easeInOut(duration: 0.2), value: item.isChecked)
            
            Spacer()
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    onToggle()
                }
            }) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(item.isChecked ? .blue : .secondary.opacity(0.6))
                    .scaleEffect(item.isChecked ? 1.1 : 1.0)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(item.isChecked ? 0.01 : 0.04), radius: 8, x: 0, y: 3)
        )
        .scaleEffect(item.isChecked ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: item.isChecked)
    }
}
