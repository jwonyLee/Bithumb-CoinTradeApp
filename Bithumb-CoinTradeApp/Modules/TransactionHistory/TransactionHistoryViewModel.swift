//
//  TransactionHistoryViewModel.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/02.
//

import Foundation

import RxSwift

protocol TransactionHistoryViewModelType {
    var transactionListObservable: Observable<[TransactionHistoryViewData]> { get }
}

class TransactionHistoryViewModel: TransactionHistoryViewModelType {
    var coinName: String
    
    private let disposeBag = DisposeBag()
    
    private let webSocketService: WebSocketServiceType
//    private let restAPIRepository: RESTAPIRepositable
    
    private var transactionViewDataList = [TransactionHistoryViewData]()
    private let transactionListViewDataSubject = BehaviorSubject<[TransactionHistoryViewData]>(value: [])
    
    var transactionListObservable: Observable<[TransactionHistoryViewData]> { transactionListViewDataSubject }
    
    init(
        coinName: String,
        webSocketService: WebSocketServiceType
    ) {
        self.coinName = coinName
        self.webSocketService = webSocketService
        
        self.loadData()
    }
    
    private func loadData() {
        subscribeData()
    }
    
    private func makeViewData(_ transactionList: [TransactionHistoryData]) -> [TransactionHistoryViewData] {
        var result = [TransactionHistoryViewData]()
        transactionList.forEach { transaction in
            result.append(TransactionHistoryViewData(receivedDate: Date(), transactionDate: transaction.transactionDate, price: Double(transaction.price) ?? 0, quantity: Double(transaction.unitsTraded) ?? 0, type: transaction.type))
        }
        
        return result
    }
    
    private func subscribeData() {
        webSocketService.fetchData(
            type: .transaction,
            coinNames: [coinName],
            paymentCurrency: .krw
        )
            .subscribe(with: self, onNext: { (owner, response: TransactionHistoryWebSocketResponse) in
                response.content.list.forEach { element in
                    let viewData = TransactionHistoryViewData(receivedDate: Date() ,transactionDate: element.contDtm, price: Double(element.contPrice) ?? 0, quantity: Double(element.contQty) ?? 0, type: TransactionType(rawValue: ((element.updn == "up") ? "bid" : "ask")) ?? .ask)
                    owner.transactionViewDataList.append(viewData)
                }
                owner.transactionListViewDataSubject.onNext(owner.transactionViewDataList.reversed())
            })
            .disposed(by: disposeBag)
    }
}
