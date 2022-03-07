//
//  WebSocketRepository.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/03.
//

import Foundation

import Starscream
import RxSwift

protocol WebSocketRepositable {
    
    func requestData(
        type: SubscriptionType,
        coinNames: [String],
        paymentCurrency: PaymentCurrency
    ) -> Observable<String>
}

final class WebSocketRepository: WebSocketRepositable {
    private let socket: WebSocket
    private let responseSubject: BehaviorSubject<String> = .init(value: "")
    private var isConnected = false
    private var request: WebSocketDataRequest?
    
    init() throws {
        guard let url = URL(string: "wss://pubwss.bithumb.com/pub/ws")
        else { throw WebSocketError.invalidURL }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    func requestData(
        type: SubscriptionType,
        coinNames: [String],  // "BTC", "ETH"
        paymentCurrency: PaymentCurrency
    ) -> Observable<String> {
        
        let symbols = makeSymbols(coinNames: coinNames, paymentCurrency: paymentCurrency)
        
        if isConnected {
            requestSubcription(type: type, symbols: symbols)
        } else {
            request = WebSocketDataRequest(type: type, symbols: symbols)
        }
        
        return responseSubject
    }
    
    private func makeSymbols(coinNames: [String], paymentCurrency: PaymentCurrency) -> String {
        return coinNames
            .map { "\"\($0)_\(paymentCurrency.rawValue)\"" }
            .joined(separator: ",")
    }
    
    private func requestSubcription(type: SubscriptionType, symbols: String) {
        var requestMessage: String = ""

        switch type {
        case .ticker:
            requestMessage = """
            {"type":"ticker", "symbols": [\(symbols)], "tickTypes": ["30M"]}
            """
        case .transaction:
            requestMessage = """
            {"type":"transaction", "symbols":[\(symbols)]}
            """
        case .orderbookDepth:
            requestMessage = """
            {"type":"orderbookdepth", "symbols":[\(symbols)]}
            """
        }
        
        socket.write(string: requestMessage)
    }
    
    private func connect() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
            self.socket.connect()
        }
    }
    
    private func handleResponse(_ response: String) {
        if let data = response.data(using: .utf8),
           let initResponse = try? JSONDecoder().decode(WebSocketInitResponse.self, from: data)
        {
            guard initResponse.status == "0000" else {
                responseSubject.onError(WebSocketError.invalidFilter)
                return
            }
            
            return
        }

        responseSubject.onNext(response)
    }
}

// MARK: - WebSocketDataRequest

extension WebSocketRepository {
    
    struct WebSocketDataRequest {
        let type: SubscriptionType
        let symbols: String
    }
}

// MARK: - WebSocketDelegate

extension WebSocketRepository: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected:
            isConnected = true
            
            if let request = request {
                requestSubcription(type: request.type, symbols: request.symbols)
            }
            break
        case .disconnected:
            connect()
            break
        case .text(let response):
            handleResponse(response)
        case .binary:
            break
        case .pong:
            break
        case .ping:
            break
        case .error:
            connect()
            break
        case .viabilityChanged:
            break
        case .reconnectSuggested:
            break
        case .cancelled:
            break
        }
    }
}
