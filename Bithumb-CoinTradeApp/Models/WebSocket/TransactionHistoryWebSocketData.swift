//
//  TransactionHistoryWebSocketData.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/08.
//

import Foundation

struct TransactionHistoryWebSocketData: Codable {
    let list: [TransactionHistoryWebSocketListElement]
}

struct TransactionHistoryWebSocketListElement: Codable {
    let buySellGb: String
    let contPrice: String
    let contQty: String
    let contAmt: String
    let contDtm: String
    let updn: String
    let symbol: String
}
