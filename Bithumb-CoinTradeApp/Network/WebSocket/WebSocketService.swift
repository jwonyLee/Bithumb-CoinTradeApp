//
//  WebSocketService.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/06.
//

import Foundation

import RxSwift

enum SubscriptionType {
    case ticker
    case transaction
    case orderbookDepth
}

protocol WebSocketServiceType {
    func fetchData<T: Codable>(
        type: SubscriptionType,
        coinNames: [String],
        paymentCurrency: PaymentCurrency
    ) -> Observable<T>
}

class WebSocketService: WebSocketServiceType {
    let repository: WebSocketRepositable
    let disposeBag = DisposeBag()
    private var currentSubscriptionType: SubscriptionType?
    
    init(repository: WebSocketRepositable) {
        self.repository = repository
    }
    
    func fetchData<T: Codable>(
        type: SubscriptionType,
        coinNames: [String],
        paymentCurrency: PaymentCurrency
    ) -> Observable<T> {
        currentSubscriptionType = .ticker

        return repository.requestData(
            type: type,
            coinNames: coinNames,
            paymentCurrency: paymentCurrency
        )
            .filter { !$0.isEmpty }
            .map { try self.decode(from: $0) }
    }
    
    // TODO: - Generic 적용
    
    func decode<T: Codable>(from text: String) throws -> T {
        guard let data = text.data(using: .utf8)
        else { throw WebSocketError.decodingError }
                
        do {
            let response = try JSONDecoder().decode(
                T.self,
                from: data
            )
            
            return response
        } catch {
            throw WebSocketError.decodingError
        }
    }
}
