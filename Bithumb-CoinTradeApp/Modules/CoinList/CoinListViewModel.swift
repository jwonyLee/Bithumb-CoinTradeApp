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
}

final class CoinListViewModel: CoinListViewModelType {
    private let disposeBag = DisposeBag()
    
    private var tickerDict = [String: TickerData]()
    private let tickerViewDataSubject = BehaviorSubject<[TickerViewData]>(value: [])
    private var tickerViewDataList = [TickerViewData]()
    
    var coinListObservable: Observable<[TickerViewData]> { tickerViewDataSubject }
    
    init() {
        tickerDict = loadData()
        tickerViewDataList = makeTickerViewData(tickerDict)
        tickerViewDataSubject.onNext(tickerViewDataList)
    }
    
    private func loadData() -> [String: TickerData] {
        return sampleData
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
    
    func changeLikeState(_ coin: String) {
        guard let tickerIndex = (tickerViewDataList.firstIndex { $0.coinName == coin }) else { return }
        
        tickerViewDataList[tickerIndex].isLiked.toggle()
        tickerViewDataSubject.onNext(tickerViewDataList)
    }
}

let sampleData = [
    "IOST": TickerData(openingPrice: "30.1", closingPrice: "30.91", minPrice: "29.92", maxPrice: "31.96", unitsTraded: "3473696.12696008", accTradeValue: "107867173.568", prevClosingPrice: "30.1", unitsTraded24H: "7145882.11250673", accTradeValue24H: "217443115.2225", fluctate24H: "2.08", fluctateRate24H: "7.21"),
    "LUNA": TickerData(openingPrice: "96050", closingPrice: "106900", minPrice: "95150", maxPrice: "110700", unitsTraded: "495846.90815218", accTradeValue: "51891203102.7725", prevClosingPrice: "96050", unitsTraded24H: "636575.54595191", accTradeValue24H: "64879136424.2235", fluctate24H: "18800", fluctateRate24H: "21.34"),
    "XNO": TickerData(openingPrice: "69.14", closingPrice: "70.66", minPrice: "68.19", maxPrice: "71.56", unitsTraded: "406780965.03820609", accTradeValue: "28691398968.2376", prevClosingPrice: "69.14", unitsTraded24H: "530671851.22651861", accTradeValue24H: "37184843259.2708", fluctate24H: "2.64", fluctateRate24H: "3.88"),
    "GALA": TickerData(openingPrice: "295.8", closingPrice: "323.1", minPrice: "290", maxPrice: "332.4", unitsTraded: "45075684.93062731", accTradeValue: "14139832563.6272", prevClosingPrice: "296", unitsTraded24H: "57906816.59970987", accTradeValue24H: "17790710551.0274", fluctate24H: "45.3", fluctateRate24H: "16.31"), "DAO": TickerData(openingPrice: "2450", closingPrice: "2626", minPrice: "2421", maxPrice: "2717", unitsTraded: "32917.85983204", accTradeValue: "84812269.3275", prevClosingPrice: "2439", unitsTraded24H: "36285.6657276", accTradeValue24H: "92966328.1168", fluctate24H: "205", fluctateRate24H: "8.47"),
    "LINK": TickerData(openingPrice: "17480", closingPrice: "18220", minPrice: "17260", maxPrice: "18510", unitsTraded: "149861.99986509", accTradeValue: "2712942737.0091", prevClosingPrice: "17480", unitsTraded24H: "208761.19681772", accTradeValue24H: "3705459825.1991", fluctate24H: "1630", fluctateRate24H: "9.83"),
    "DAI": TickerData(openingPrice: "1224", closingPrice: "1214", minPrice: "1208", maxPrice: "1224", unitsTraded: "1085033.21455818", accTradeValue: "1316208234.0323", prevClosingPrice: "1220", unitsTraded24H: "1160560.70598644", accTradeValue24H: "1408550261.0308", fluctate24H: "-16", fluctateRate24H: "-1.30"),
    "MTL": TickerData(openingPrice: "1825", closingPrice: "1903", minPrice: "1818", maxPrice: "1920", unitsTraded: "148470.74621078", accTradeValue: "278943947.9521", prevClosingPrice: "1834", unitsTraded24H: "187774.89534766", accTradeValue24H: "349362505.9747", fluctate24H: "152", fluctateRate24H: "8.68"),
    "ANV": TickerData(openingPrice: "546.3", closingPrice: "573.1", minPrice: "535.6", maxPrice: "585.8", unitsTraded: "523880.36312995", accTradeValue: "297106810.4096", prevClosingPrice: "546.3", unitsTraded24H: "601537.19137559", accTradeValue24H: "338750659.7993", fluctate24H: "35.6", fluctateRate24H: "6.62"),
    "WOO": TickerData(openingPrice: "584.2", closingPrice: "618.1", minPrice: "560.8", maxPrice: "651", unitsTraded: "1186073.4799924", accTradeValue: "725093164.5034", prevClosingPrice: "582.2", unitsTraded24H: "1526372.07459157", accTradeValue24H: "914432753.3557", fluctate24H: "88.2", fluctateRate24H: "16.64")
 ]
