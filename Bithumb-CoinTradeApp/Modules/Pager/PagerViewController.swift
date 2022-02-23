//
//  PagerViewController.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/23.
//

import UIKit

protocol PagerCoodinatable {
    func showChart()
    func showOrderbook()
    func showTransactionHistory()
}

final class PagerViewController: BaseViewController {
    private var coordinator: PagerCoodinatable

    init(coordinator: PagerCoodinatable) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("required init?(coder:) has not implemented.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
