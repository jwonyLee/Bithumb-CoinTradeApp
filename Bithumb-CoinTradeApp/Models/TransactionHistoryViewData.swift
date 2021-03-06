//
//  TransactionHistoryViewData.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/02.
//

import Foundation

struct TransactionHistoryViewData: Hashable {
    let receivedDate: Date
    let transactionDate: String
    let price: Double
    let quantity: Double
    let type: TransactionType
}
