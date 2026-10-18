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
                    .fill(Color.orange.opacity(0.12))
                    .frame(width: 38, height: 38)
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                    .font(.subheadline)
            }
            
            Text(item.itemName)
                .strikethrough(item.isChecked, color: .secondary)
                .foregroundColor(item.isChecked ? .secondary : .primary)
                .font(.body)
                .fontWeight(.semibold)
                .animation(.easeInOut(duration: 0.2), value: item.isChecked)
            
            Spacer()
            
            if let onToggleNotification = onToggleNotification {
                Button(action: onToggleNotification) {
                    Image(systemName: item.isNotifiable ? "bell.fill" : "bell.slash.fill")
                        .foregroundColor(item.isNotifiable ? .orange : .secondary.opacity(0.4))
                        .font(.system(size: 14))
                        .padding(10)
                        .background(Color.orange.opacity(item.isNotifiable ? 0.12 : 0.05))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    onToggle()
                }
            }) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(item.isChecked ? .orange : .secondary.opacity(0.6))
                    .scaleEffect(item.isChecked ? 1.1 : 1.0)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(item.isChecked ? 0.01 : 0.04), radius: 8, x: 0, y: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(item.isChecked ? Color.clear : Color.orange.opacity(0.2), lineWidth: 1)
                )
        )
        .scaleEffect(item.isChecked ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: item.isChecked)
    }
}
