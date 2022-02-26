//
//  RESTAPIRepository.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/02/24.
//

import Foundation

import Alamofire
import RxSwift

protocol RESTAPIRepositable {
    func requestAssetStatus(orderCurrency: String) -> Single<AssetStatus>
    
    func requestTransactionHistory(
        orderCurrency: String,
        paymentCurrency: PaymentCurrency
    ) -> Single<TransactionHistory>
    
    func requestOrderBook(
        orderCurrency: String,
        paymentCurrency: PaymentCurrency
    ) -> Single<OrderBook>
    
    func requestAllOrderBook(
        paymentCurrency: PaymentCurrency
    ) -> Single<OrderBookAll>
    
    func requestAllTicker(paymentCurrency: PaymentCurrency) -> Single<TickerAll>
    
    func requestTicker(
        orderCurrency: String,
        paymentCurrency: PaymentCurrency
    ) -> Single<Ticker>
}

extension RESTAPIRepositable {
    func request<T: Codable>(_ endpoint: Endpoint) -> Single<T> {
        return Single.create { observer -> Disposable in
            let request = AF.request(
                endpoint.url,
                method: endpoint.httpMethod,
                parameters: endpoint.body,
                headers: endpoint.headers
            )
                .validate()
                .responseDecodable { (response: DataResponse<T, AFError>) in
                    switch response.result {
                    case let .success(value):
                        observer(.success(value))
                    case let .failure(error):
                        observer(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel() }
        }
    }
}

// MARK: - RESTAPIRepository

final class RESTAPIRepository: RESTAPIRepositable {
    
    func requestAssetStatus(orderCurrency: String) -> Single<AssetStatus> {
        return request(BithumbEndpointCases.assetsStatus(orderCurrency: orderCurrency))
    }
    
    func requestTransactionHistory(
        orderCurrency: String,
        paymentCurrency: PaymentCurrency
    ) -> Single<TransactionHistory> {
        return request(BithumbEndpointCases.transactionHistory(
            orderCurrency: orderCurrency,
            paymentCurrency: paymentCurrency
        ))
    }
    
    func requestOrderBook(
        orderCurrency: String,
        paymentCurrency: PaymentCurrency
    ) -> Single<OrderBook> {
        return request(BithumbEndpointCases.orderBook(
            orderCurrency: orderCurrency,
            paymentCurrency: paymentCurrency
        ))
    }
    
    func requestAllOrderBook(
        paymentCurrency: PaymentCurrency
    ) -> Single<OrderBookAll> {
        return request(BithumbEndpointCases.orderBook(
            orderCurrency: "ALL",
            paymentCurrency: paymentCurrency
        ))
    }
    
    func requestAllTicker(paymentCurrency: PaymentCurrency) -> Single<TickerAll> {
        return request(BithumbEndpointCases.ticker(
            orderCurrency: "ALL",
            paymentCurrency: paymentCurrency
        ))
    }
        
    func requestTicker(
        orderCurrency: String,
        paymentCurrency: PaymentCurrency
    ) -> Single<Ticker> {
        return request(BithumbEndpointCases.ticker(
            orderCurrency: orderCurrency,
            paymentCurrency: paymentCurrency
        ))
    }
}
