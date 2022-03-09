//
//  OrderBookWebSocketResponse.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/09.
//

import Foundation

struct OrderBookWebSocketResponse: Codable {
    let type: String
    let content: OrderBookWebSocketResponseContent
}
