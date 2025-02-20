//
//  ProverbsTitle.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import Foundation

struct ProverbsTitle: Identifiable, Decodable, Hashable {
    enum CodingKeys: String, CodingKey {
        case titleId = "TitleId"
        case titleName = "TitleName"
    }
    
    let titleId: Int
    let titleName: String
    
    var id: Int {
        titleId
    }
}
