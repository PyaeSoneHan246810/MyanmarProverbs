//
//  EmptyProverbsView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 19/02/2025.
//

import SwiftUI

struct EmptyProverbsView: View {
    var body: some View {
        ContentUnavailableView(
            "No Proverbs Found!",
            systemImage: "ellipsis"
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    EmptyProverbsView()
}
