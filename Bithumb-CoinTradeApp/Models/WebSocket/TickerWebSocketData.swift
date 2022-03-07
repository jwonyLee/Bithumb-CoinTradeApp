//
//  TickerWebSocketData.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/06.
//

import Foundation

struct TickerWebSocketData: Codable {
    let tickType: String
    let date: String
    let time: String
    let openPrice: String
    let closePrice: String
    let lowPrice: String
    let highPrice: String
    let value: String
    let volume: String
    let sellVolume: String
    let buyVolume: String
    let prevClosePrice: String
    let chgRate: String
    let chgAmt: String
    let volumePower: String
    let symbol: String
}

extension TickerWebSocketData {
    var coinName: String? {
        guard let name = symbol.split(separator: "_").first
        else { return nil }
        
        return String(name)
    }
}
