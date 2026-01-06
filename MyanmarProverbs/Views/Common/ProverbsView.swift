//
//  ProverbsView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI
import SwiftData
import SimpleToast

struct ProverbsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteProverbs: [FavoriteProverb]
    @Query private var recentProverbs: [RecentProverb]
    @State private var showtoast: Bool = false
    @State private var toastMessage: String?
    @State private var proverbsForDisplay: [Proverb] = []
    let proverbs: [Proverb]
    var isForFavorites: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16.0) {
                ForEach(proverbsForDisplay) { proverb in
                    NavigationLink(value: proverb) {
                        ProverbItemView(
                            proverb: proverb,
                            isFavorite: isFavorite(proverb),
                            onFavButtonTapped: {
                                isFavorite(proverb) ? removeFavoriteProverb(proverb) : saveFavoriteProverb(proverb)
                            },
                            onCopyButtonTapped: {
                                copyToClipboard(proverb)
                            }
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(16.0)
        }
        .simpleToast(
            isPresented: $showtoast,
            options: .init(
                alignment: .bottom,
                hideAfter: 1.0,
                modifierType: .scale
            )
        ) {
            ToastLabelView(
                message: toastMessage ?? "",
                systemImage: "clipboard.fill",
                toastColor: Color.accentColor.opacity(0.8)
            )
        }
        .onAppear {
            proverbsForDisplay = proverbs
        }
        .navigationDestination(for: Proverb.self) { proverb in
            ProverbDetailsScreenView(
                proverbs: proverbsForDisplay,
                proverbId: proverb.proverbId,
                isForFavorites: isForFavorites
            )
            .onAppear {
                upsertRecentProverb(proverb)
            }
        }
    }
    
}

private extension ProverbsView {
    func isFavorite(_ proverb: Proverb) -> Bool {
        favoriteProverbs.contains(where: { favProverb in
            favProverb.titleId == proverb.titleId && favProverb.proverbId == proverb.proverbId
        })
    }
    func saveFavoriteProverb(_ proverb: Proverb) {
        let favoriteProverb = FavoriteProverb(proverb: proverb)
        modelContext.insert(favoriteProverb)
        try? modelContext.save()
    }
    func removeFavoriteProverb(_ proverb: Proverb) {
        guard let favoriteProverbToRemove = favoriteProverbs.first(where: { favProverb in
            favProverb.titleId == proverb.titleId && favProverb.proverbId == proverb.proverbId
        }) else {
            return
        }
        modelContext.delete(favoriteProverbToRemove)
        try? modelContext.save()
    }
    func copyToClipboard(_ proverb: Proverb) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = proverb.proverbName
        if let copiedProverbName = pasteboard.string, !showtoast {
            showtoast = true
            toastMessage = copiedProverbName
        }
    }
    func upsertRecentProverb(_ proverb: Proverb) {
        if let existingProverb = recentProverbs.first(where: { recProverb in
            recProverb.titleId == proverb.titleId && recProverb.proverbId == proverb.proverbId
        }) {
            existingProverb.viewedAt = .now
        } else {
            let recentProverb = RecentProverb(proverb: proverb)
            modelContext.insert(recentProverb)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        ProverbsView(
            proverbs: Proverb.previewList()
        )
    }
}
