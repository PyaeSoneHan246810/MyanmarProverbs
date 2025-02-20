//
//  HomeScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import SwiftUI
import SwiftData
import SimpleToast

struct HomeScreenView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - APP STORAGE PROPERTIES
    @AppStorage("localeIdentifier") private var localeIdentifier = "en"
    
    // MARK: - QUERY PROPERTIES
    @Query private var favoriteProverbs: [FavoriteProverb]
    
    // MARK: - STATE PROPERTIES
    @State private var allProverbs: [Proverb] = []
    @State private var randomProverb: Proverb?
    @State private var showToast: Bool = false
    @State private var error: Error?
    @State private var isSearchScreenPresented: Bool = false
    @State private var isAboutAppScreenPresented: Bool = false
    @State private var selectedLanguage: Language = .english
    
    // MARK: - COMPUTED PROPERTIES
    private var isRandomProverbFavorite: Bool {
        guard let randomProverb else {
            return false
        }
        return favoriteProverbs.contains(where: { favProverb in
            favProverb.titleId == randomProverb.titleId && favProverb.proverbId == randomProverb.proverbId
        })
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            if let error {
                ErrorView(error: error)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        randomProverbView()
                    }
                    .padding(.horizontal, 16.0)
                    .padding(.vertical, 20.0)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Search", systemImage: "magnifyingglass") {
                    isSearchScreenPresented = true
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("About", systemImage: "info.square") {
                    isAboutAppScreenPresented = true
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                languageSelectionMenuView()
            }
        }
        .simpleToast(
            isPresented: $showToast,
            options: .init(
                alignment: .center,
                hideAfter: 1.0,
                modifierType: .scale
            )
        ) {
            ToastLabelView(
                message: "Copied to clipboard.",
                systemImage: "clipboard.fill",
                toastColor: Color.accentColor.opacity(0.8)
            )
        }
        .sheet(isPresented: $isSearchScreenPresented) {
            NavigationStack {
                SearchScreenView()
                    .navigationTitle("Search")
            }
        }
        .sheet(isPresented: $isAboutAppScreenPresented) {
            NavigationStack {
                AboutScreenView()
            }
        }
        .onAppear {
            getAllProverbs()
            getRandomProverb()
            getSelectedLanguage()
        }
        .onChange(of: selectedLanguage) {
            setLanguage()
        }
    }
    
    // MARK: - VIEW BUILDERS
    @ViewBuilder
    private func randomProverbView() -> some View {
        VStack(alignment: .leading, spacing: 20.0) {
            HStack {
                Label(
                    "Random Proverb",
                    systemImage: "quote.bubble.fill"
                )
                .font(.headline)
                .fontWeight(.medium)
                Spacer()
                Button {
                    withAnimation(.spring) {
                        getRandomProverb()
                    }
                } label: {
                    Image(systemName: "shuffle.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32.0, height: 32.0)
                }
            }
            if let randomProverb {
                VStack(alignment: .leading, spacing: 32.0) {
                    Text(randomProverb.proverbName)
                        .font(.system(size: 32.0, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            .linearGradient(colors: [.yellow, .accent, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .lineSpacing(24.0)
                        .multilineTextAlignment(.leading)
                    Text(randomProverb.proverbDesp)
                        .font(.system(size: 16.0, weight: .regular, design: .rounded))
                        .foregroundStyle(.primary.opacity(0.75))
                        .lineSpacing(16.0)
                        .multilineTextAlignment(.leading)
                }
            } else {
                Text("Unavailable!")
                    .font(.subheadline)
            }
            HStack(spacing: 16.0) {
                Button {
                    isRandomProverbFavorite ? removeFavoriteProverb() : saveFavoriteProverb()
                } label: {
                    Image(systemName: isRandomProverbFavorite ? "heart.fill" : "heart")
                        .imageScale(.large)
                }
                Button {
                    copyToClipboard()
                } label: {
                    Image(systemName: "clipboard")
                        .imageScale(.large)
                }
            }
        }
    }
    @ViewBuilder
    private func languageSelectionMenuView() -> some View {
        Menu("Language", systemImage: "translate") {
            Picker("Language", selection: $selectedLanguage) {
                ForEach(Language.allCases) { language in
                    Text(language.rawValue)
                        .tag(language)
                }
            }
        }
    }
    
    // MARK: - FUNCTIONS
    private func getAllProverbs() {
        do {
            let proverbsData: ProverbsData = try Bundle.main.decodeJsonFile("MyanmarProverbs")
            allProverbs = proverbsData.proverbs
        } catch {
            if let error = error as? FileDecodingError {
                self.error = error
            }
        }
    }
    private func getRandomProverb() {
        randomProverb = allProverbs.randomElement()
    }
    private func copyToClipboard() {
        let uiPasteboard = UIPasteboard.general
        uiPasteboard.string = randomProverb?.proverbName
        if uiPasteboard.string != nil, !showToast {
            showToast = true
        }
    }
    private func saveFavoriteProverb() {
        guard let randomProverb else { return }
        let favoriteProverb = FavoriteProverb(proverb: randomProverb)
        modelContext.insert(favoriteProverb)
    }
    private func removeFavoriteProverb() {
        guard let randomProverb else { return }
        guard let favoriteProverbToRemove = favoriteProverbs.first(where: { favProverb in
            favProverb.titleId == randomProverb.titleId && favProverb.proverbId == randomProverb.proverbId
        }) else {
            return
        }
        modelContext.delete(favoriteProverbToRemove)
    }
    private func getSelectedLanguage() {
        selectedLanguage = Language.allCases.first(where: { $0.localeIdentifier == localeIdentifier}) ?? .english
    }
    private func setLanguage() {
        switch selectedLanguage {
        case .english:
            localeIdentifier = selectedLanguage.localeIdentifier
        case .burmese:
            localeIdentifier = selectedLanguage.localeIdentifier
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        HomeScreenView()
            .navigationTitle("Home")
    }
    .modelContainer(for: FavoriteProverb.self, inMemory: true)
}
