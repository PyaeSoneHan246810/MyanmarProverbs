//
//  TabsScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI

struct TabsScreenView: View {
    // MARK: - PROPERTIES
    // MARK: - BODY
    var body: some View {
        TabView {
            Tab(
                "Home",
                systemImage: "house.fill"
            ) {
                NavigationStack {
                    HomeScreenView()
                        .navigationTitle("Home")
                }
            }
            Tab(
                "Library",
                systemImage: "square.grid.2x2"
            ) {
                NavigationStack {
                    LibraryScreenView()
                        .navigationTitle("Library")
                }
            }
            Tab(
                "Recent",
                systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90"
            ) {
                NavigationStack {
                    RecentScreenView()
                        .navigationTitle("Recent")
                }
            }
            Tab(
                "Favorites",
                systemImage: "heart"
            ) {
                NavigationStack {
                    FavoritesScreenView()
                        .navigationTitle("Favorites")
                }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    TabsScreenView()
}

#Preview(traits: .sizeThatFitsLayout) {
    TabsScreenView()
    .environment(\.locale, Locale(identifier: "my-MM"))
}
