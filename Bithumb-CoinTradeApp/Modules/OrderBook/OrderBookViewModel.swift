//
//  OrderBookViewModel.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/09.
//

import Foundation

import RxSwift

protocol OrderBookViewModelType {
    var orderBookObservable: Observable<[OrderBookViewData]> { get }
}

class OrderBookViewModel: OrderBookViewModelType {
    private let disposBag = DisposeBag()
    
    private let webSockeService: WebSocketServiceType
    private let coinName: String
    
    private let orderBookDataSubject = BehaviorSubject<[OrderBookViewData]>(value: [])
    private var orderBookDataList = [OrderBookViewData]()
    
    var orderBookObservable: Observable<[OrderBookViewData]> { orderBookDataSubject }
    
    init(
        websocketService: WebSocketServiceType,
        coinName: String
    ) {
        self.webSockeService = websocketService
        self.coinName = coinName
        
        loadData()
    }
    
    private func loadData() {
        webSockeService.fetchData(
            type: .orderbookDepth,
            coinNames: [coinName],
            paymentCurrency: .krw
        )
            .subscribe(with: self, onNext: { (owner, response: OrderBookWebSocketResponse) in
                let viewData = response.content.list
                    .map {
                        OrderBookViewData(
                            price: $0.price,
                            quantity: $0.quantity,
                            orderType: $0.orderType
                        )
                    }
                    .filter { $0.quantityToDouble > 0 }
                
                var newAskList = viewData
                    .filter { $0.orderType == .ask }
                    .sorted { $0.priceToDouble > $1.priceToDouble }
                                
                let previousAskList = owner.orderBookDataList
                    .filter {
                        $0.orderType == .ask
                        && $0.priceToDouble > newAskList.first?.priceToDouble ?? 0
                    }
                    .sorted { $0.priceToDouble > $1.priceToDouble }
                
                newAskList.insert(contentsOf: previousAskList, at: 0)
                newAskList = newAskList.suffix(50)
                
                var newBidList = viewData
                    .filter { $0.orderType == .bid }
                    .sorted { $0.priceToDouble > $1.priceToDouble }
                
                let previousBidList = owner.orderBookDataList
                    .filter {
                        $0.orderType == .bid
                        && $0.priceToDouble < newBidList.last?.priceToDouble ?? 0
                    }
                    .sorted { $0.priceToDouble > $1.priceToDouble }
                
                newBidList.append(contentsOf: previousBidList)
                newBidList = Array(newBidList.prefix(50))
                
                owner.orderBookDataList = newAskList.suffix(10) + newBidList.prefix(10)
                owner.orderBookDataSubject.onNext(owner.orderBookDataList)
            })
            .disposed(by: disposBag)
    }
}
