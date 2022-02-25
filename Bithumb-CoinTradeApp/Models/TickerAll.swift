//
//  TickerAll.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/25.
//

import Foundation

struct TickerAll: Codable {
    let status: String
    var data: [String: TickerData]
    var date: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)

        data = .init()
        let subContainer = try container.nestedContainer(keyedBy: GenericCodingKeys.self, forKey: .data)
        for key in subContainer.allKeys {
            if key.stringValue == "date" {
                date = try subContainer.decode(String?.self, forKey: key)
            } else {
                data[key.stringValue] = try subContainer.decode(TickerData.self, forKey: key)
            }
        }
    }
}
