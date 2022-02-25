//
//  OrderBook.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/02/25.
//

import Foundation

struct OrderBook: Codable {
    let status: String
    let data: OrderBookData
}
