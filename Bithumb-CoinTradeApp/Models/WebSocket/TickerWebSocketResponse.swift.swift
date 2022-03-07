//
//  TickerWebSocketResponse.swift.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/06.
//

import Foundation

struct TickerWebSocketResponse: Codable {
    let type: String
    let content: TickerWebSocketData
}
