//
//  TransactionHistoryViewModel.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/02.
//

import Foundation

import RxSwift

protocol TransactionHistoryViewModelType {
}

class TransactionHistoryViewModel: TransactionHistoryViewModelType {
    private let disposeBag = DisposeBag()
    
    private var transactionList = [TransactionHistoryData]()
    
    init() {
        transactionList = loadData()
    }
    
    private func loadData() -> [TransactionHistoryData] {
        return sampleData
    }
}

extension TransactionHistoryViewModel {
    var sampleData: [TransactionHistoryData] {
        return [
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:46", type: .ask, unitsTraded: "0.0001", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:47", type: .bid, unitsTraded: "0.0021", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:48", type: .bid, unitsTraded: "0.0011", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:49", type: .ask, unitsTraded: "0.0051", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:50", type: .ask, unitsTraded: "0.0091", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:50", type: .bid, unitsTraded: "0.0001", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:50", type: .ask, unitsTraded: "0.0061", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:50", type: .ask, unitsTraded: "0.0051", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:50", type: .bid, unitsTraded: "0.0041", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:55", type: .bid, unitsTraded: "0.0031", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:56", type: .ask, unitsTraded: "0.021", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:57", type: .bid, unitsTraded: "0.0501", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:58", type: .ask, unitsTraded: "0.0061", price: "7575000", total: "758"),
            TransactionHistoryData(transactionDate: "2018-04-10 17:47:59", type: .bid, unitsTraded: "0.0701", price: "7575000", total: "758"),
        ]
    }
}
