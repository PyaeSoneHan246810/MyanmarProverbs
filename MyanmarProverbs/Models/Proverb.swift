//
//  Proverb.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import Foundation

struct Proverb: Identifiable, Decodable, Hashable {
    enum CodingKeys: String, CodingKey {
        case titleId = "TitleId"
        case proverbId = "ProverbId"
        case proverbName = "ProverbName"
        case proverbDesp = "ProverbDesp"
    }
    
    let titleId: Int
    let proverbId: Int
    let proverbName: String
    let proverbDesp: String
    
    var id: String {
        proverbName
    }
}

extension Proverb {
    static func fromFavoriteProverb(_ favoriteProverb: FavoriteProverb) -> Proverb {
        Proverb(
            titleId: favoriteProverb.titleId,
            proverbId: favoriteProverb.proverbId,
            proverbName: favoriteProverb.proverbName,
            proverbDesp: favoriteProverb.proverbDesp
        )
    }
    static func fromRecentProverb(_ recentProverb: RecentProverb) -> Proverb {
        Proverb(
            titleId: recentProverb.titleId,
            proverbId: recentProverb.proverbId,
            proverbName: recentProverb.proverbName,
            proverbDesp: recentProverb.proverbDesp
        )
    }
}
