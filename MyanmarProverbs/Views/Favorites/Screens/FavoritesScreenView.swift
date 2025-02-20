//
//  FavoritesScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI
import SwiftData

struct FavoritesScreenView: View {
    // MARK: - QUERY PROPERTIES
    @Query private var favoriteProverbs: [FavoriteProverb]
    
    // MARK: - COMPUTED PROPERTIES
    private var favoriteProverbsForDisplay: [Proverb] {
        return favoriteProverbs.map { favProverb in
            Proverb.fromFavoriteProverb(favProverb)
        }.sorted(by: { $0.proverbName < $1.proverbName})
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            if favoriteProverbsForDisplay.isEmpty {
                ContentUnavailableView(
                    "Empty Favorites",
                    systemImage: "heart.text.square.fill",
                    description: Text("Your favorite proverbs will appear here once you add some!")
                )
            } else {
                ProverbsView(
                    proverbs: favoriteProverbsForDisplay,
                    isForFavorites: true
                )
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        FavoritesScreenView()
            .navigationTitle("Favorites")
    }
}
