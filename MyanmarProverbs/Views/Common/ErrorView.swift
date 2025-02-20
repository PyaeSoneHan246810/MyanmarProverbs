//
//  ErrorView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 14/02/2025.
//

import SwiftUI

struct ErrorView: View {
    // MARK: - PROPERTIES
    let error: Error
    
    // MARK: - BODY
    var body: some View {
        ContentUnavailableView(
            "Error has occurred!",
            systemImage: "exclamationmark.triangle.fill",
            description: Text(error.localizedDescription)
        )
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    ErrorView(
        error: FileDecodingError.decodingFailed
    )
}
