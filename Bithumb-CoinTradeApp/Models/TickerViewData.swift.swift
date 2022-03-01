//
//  TickerViewData.swift.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/01.
//

import Foundation

struct TickerViewData: Hashable {
    let coinName: String
    let currentPrice: String
    let fluctateRate: String
    var isLiked: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(coinName)
    }
}
