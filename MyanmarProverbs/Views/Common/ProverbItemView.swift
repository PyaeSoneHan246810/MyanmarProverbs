//
//  ProverbItemView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI

struct ProverbItemView: View {
    let proverb: Proverb
    let isFavorite: Bool
    let onFavButtonTapped: () -> Void
    let onCopyButtonTapped: () -> Void
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 20.0) {
                proverbNameView
                buttonsView
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 4.0)
        }
        .clipShape(.rect(cornerRadius: 12.0))
    }
}

private extension ProverbItemView {
    var proverbNameView: some View {
        Text(proverb.proverbName)
            .font(.system(size: 16.0, weight: .semibold, design: .rounded))
            .multilineTextAlignment(.leading)
            .lineSpacing(8.0)
            .opacity(0.75)
    }
    var buttonsView: some View {
        HStack(spacing: 16.0) {
            Button(action: onFavButtonTapped) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .imageScale(.large)
            }
            .tint(isFavorite ? Color.accentColor : Color.secondary)
            Button(action: onCopyButtonTapped) {
                Image(systemName: "clipboard")
                    .imageScale(.large)
            }
            .tint(.secondary)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ProverbItemView(
        proverb: Proverb.preview,
        isFavorite: false,
        onFavButtonTapped: {},
        onCopyButtonTapped: {}
    )
}
