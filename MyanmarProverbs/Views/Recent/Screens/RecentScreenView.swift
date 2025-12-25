//
//  RecentScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI
import SwiftData

struct RecentScreenView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(
        sort: \RecentProverb.viewedAt,
        order: .reverse
    )
    private var recentProverbs: [RecentProverb]
    private var recentProverbsForDisplay: [Proverb] {
        return recentProverbs.map { recProverb in
            Proverb.fromRecentProverb(recProverb)
        }
    }
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .title) {
                Text("Recent")
                    .font(.headline)
            }
        }
        .onAppear {
            deleteOldRecentProverbs()
        }
    }
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

#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        RecentScreenView()
    }
}
