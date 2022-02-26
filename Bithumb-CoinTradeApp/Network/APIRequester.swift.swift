//
//  APIRequester.swift.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/02/24.
//

import Foundation

import Alamofire

class APIRequester {
    func requestAssetStatus() {
        request(endpoint: BithumbEndpointCases.assetsStatus(orderCurrency: "ALL")) { (response: DataResponse<AssetStatus, AFError>) in
            print(response.value)
        }
    }
    
    func requestTransactionHistory(orderCurrency: String, paymentCurrency: String) {
        request(endpoint: BithumbEndpointCases.transactionHistory(
            orderCurrency: orderCurrency,
            paymentCurrency: paymentCurrency
        )) { (response: DataResponse<TransactionHistory, AFError>) in
            print(response.value)
        }
    }

    func requestAllOrderbook() {
        request(endpoint: BithumbEndpointCases.orderBook(orderCurrency: "ALL", paymentCurrency: "KRW")) { (response: DataResponse<OrderBookAll, AFError>) in
            print(response.value)
        }
    }
    
    func requestOrderbook() {
        request(endpoint: BithumbEndpointCases.orderBook(orderCurrency: "BTC", paymentCurrency: "KRW")) { (response: DataResponse<OrderBook, AFError>) in
            print(response.value)
        }
    }
    
    private func request<T: Decodable>(
        endpoint: Endpoint,
        completion: ((DataResponse<T, AFError>) -> Void)?
    ) {
        AF.request(
            endpoint.url,
            method: endpoint.httpMethod,
            parameters: endpoint.body,
            headers: endpoint.headers
        )
            .validate()
            .responseDecodable { (response: DataResponse<T, AFError>) in
                completion?(response)
            }
    }
}
