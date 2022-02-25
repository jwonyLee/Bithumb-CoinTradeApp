//
//  APIRequester.swift.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/02/24.
//

import Foundation

import Alamofire

class APIRequester {
    func requestAssetStatus() {
        request(endpoint: BithumbEndpointCases.assetsStatus(orderCurrency: "ALL")) { (response: DataResponse<AssetStatus, AFError>) in
            print(response.value)
        }
    }
    
    private func request<T: Decodable>(
        endpoint: Endpoint,
        completion: ((DataResponse<T, AFError>) -> Void)?
    ) {
        AF.request(
            endpoint.url,
            method: endpoint.httpMethod,
            parameters: endpoint.body,
            headers: endpoint.headers
        )
            .validate()
            .responseDecodable { (response: DataResponse<T, AFError>) in
                completion?(response)
            }
    }
}
