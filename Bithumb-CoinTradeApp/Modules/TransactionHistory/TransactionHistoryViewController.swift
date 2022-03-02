//
//  TransactionHistoryViewController.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/02.
//

import UIKit

import RxCocoa
import SnapKit
import Then

protocol TransactionHistoryCoodinatable {
}

final class TransactionHistoryViewController: BaseViewController {
    private var coordinator: TransactionHistoryCoodinatable

    init(coordinator: TransactionHistoryCoodinatable) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("required init?(coder:) has not implemented.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - setUI
    
    override func setUI() {
    }
    
    // MARK: - setConstraint
    
    override func setConstraint() {
    }
    
    // MARK: - subscribeUI
    
    override func subscribeUI() {
    }
}
