//
//  ErrorView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 14/02/2025.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    var body: some View {
        ContentUnavailableView(
            "Error has occurred!",
            systemImage: "exclamationmark.triangle.fill",
            description: Text(error.localizedDescription)
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ErrorView(
        error: FileDecodingError.decodingFailed
    )
}
