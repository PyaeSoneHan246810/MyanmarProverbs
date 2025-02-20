//
//  Language.swift
//  MyanmarProverbs
//
//  Created by Dylan on 19/02/2025.
//

import Foundation

enum Language: String, CaseIterable, Identifiable {
    case english = "English"
    case burmese = "Burmese"
    var localeIdentifier: String {
        switch self {
        case .english:
            return "en"
        case .burmese:
            return "my-MM"
        }
    }
    var id: String {
        self.localeIdentifier
    }
}
