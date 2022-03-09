//
//  RealmRepository.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/03/07.
//

import Foundation

import RealmSwift

protocol RealmRepositable {
    var realm: Realm { get set }
    func create(name: String, candlestick: Candlestick)
    func read() -> [CandlestickEntity]
    func read(name: String) -> CandlestickEntity?
    func update(name: String, updateCandlestick: Candlestick)
    func delete()
    func delete(name: String)
}

final class RealmRepository: RealmRepositable {
    var realm: Realm = try! Realm()

    func create(name: String, candlestick: Candlestick) {
        let candlestickEntity: CandlestickEntity = CandlestickEntity()
        candlestickEntity.name = name

        let candlestickDatas: List<CandlestickDataEntity> = List<CandlestickDataEntity>()
        for data in candlestick.data {
            let dataEntity: CandlestickDataEntity = CandlestickDataEntity()
            if let standardTime: Int = Int(data[0].value) {
                dataEntity.standardTime = standardTime
            }
            dataEntity.marketPrice = data[1].value
            dataEntity.closingPrice = data[2].value
            dataEntity.highPrice = data[3].value
            dataEntity.lowPrice = data[4].value
            dataEntity.volume = data[5].value
            candlestickDatas.append(dataEntity)
        }
        candlestickEntity.data = candlestickDatas

        try? realm.write {
            realm.add(candlestickEntity)
        }
    }

    func read() -> [CandlestickEntity] {
        return Array(realm.objects(CandlestickEntity.self))
    }

    func read(name: String) -> CandlestickEntity? {
        return realm.object(ofType: CandlestickEntity.self, forPrimaryKey: name)
    }

    func update(name: String, updateCandlestick: Candlestick) {
        delete(name: name)
        create(name: name, candlestick: updateCandlestick)
    }

    func delete() {
        try? realm.write {
            realm.delete(realm.objects(CandlestickEntity.self))
        }
    }

    func delete(name: String) {
        guard let findEntity: CandlestickEntity = realm.object(ofType: CandlestickEntity.self, forPrimaryKey: name) else {
            return
        }
        try? realm.write {
            realm.delete(findEntity)
        }
    }
}
