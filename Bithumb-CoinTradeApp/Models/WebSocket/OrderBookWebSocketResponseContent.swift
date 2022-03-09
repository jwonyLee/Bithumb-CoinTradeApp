//
//  OrderBookWebSocketResponseContent.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/09.
//

import Foundation

struct OrderBookWebSocketResponseContent: Codable {
    let list: [OrderBookWebSocketData]
    let datetime: String
}
