//
//  ToastLabelView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI

struct ToastLabelView: View {
    // MARK: - PROPERTIES
    let message: String
    let systemImage: String
    let toastColor: Color
    // MARK: - BODY
    var body: some View {
        Label(
            message,
            systemImage: systemImage
        )
        .font(.system(size: 14.0, weight: .medium, design: .rounded))
        .lineSpacing(8.0)
        .padding(.vertical, 12.0)
        .padding(.horizontal, 16.0)
        .foregroundColor(Color.white)
        .background(toastColor)
        .cornerRadius(12.0)
        .padding(12.0)
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    ToastLabelView(
        message: "Copied",
        systemImage: "clipboard.fill",
        toastColor: Color.accentColor.opacity(0.8)
    )
}
