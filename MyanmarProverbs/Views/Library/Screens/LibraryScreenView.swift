//
//  LibraryScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI

struct LibraryScreenView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var proverbsTitles: [ProverbsTitle] = []
    @State private var error: Error?
    private var isLightMode: Bool {
        colorScheme == .light
    }
    var body: some View {
        Group {
            if let error {
                ErrorView(error: error)
            } else {
                proverbsTitlesView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .title) {
                Text("Library")
                    .font(.headline)
            }
        }
        .onAppear {
            getProverbsTitles()
        }
        .navigationDestination(for: ProverbsTitle.self) { proverbsTitle in
            LibraryProverbsScreenView(
                proverbTitleId: proverbsTitle.titleId
            )
        }
    }
    private func getProverbsTitles() {
        do {
            let proverbsData: ProverbsData = try Bundle.main.decodeJsonFile("MyanmarProverbs")
            proverbsTitles = proverbsData.proverbTitles
        } catch {
            if let error = error as? FileDecodingError {
                self.error = error
            }
        }
    }
}

private extension LibraryScreenView {
    var proverbsTitlesView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(
                columns: [
                    GridItem(
                        .adaptive(minimum: 160.0),
                        spacing: 16.0,
                        alignment: .center
                    )
                ],
                alignment: .center,
                spacing: 16.0
            ) {
                ForEach(proverbsTitles) { proverbsTitle in
                    NavigationLink(value: proverbsTitle) {
                        proverbsTitleItemView(proverbsTitle)
                    }
                }
            }
            .padding(16.0)
        }
    }
    func proverbsTitleItemView(_ proverbsTitle: ProverbsTitle) -> some View {
        RoundedRectangle(
            cornerRadius: 16.0
        )
        .fill(
            Color(uiColor: isLightMode ? .systemBackground : .systemGray6)
        )
        .frame(maxWidth: .infinity, minHeight: 160.0, maxHeight: 160.0)
        .shadow(radius: 1.6, x: 0.0, y: 1.0)
        .overlay {
            Text(proverbsTitle.titleName)
                .font(.system(size: 36.0, weight: .bold, design: .rounded))
                .foregroundStyle(
                    isLightMode ? .black : .white
                )
                .opacity(0.75)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        LibraryScreenView()
    }
}
