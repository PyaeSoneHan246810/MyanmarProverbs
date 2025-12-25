//
//  AboutScreenView.swift
//  MyanmarProverbs
//
//  Created by Dylan on 19/02/2025.
//

import SwiftUI

struct AboutScreenView: View {
    var body: some View {
        List {
            Section {
                appInfoSectionView
            }
            Section {
                appResourcesSectionView
            }
            Section(
                header: Text("About this app")
            ) {
                aboutThisAppSectionView
            }
            Section(
                header: Text("About your device")
            ) {
                aboutYourDeviceSectionView
            }
            Section(
                footer: HStack {
                    Spacer()
                    Text("© 2025 Pyae Sone Han. All rights reserved.")
                    Spacer()
                }
            ) {
                developedWithLoveSectionView
            }
        }
        .navigationTitle("About")
    }
}

private extension AboutScreenView {
    var appInfoSectionView: some View {
        VStack(alignment: .center, spacing: 12.0) {
            Image(.myanmarFlag)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
            Text(Constants.appDisplayName)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(
                    .linearGradient(colors: [.yellow, .accent, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            Text(
                "The Myanmar Proverbs App brings you a collection of timeless proverbs passed down through generations. These proverbs offer wisdom, guidance, and inspiration for everyday life. Whether you seek advice, motivation, or a moment of reflection, this app provides meaningful sayings at your fingertips"
            )
            .font(.callout)
            .lineSpacing(4.0)
            .opacity(0.85)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    var appResourcesSectionView: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Text(
                "The proverbs featured in this app are sourced from Dr. Win Thein's website. You may visit the link below."
            )
            .font(.callout)
            .lineSpacing(4.0)
            .opacity(0.85)
            if let url = URL(string: "https://www.mmproverbs.pro/") {
                Link("mmproverbs.pro", destination: url)
                    .font(.headline)
            }
        }
    }
    var aboutThisAppSectionView: some View {
        VStack(spacing: 12.0) {
            CustomLabeledContentView(
                labelText: "Application",
                labelSystemImage: "iphone",
                contentText: Constants.appDisplayName
            )
            CustomLabeledContentView(
                labelText: "Version",
                labelSystemImage: "gear",
                contentText: Constants.appVersion
            )
            CustomLabeledContentView(
                labelText: "Compatibility",
                labelSystemImage: "info.circle.fill",
                contentText: "iOS 18.0 or later"
            )
            CustomLabeledContentView(
                labelText: "Developer",
                labelSystemImage: "ellipsis.curlybraces",
                contentText: "Pyae Sone Han"
            )
            CustomLabeledContentView(
                labelText: "Designer",
                labelSystemImage: "paintpalette.fill",
                contentText: "Pyae Sone Han"
            )
            CustomLabeledContentView(
                labelText: "Technology",
                labelSystemImage: "swift",
                contentText: "SwiftUI"
            )
        }
    }
    var aboutYourDeviceSectionView: some View {
        VStack(spacing: 12.0) {
            CustomLabeledContentView(
                labelText: "Device Name",
                labelSystemImage: "iphone",
                contentText: UIDevice.current.name
            )
            CustomLabeledContentView(
                labelText: "System Name",
                labelSystemImage: "apple.logo",
                contentText: UIDevice.current.systemName
            )
            CustomLabeledContentView(
                labelText: "System Version",
                labelSystemImage: "gear",
                contentText: UIDevice.current.systemVersion
            )
        }
    }
    var developedWithLoveSectionView: some View {
        HStack {
            Spacer()
            Text("Developed with ❤️ by Pyae Sone Han")
                .font(.subheadline)
                .opacity(0.85)
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        AboutScreenView()
    }
}
