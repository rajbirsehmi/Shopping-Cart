//
//  EmptyScreen.swift
//  Shopping Cart
//
//  Created by Rajbir Singh Sehmi on 10/4/26.
//

import SwiftUI

struct RegularListEmptyScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("No Items Yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Your regular list is currently empty. Add some items to get started.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ImportantListEmptyScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text("All Caught Up!")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("There are no important items requiring your attention right now.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    RegularListEmptyScreen()
}

#Preview {
    ImportantListEmptyScreen()
}
