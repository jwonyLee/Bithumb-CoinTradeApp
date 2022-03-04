//
//  WebSocketRepository.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/03.
//

import Foundation

import Starscream
import RxSwift

enum SubscriptionType {
    case ticker
    case transaction
    case orderbookDepth
}

protocol WebSocketRepositable {
    func requestSubscribe(
        type: SubscriptionType,
        coinNames: [String],
        paymentCurrency: PaymentCurrency
    )
}

final class WebSocketRepository: WebSocketRepositable {
    private let socket: WebSocket
    
    init() {
        var request = URLRequest(url: URL(string: "wss://pubwss.bithumb.com/pub/ws")!)
        request.timeoutInterval = 5
        
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    func requestSubscribe(
        type: SubscriptionType,
        coinNames: [String],  // "BTC", "ETH"
        paymentCurrency: PaymentCurrency
    ) {
        let symbols = coinNames
            .map { "\"\($0)_\(paymentCurrency.rawValue)\"" }
            .joined(separator: ",")
        
        var requestMessage: String = ""

        switch type {
        case .ticker:
            requestMessage = """
            {"type":"ticker", "symbols": [\(symbols)], "tickTypes": ["30M", "1H", "12H", "24H", "MID" ]}
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
}

// MARK: - WebSocketDelegate

extension WebSocketRepository: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected:
            break
        case .disconnected:
            connect()
            break
        case .text(let string):
            print("Received text: \(string)")
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
