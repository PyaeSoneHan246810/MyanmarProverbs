//
//  Proverb+Extensions.swift
//  MyanmarProverbs
//
//  Created by Dylan on 13/02/2025.
//

import Foundation

extension Proverb {
    static let preview: Proverb = Proverb(
        titleId: 1,
        proverbId: 1,
        proverbName: "က ချင်လျှက်လက်ကျိုး",
        proverbDesp: "က ချင်သူသည် ကရခါနီးမှ လက်ကျိုးသဖြင့် မကလိုက်ရ ဖြစ်သကဲ့သို့ မိမိ အစွမ်းအစကို ပြမည် ဟု အားခဲထားသူသည် အစွမ်းအစကို ပြရခါနီးမှ အကြောင်းမညီညွတ်သောကြောင့် မပြလိုက်ရ ဖြစ်သည်။ (က ချင်လျက် လက်နာ - ဟူ၍လည်း အသုံး ရှိသည်။"
    )
    static func previewList() -> [Proverb] {
        do {
            let proverbsData: ProverbsData = try Bundle.main.decodeJsonFile("MyanmarProverbs")
            return proverbsData.proverbs
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
