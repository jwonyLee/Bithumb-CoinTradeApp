//
//  Candlestick.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/03/05.
//

import Foundation

struct Candlestick: Codable {
    let status: String
    let data: [[CandlestickData]]
}

enum CandlestickData: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(
            CandlestickData.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Wrong type for Datum"
            ))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }

    var value: String {
        switch self {
        case .integer(let int):
            return "\(int)"
        case .string(let string):
            return string
        }
    }
}
