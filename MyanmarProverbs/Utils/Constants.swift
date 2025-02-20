//
//  Constants.swift
//  MyanmarProverbs
//
//  Created by Dylan on 19/02/2025.
//

import Foundation

struct Constants {
    static let appDisplayName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "Unknown"
    static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
}
