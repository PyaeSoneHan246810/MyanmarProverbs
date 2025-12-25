//
//  TabsScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI

struct TabsScreenView: View {
    var body: some View {
        TabView {
            Tab(
                "Home",
                systemImage: "house.fill"
            ) {
                NavigationStack {
                    HomeScreenView()
                }
            }
            Tab(
                "Library",
                systemImage: "square.grid.2x2"
            ) {
                NavigationStack {
                    LibraryScreenView()
                }
            }
            Tab(
                "Recent",
                systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90"
            ) {
                NavigationStack {
                    RecentScreenView()
                }
            }
            Tab(
                "Favorites",
                systemImage: "heart"
            ) {
                NavigationStack {
                    FavoritesScreenView()
                }
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TabsScreenView()
}

#Preview(traits: .sizeThatFitsLayout) {
    TabsScreenView()
    .environment(\.locale, Locale(identifier: "my-MM"))
}
