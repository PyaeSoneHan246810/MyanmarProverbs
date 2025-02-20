//
//  LibraryProverbsScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI
import SwiftData

struct LibraryProverbsScreenView: View {
    // MARK: - STATE PROPERTIES
    @State private var proverbs: [Proverb] = []
    @State private var error: Error?
    
    // MARK: - PROPERTIES
    let proverbTitleId: Int
    
    // MARK: - BODY
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
                ProverbsView(
                    proverbs: proverbs
                )
            }
        }
        .onAppear {
            getProverbsByTitleId()
        }
    }
    
    // MARK: - FUNCTIONS
    private func getProverbsByTitleId() {
        do {
            let proverbsData: ProverbsData = try Bundle.main.decodeJsonFile("MyanmarProverbs")
            proverbs = proverbsData.proverbs.filter({$0.titleId == proverbTitleId})
        } catch {
            if let error = error as? FileDecodingError {
                self.error = error
            }
        }
    }
    
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        LibraryProverbsScreenView(
            proverbTitleId: 1
        )
    }
}
