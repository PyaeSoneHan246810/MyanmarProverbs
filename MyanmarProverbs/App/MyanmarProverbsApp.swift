//
//  MyanmarProverbsApp.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI

@main
struct MyanmarProverbsApp: App {
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FavoriteProverb.self, RecentProverb.self])
    }
}
