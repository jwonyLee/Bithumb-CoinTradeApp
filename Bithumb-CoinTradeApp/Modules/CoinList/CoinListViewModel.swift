//
//  CoinListViewModel.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/01.
//

import Foundation

import RxSwift

protocol CoinListViewModelType {
    var coinListObservable: Observable<[TickerViewData]> { get }
    func changeLikeState(_ coin: String)
    func changeList(to type: CoinListType)
}

final class CoinListViewModel: CoinListViewModelType {
    private let disposeBag = DisposeBag()
    
    private let webSocketService: WebSocketServiceType
    private let restAPIRepository: RESTAPIRepositable
    
    private let tickerViewDataSubject = BehaviorSubject<[TickerViewData]>(value: [])
    private var tickerViewDataList = [TickerViewData]()
    private var listType: CoinListType = .krw
    
    var coinListObservable: Observable<[TickerViewData]> { tickerViewDataSubject }
    
    init(
        webSocketService: WebSocketServiceType,
        restAPIRepository: RESTAPIRepositable
    ) {
        self.webSocketService = webSocketService
        self.restAPIRepository = restAPIRepository
        
        loadData()
    }
    
    private func loadData() {
        restAPIRepository.requestAllTicker(paymentCurrency: .krw)
            .map { self.makeTickerViewData($0.data) }
            .subscribe(with: self, onSuccess: { owner, tickerViewData in
                owner.tickerViewDataList = tickerViewData.sorted {
                    $0.price > $1.price
                }
                owner.tickerViewDataSubject.onNext(owner.tickerViewDataList)
                
                owner.subscribeData()
            })
            .disposed(by: disposeBag)
    }
    
    private func makeTickerViewData(_ tickerDict: [String: TickerData]) -> [TickerViewData] {
         return tickerDict.map { coinName, tickerData in
            TickerViewData(
                coinName: coinName,
                currentPrice: tickerData.openingPrice,
                fluctateRate: tickerData.fluctateRate24H,
                isLiked: false
            )
        }
    }
    
    private func subscribeData() {
        webSocketService.fetchData(
            type: .ticker,
            coinNames: tickerViewDataList.map(\.coinName),
            paymentCurrency: .krw
        )
            .subscribe(with: self, onNext: { (owner, response: TickerWebSocketResponse) in
                let responseData = response.content
                
                if let index = owner.tickerViewDataList.firstIndex(where: { $0.coinName == responseData.coinName }) {
                    owner.tickerViewDataList[index].currentPrice = responseData.openPrice
                    owner.tickerViewDataList[index].fluctateRate = responseData.chgRate
                    
                    owner.changeList(to: owner.listType)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func changeLikeState(_ coin: String) {
        guard let tickerIndex = (tickerViewDataList.firstIndex { $0.coinName == coin }) else { return }
        
        tickerViewDataList[tickerIndex].isLiked.toggle()
        changeList(to: listType)
    }
    
    func changeList(to type: CoinListType) {
        listType = type
        
        switch type {
        case .krw:
            tickerViewDataSubject.onNext(tickerViewDataList)
        case .like:
            tickerViewDataSubject.onNext(tickerViewDataList.filter(\.isLiked))
        case .popular:
            tickerViewDataSubject.onNext(tickerViewDataList.sorted { $0.changeRate > $1.changeRate })
        }
    }
}
