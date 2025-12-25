//
//  MyanmarProverbsApp.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI

@main
struct MyanmarProverbsApp: App {
    @AppStorage("localeIdentifier") private var localeIdentifier = "en"
    var body: some Scene {
        WindowGroup {
            TabsScreenView()
        }
        .environment(\.locale, Locale(identifier: localeIdentifier))
        .modelContainer(for: [FavoriteProverb.self, RecentProverb.self])
    }
}
