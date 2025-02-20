//
//  EmptyProverbsView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 19/02/2025.
//

import SwiftUI

struct EmptyProverbsView: View {
    // MARK: - PROPERTIES
    // MARK: - BODY
    var body: some View {
        ContentUnavailableView(
            "No Proverbs Found!",
            systemImage: "ellipsis"
        )
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    EmptyProverbsView()
}
