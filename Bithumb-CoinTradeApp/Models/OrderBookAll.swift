//
//  OrderBookAll.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/02/25.
//

import Foundation

struct OrderBookAll: Codable {
    let status: String
    var data: [String: OrderBookData]
    var timestamp: String?
    var paymentCurrency: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)

        data = .init()
        let subContainer = try container.nestedContainer(keyedBy: GenericCodingKeys.self, forKey: .data)
        for key in subContainer.allKeys {
            if key.stringValue == "timestamp" {
                timestamp = try subContainer.decode(String?.self, forKey: key)
            } else if key.stringValue == "payment_currency" {
                paymentCurrency = try subContainer.decode(String?.self, forKey: key)
            } else {
                data[key.stringValue] = try subContainer.decode(OrderBookData.self, forKey: key)
            }
        }
    }
}
