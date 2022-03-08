//
//  TransactionHistoryWebSocketResponse.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/08.
//

import Foundation

struct TransactionHistoryWebSocketResponse: Codable {
    let type: String
    let content: TransactionHistoryWebSocketData
//    let datetime: String
}
