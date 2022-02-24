//
//  Endpoint.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/02/24.
//

import Foundation
import Alamofire

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    // a default extension that creates the full URL
    var url: String {
        return baseURLString + path
    }
}
