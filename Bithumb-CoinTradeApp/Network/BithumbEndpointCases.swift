//
//  EndpointCases.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/02/24.
//

import Foundation
import Alamofire

enum PaymentCurrency: String {
    case krw = "KRW"
    case btc = "BTC"
}

enum ChartIntervals: String {
    case minutesOf1 = "1m"
    case minutesOf3 = "3m"
    case minutesOf5 = "5m"
    case minutesOf10 = "10m"
    case minutesOf30 = "30m"
    case hoursOf1 = "1h"
    case hoursOf6 = "6h"
    case hoursOf12 = "12h"
    case hoursOf24 = "24h"
}

enum BithumbEndpointCases {
    typealias OrderCurrency = String
    
    case ticker(orderCurrency: OrderCurrency, paymentCurrency: PaymentCurrency)
    case orderBook(orderCurrency: OrderCurrency, paymentCurrency: PaymentCurrency)
    case transactionHistory(orderCurrency: OrderCurrency, paymentCurrency: PaymentCurrency)
    case assetsStatus(orderCurrency: OrderCurrency)
    case candlestick(orderCurrency: OrderCurrency, paymentCurrency: PaymentCurrency, chartIntervals: ChartIntervals)
}

extension BithumbEndpointCases: Endpoint {
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var baseURLString: String {
        return "https://api.bithumb.com/public"
    }
    
    var path: String {
        switch self {
        case let .ticker(orderCurrency, paymentCurrency):
            return "/ticker/\(orderCurrency)_\(paymentCurrency.rawValue)"
        case let .orderBook(orderCurrency, paymentCurrency):
            return "/orderbook/\(orderCurrency)_\(paymentCurrency.rawValue)"
        case let .transactionHistory(orderCurrency, paymentCurrency):
            return "/transaction_history/\(orderCurrency)_\(paymentCurrency.rawValue)"
        case let .assetsStatus(orderCurrency):
            return "/assetsstatus/\(orderCurrency)"
        case let .candlestick(orderCurrency, paymentCurrency, chartIntervals):
            return "/candlestick/\(orderCurrency)_\(paymentCurrency)/\(chartIntervals.rawValue)"
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }

    var body: [String: Any]? {
        return [:]
    }
}
