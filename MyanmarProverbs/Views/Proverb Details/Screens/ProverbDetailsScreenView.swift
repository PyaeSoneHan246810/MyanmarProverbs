//
//  ProverbDetailsScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI
import SwiftData
import SimpleToast

struct ProverbDetailsScreenView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var favoriteProverbs: [FavoriteProverb]
    @State private var selectedProverb: Proverb?
    @State private var error: Error?
    @State private var selection: Int = 0
    @State private var showToast: Bool = false
    let proverbs: [Proverb]
    let proverbId: Int
    var isForFavorites: Bool = false
    private var isNotFirstProverb: Bool {
        selection > 0
    }
    private var isNotLastProverb: Bool {
        selection < proverbs.count - 1
    }
    private var isProverbFavorite: Bool {
        guard let selectedProverb else {
            return false
        }
        return favoriteProverbs.contains(where: { favProverb in
            favProverb.titleId == selectedProverb.titleId && favProverb.proverbId == selectedProverb.proverbId
        })
    }
    var body: some View {
        Group {
            if let error {
                ErrorView(error: error)
            } else if proverbs.isEmpty {
                ContentUnavailableView(
                    "No Proverbs Found!",
                    systemImage: "ellipsis"
                )
            } else {
                proverbsTabView
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButtonView
            }
            ToolbarItem(placement: .topBarTrailing) {
                toggleFavoriteButtonView
            }
            ToolbarItem(placement: .topBarTrailing) {
                copyToClipboardButtonView
            }
        }
        .simpleToast(
            isPresented: $showToast,
            options: .init(
                alignment: .center,
                hideAfter: 1.0,
                modifierType: .scale
            )
        ) {
            ToastLabelView(
                message: "Copied to clipboard.",
                systemImage: "clipboard.fill",
                toastColor: Color.accentColor.opacity(0.8)
            )
        }
        .onAppear {
            getSelectedProverb()
        }
        .onChange(of: favoriteProverbs) {
            if isForFavorites && favoriteProverbs.isEmpty {
                dismiss()
            }
        }
    }
}

private extension ProverbDetailsScreenView {
    var proverbsTabView: some View {
        TabView(selection: $selection) {
            ForEach(Array(proverbs.enumerated()), id: \.element) { index, proverb in
                proverbTabItemView(proverb)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .overlay(alignment: .bottom) {
            HStack {
                Button {
                    moveToPreviousProverb()
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48.0, height: 48.0)
                }
                .disabled(!isNotFirstProverb)
                Spacer()
                Button {
                    moveToNextProverb()
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48.0, height: 48.0)
                }
                .disabled(!isNotLastProverb)
            }
            .padding(.horizontal, 20.0)
        }
    }
    func proverbTabItemView(_ proverb: Proverb) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 32.0) {
                Text(proverb.proverbName)
                    .font(.system(size: 24.0, weight: .bold, design: .rounded))
                    .foregroundStyle(.accent)
                    .lineSpacing(12.0)
                    .multilineTextAlignment(.center)
                Text(proverb.proverbDesp)
                    .font(.system(size: 16.0, weight: .regular, design: .rounded))
                    .foregroundStyle(.primary.opacity(0.75))
                    .lineSpacing(16.0)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16.0)
            .padding(.vertical, 20.0)
        }
    }
    var backButtonView: some View {
        Button {
            dismiss()
        } label: {
            Label("Back", systemImage: "chevron.left")
        }
        .buttonStyle(.borderless)
    }
    var toggleFavoriteButtonView: some View {
        Button {
            isProverbFavorite ? removeFavoriteProverb() : saveFavoriteProverb()
        } label: {
            Image(systemName: isProverbFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isProverbFavorite ? Color.accent : Color.primary)
        }
    }
    var copyToClipboardButtonView: some View {
        Button {
            copyToClipboard()
        } label: {
            Image(systemName: "clipboard")
        }
    }
}

private extension ProverbDetailsScreenView {
    func getSelectedProverb() {
        selectedProverb = proverbs.first(where: {$0.proverbId == proverbId})
        if let selectedProverb {
            selection = proverbs.firstIndex(where: {$0.proverbId == selectedProverb.proverbId}) ?? 0
        }
    }
    func moveToPreviousProverb() {
        withAnimation {
            selection -= 1
            selectedProverb = proverbs[selection]
        }
    }
    func moveToNextProverb() {
        withAnimation {
            selection += 1
            selectedProverb = proverbs[selection]
        }
    }
    func copyToClipboard() {
        let uiPasteboard = UIPasteboard.general
        uiPasteboard.string = selectedProverb?.proverbName
        if uiPasteboard.string != nil, !showToast {
            showToast = true
        }
    }
    func saveFavoriteProverb() {
        guard let proverb = selectedProverb else {
            return
        }
        let favoriteProverb = FavoriteProverb(proverb: proverb)
        modelContext.insert(favoriteProverb)
        try? modelContext.save()
    }
    func removeFavoriteProverb() {
        guard let proverb = selectedProverb else {
            return
        }
        guard let favoriteProverbToRemove = favoriteProverbs.first(where: { favProverb in
            favProverb.titleId == proverb.titleId && favProverb.proverbId == proverb.proverbId
        }) else {
            return
        }
        modelContext.delete(favoriteProverbToRemove)
        try? modelContext.save()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        ProverbDetailsScreenView(
            proverbs: Proverb.previewList(),
            proverbId: 1
        )
    }
}
