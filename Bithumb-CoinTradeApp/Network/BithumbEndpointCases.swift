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

enum BithumbEndpointCases {
    typealias OrderCurrency = String
    
    case ticker(orderCurrency: OrderCurrency, paymentCurrency: PaymentCurrency)
    case orderBook(orderCurrency: OrderCurrency, paymentCurrency: PaymentCurrency)
    case transactionHistory(orderCurrency: OrderCurrency, paymentCurrency: PaymentCurrency)
    case assetsStatus(orderCurrency: OrderCurrency)
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
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var body: [String : Any]? {
        return [:]
    }
}
