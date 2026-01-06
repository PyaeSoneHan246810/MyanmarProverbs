//
//  FavoriteProverb.swift
//  MyanmarProverbs
//
//  Created by Dylan on 15/02/2025.
//

import Foundation
import SwiftData

@Model
class FavoriteProverb {
    var titleId: Int = 0
    var proverbId: Int = 0
    var proverbName: String = ""
    var proverbDesp: String = ""
    
    init(titleId: Int, proverbId: Int, proverbName: String, proverbDesp: String) {
        self.titleId = titleId
        self.proverbId = proverbId
        self.proverbName = proverbName
        self.proverbDesp = proverbDesp
    }
    
    init(proverb: Proverb) {
        self.titleId = proverb.titleId
        self.proverbId = proverb.proverbId
        self.proverbName = proverb.proverbName
        self.proverbDesp = proverb.proverbDesp
    }
}
