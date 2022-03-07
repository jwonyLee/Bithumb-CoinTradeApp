//
//  Double+.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/07.
//

import Foundation

extension Double {
    var toCurrencyFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(floatLiteral: self)) ?? "0"
    }
}
