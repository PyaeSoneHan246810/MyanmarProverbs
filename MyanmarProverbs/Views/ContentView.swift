//
//  ContentView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("localeIdentifier") private var localeIdentifier = "en"
    // MARK: - BODY
    var body: some View {
        TabsScreenView()
            .environment(\.locale, Locale(identifier: localeIdentifier))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [FavoriteProverb.self, RecentProverb.self], inMemory: true)
}
