//
//  GeneralCodingKeys.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/02/25.
//

import Foundation

/// Key를 모르는 딕셔너리를 파싱
struct GenericCodingKeys: CodingKey {
    var intValue: Int?
    var stringValue: String
    
    /// Int 키값 안씀
    init?(intValue: Int) {
        return nil
    }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    static func makeKey(name: String) -> GenericCodingKeys {
        return GenericCodingKeys(stringValue: name)!
    }
}
