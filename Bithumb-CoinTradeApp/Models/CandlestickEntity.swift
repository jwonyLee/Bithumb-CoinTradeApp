//
//  CandlestickEntity.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/03/07.
//

import Foundation

import RealmSwift

final class CandlestickEntity: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var status: String
    @Persisted var data: List<CandlestickDataEntity>
}

final class CandlestickDataEntity: Object {
    @Persisted var standardTime: Int
    /// 시가
    @Persisted var marketPrice: String
    /// 종가
    @Persisted var closingPrice: String
    /// 고가
    @Persisted var highPrice: String
    /// 저가
    @Persisted var lowPrice: String
    /// 거래량
    @Persisted var volume: String
}
