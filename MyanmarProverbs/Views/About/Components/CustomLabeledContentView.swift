//
//  CustomLabeledContentView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 19/02/2025.
//

import SwiftUI

struct CustomLabeledContentView: View {
    let labelText: String
    let labelSystemImage: String
    let contentText: String
    var body: some View {
        LabeledContent {
            contentView
        } label: {
            labelView
        }
    }
    private var labelView: some View {
        HStack(spacing: 12.0) {
            RoundedRectangle(cornerRadius: 8.0)
                .frame(width: 32.0, height: 32.0)
                .foregroundStyle(.accent)
                .overlay(alignment: .center) {
                    Image(systemName: labelSystemImage)
                        .foregroundStyle(.white.opacity(0.85))
                }
            Text(labelText)
                .font(.subheadline)
                .fontWeight(.semibold)
                .opacity(0.75)
        }
    }
    private var contentView: some View {
        Text(contentText)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
            .opacity(0.85)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CustomLabeledContentView(
        labelText: "Developer",
        labelSystemImage: "ellipsis.curlybraces",
        contentText: "Pyae Sone Han"
    )
}
