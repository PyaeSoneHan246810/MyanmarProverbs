//
//  ProverbsData.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import Foundation

struct ProverbsData: Decodable {
    enum CodingKeys: String, CodingKey {
        case proverbTitles = "Tbl_MMProverbsTitle"
        case proverbs = "Tbl_MMProverbs"
    }
    
    let proverbTitles: [ProverbsTitle]
    let proverbs: [Proverb]
}
