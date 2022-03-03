//
//  Coordinator.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var repository: RESTAPIRepositable { get set }
    func start()
    func back()
}

extension Coordinator {
    func back() {
        navigationController.popViewController(animated: true)
    }
}
