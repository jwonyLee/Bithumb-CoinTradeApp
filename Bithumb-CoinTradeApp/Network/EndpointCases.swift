//
//  EndpointCases.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/02/24.
//

import Foundation
import Alamofire

enum BithumbEndpointCases {
    typealias OrderCurrency = String
    typealias PaymentCurrency = String
    
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
        return "api.bithumb.com/public"
    }
    
    var path: String {
        switch self {
        case let .ticker(orderCurrency, paymentCurrency):
            return "/ticker/\(orderCurrency)_\(paymentCurrency)"
        case let .orderBook(orderCurrency, paymentCurrency):
            return "/orderbook/\(orderCurrency)_\(paymentCurrency)"
        case let .transactionHistory(orderCurrency, paymentCurrency):
            return "/transaction_history/\(orderCurrency)_\(paymentCurrency)"
        case let .assetsStatus(orderCurrency):
            return "/assetsstatus/\(orderCurrency)"
        }
    }
    
    var headers: [String : Any]? {
        return [:]
    }
    
    var body: [String : Any]? {
        return [:]
    }
}
