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
    
    private let orderBookDataSubject = BehaviorSubject<[OrderBookViewData]>(value: [])
    private var orderBookDataList = [OrderBookViewData]()
    
    var orderBookObservable: Observable<[OrderBookViewData]> { orderBookDataSubject }
    
    init(
        websocketService: WebSocketServiceType
    ) {
        self.webSockeService = websocketService
        
        loadData()
    }
    
    private func loadData() {
        webSockeService.fetchData(
            type: .orderbookDepth,
            coinNames: ["BTC"],
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
                    .sorted { $0.priceToDouble > $1.priceToDouble }
                
                owner.orderBookDataList = viewData
                owner.orderBookDataSubject.onNext(viewData)
            })
            .disposed(by: disposBag)
    }
}
