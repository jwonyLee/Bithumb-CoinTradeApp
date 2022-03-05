//
//  TransactionHistoryData.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/02.
//

import Foundation

enum TransactionType: String, Codable {
    case bid
    case ask
}

struct TransactionHistoryData: Codable {
    let transactionDate: String         // ex) 2018-04-10 17:47:46
    let type: TransactionType
    let unitsTraded: String
    let price: String
    let total: String
    
    enum CodingKeys: String, CodingKey {
        case type, price, total
        case transactionDate = "transaction_date"
        case unitsTraded = "units_traded"
    }
    
    var transactionDateToDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return formatter.date(from: transactionDate)
    }
}
