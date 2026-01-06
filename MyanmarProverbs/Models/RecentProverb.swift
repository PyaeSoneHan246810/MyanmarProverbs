//
//  RecentProverb.swift
//  MyanmarProverbs
//
//  Created by Dylan on 17/02/2025.
//

import Foundation
import SwiftData

@Model
class RecentProverb {
    var titleId: Int = 0
    var proverbId: Int = 0
    var proverbName: String = ""
    var proverbDesp: String = ""
    var viewedAt: Date = Date()
    
    init(titleId: Int, proverbId: Int, proverbName: String, proverbDesp: String, viewedAt: Date) {
        self.titleId = titleId
        self.proverbId = proverbId
        self.proverbName = proverbName
        self.proverbDesp = proverbDesp
        self.viewedAt = viewedAt
    }
    
    init(proverb: Proverb) {
        self.titleId = proverb.titleId
        self.proverbId = proverb.proverbId
        self.proverbName = proverb.proverbName
        self.proverbDesp = proverb.proverbDesp
        self.viewedAt = .now
    }
}
