//
//  SearchScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 13/02/2025.
//

import SwiftUI

struct SearchScreenView: View {
    // MARK: - STATE PROPERTIES
    @State private var searchResultProverbs: [Proverb] = []
    @State private var searchText: String = ""
    @State private var error: Error?
    
    // MARK: - COMPUTED PROPERTIES
    private var trimmedLowercasedSearchText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            if let error {
                ErrorView(error: error)
            } else {
                VStack {
                    searchTextFieldView
                    searchContentView
                }
            }
        }
    }
    
    // MARK: - VIEW BUILDERS
    @ViewBuilder
    private var searchTextFieldView: some View {
        TextField(
            "Type your search query here...",
            text: $searchText
        )
        .textFieldStyle(.roundedBorder)
        .padding(.vertical, 4.0)
        .padding(.horizontal, 16.0)
        .onChange(of: trimmedLowercasedSearchText) {
            searchProverbs()
        }
    }
    @ViewBuilder
    private var searchContentView: some View {
        if trimmedLowercasedSearchText.isEmpty {
            initialSearchContentView
        } else if searchResultProverbs.isEmpty {
            EmptyProverbsView()
        } else {
            ProverbsView(
                proverbs: searchResultProverbs
            )
        }
    }
    @ViewBuilder
    private var initialSearchContentView: some View {
        ContentUnavailableView(
            "Search for the proverbs",
            systemImage: "text.page.badge.magnifyingglass"
        )
    }
    
    // MARK: - FUNCTIONS
    private func searchProverbs() {
        do {
            let proverbsData: ProverbsData = try Bundle.main.decodeJsonFile("MyanmarProverbs")
            searchResultProverbs = proverbsData.proverbs.filter { proverb in
                proverb.proverbName.lowercased().contains(trimmedLowercasedSearchText)
            }
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
        SearchScreenView()
            .navigationTitle("Search")
    }
}
