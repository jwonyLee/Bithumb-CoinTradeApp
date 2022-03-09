//
//  CoinChartViewModel.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/08.
//

import Foundation

import RxSwift

protocol CoinChartViewModelType {
    var coinChartObservable: Observable<[[CandlestickData]]> { get }
}

class CoinChartViewModel: CoinChartViewModelType {
    var coinName: String
    
    private let disposeBag = DisposeBag()
    
    private let restAPIRepository: RESTAPIRepositable
    
    private var coinChartDataList = [[CandlestickData]]()
    private let coinChartDataSubject = BehaviorSubject<[[CandlestickData]]>(value: [])
    
    var coinChartObservable: Observable<[[CandlestickData]]> { coinChartDataSubject }
    
    init(
        coinName: String,
        restAPIRepository: RESTAPIRepositable
    ) {
        self.coinName = coinName
        self.restAPIRepository = restAPIRepository
        
        self.loadData()
    }
    
    private func loadData() {
        let result = restAPIRepository.requestCandlestick(orderCurrency: coinName, paymentCurrency: .krw, chartIntervals: .hoursOf1)
        result
            .subscribe(with: self) { owner, candlestick in
                owner.coinChartDataList = candlestick.data
                owner.coinChartDataSubject.onNext(candlestick.data)
            }
            .disposed(by: disposeBag)
    }
    
    private func makeViewData(_ transactionList: [TransactionHistoryData]) -> [TransactionHistoryViewData] {
        var result = [TransactionHistoryViewData]()
        transactionList.forEach { transaction in
            result.append(TransactionHistoryViewData(receivedDate: Date(), transactionDate: transaction.transactionDate, price: Double(transaction.price) ?? 0, quantity: Double(transaction.unitsTraded) ?? 0, type: transaction.type))
        }
        
        return result
    }
}
