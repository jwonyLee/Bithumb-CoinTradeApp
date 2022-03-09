//
//  OrderBookViewData.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/09.
//

import Foundation

struct OrderBookViewData: Hashable {
    let price: String
    let quantity: String
    let orderType: TransactionType
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(price)
        hasher.combine(orderType)
    }
}

extension OrderBookViewData {
    var priceToDouble: Double {
        Double(price) ?? 0
    }
    
    var quantityToDouble: Double {
        Double(quantity) ?? 0
    }
}
