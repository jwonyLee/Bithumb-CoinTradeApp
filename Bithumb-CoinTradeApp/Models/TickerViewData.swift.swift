//
//  TickerViewData.swift.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/01.
//

import Foundation

struct TickerViewData: Hashable {
    let coinName: String
    var currentPrice: String
    var fluctateRate: String
    var unitsTraded: String
    var isLiked: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(coinName)
    }
}

extension TickerViewData {
    enum FluctateRateFeeling {
        case veryHigh
        case high
        case low
        case veryLow
    }
    
    var fluctateRateFeeling: FluctateRateFeeling {
        guard let rate = Double(fluctateRate) else { return .high }
        
        switch rate {
        case 10...:
            return .veryHigh
        case 0..<10:
            return .high
        case -10..<0:
            return .low
        default:
            return .veryLow
        }
    }
    
    var tradedCount: Double {
        Double(unitsTraded) ?? 0
    }
}
