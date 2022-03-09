//
//  OrderBookWebSocketData.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/09.
//

import Foundation

struct OrderBookWebSocketData: Codable {
    let symbol: String
    let orderType: TransactionType
    let price: String
    let quantity: String
    let total: String
}
