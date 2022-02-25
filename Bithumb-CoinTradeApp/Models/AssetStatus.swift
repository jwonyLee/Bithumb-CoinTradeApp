//
//  AssetStatus.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/02/25.
//

import Foundation

struct AssetStatus: Codable {
    let status: String
    var data: [String: AssetStatus.AssetData?]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try container.decode(String.self, forKey: .status)
        
        data = .init()
        let subContainer = try container.nestedContainer(keyedBy: GenericCodingKeys.self, forKey: .data)
        for key in subContainer.allKeys {
            data[key.stringValue] = try subContainer.decode(AssetStatus.AssetData?.self, forKey: key)
        }
    }
}

extension AssetStatus {
    struct AssetData: Codable {
        let depositStatus: Int
        let withdrawalStatus: Int
        
        enum CodingKeys: String, CodingKey {
            case depositStatus = "deposit_status"
            case withdrawalStatus = "withdrawal_status"
        }
    }
}
