//
//  RecentScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI
import SwiftData

struct RecentScreenView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - QUERY PROPERTIES
    @Query(
        sort: \RecentProverb.viewedAt,
        order: .reverse
    )
    private var recentProverbs: [RecentProverb]
    
    // MARK: - PROPERTIES
    private var recentProverbsForDisplay: [Proverb] {
        return recentProverbs.map { recProverb in
            Proverb.fromRecentProverb(recProverb)
        }
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            if recentProverbsForDisplay.isEmpty {
                ContentUnavailableView(
                    "Empty Recent Proverbs",
                    systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90",
                    description: Text("Your recently viewed proverbs will appear here!")
                )
            } else {
                ProverbsView(
                    proverbs: recentProverbsForDisplay
                )
            }
        }
        .onAppear {
            deleteOldRecentProverbs()
        }
    }
    
    // MARK: - FUNCTIONS
    private func deleteOldRecentProverbs() {
        let fiveDaysAgoDate = Calendar.current.date(byAdding: .day, value: -7, to: .now)
        guard let fiveDaysAgoDate else { return }
        for recentProverb in recentProverbs {
            if recentProverb.viewedAt < fiveDaysAgoDate {
                modelContext.delete(recentProverb)
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        RecentScreenView()
            .navigationTitle("Recent")
    }
}
