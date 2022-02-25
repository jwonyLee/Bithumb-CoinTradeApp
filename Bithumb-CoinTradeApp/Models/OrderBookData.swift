//
//  OrderBookData.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/02/25.
//

import Foundation

struct OrderBookData: Codable {
    let timestamp: String
    let orderCurrency: String
    let paymentCurrency: String
    let bids: [OrderBookTransaction]
    let asks: [OrderBookTransaction]
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case orderCurrency = "order_currency"
        case paymentCurrency = "payment_currency"
        case bids = "bids"
        case asks = "asks"
    }
}

struct OrderBookTransaction: Codable {
    let quantity: String
    let price: String
}
