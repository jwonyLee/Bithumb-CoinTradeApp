//
//  WebSocketError.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/06.
//

import Foundation

enum WebSocketError: Error {
    case invalidURL
    case decodingError
    case invalidFilter
}
