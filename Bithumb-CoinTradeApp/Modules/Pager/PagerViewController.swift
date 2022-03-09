//
//  PagerViewController.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/23.
//

import UIKit

import RxCocoa
import SnapKit
import Then

protocol PagerCoodinatable {
    func showChart()
    func showOrderbook()
    func showTransactionHistory(coinName: String)
    func showChart(coinName: String)
}

final class PagerViewController: BaseViewController {
    private var coinName: String
    
    private let transactionHistoryButton = UIButton().then {
        $0.setTitle("채결 내역", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    private let chartButton = UIButton().then {
        $0.setTitle("차트", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    private var coordinator: PagerCoodinatable

    init(
        coinName: String,
        coordinator: PagerCoodinatable
    ) {
        self.coinName = coinName
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
        view.addSubview(transactionHistoryButton)
        view.addSubview(chartButton)
    }
    
    // MARK: - setConstraint
    
    override func setConstraint() {
        transactionHistoryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        chartButton.snp.makeConstraints { make in
            make.top.equalTo(transactionHistoryButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    // MARK: - subscribeUI
    
    override func subscribeUI() {
        transactionHistoryButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator.showTransactionHistory(coinName: owner.coinName)
            })
            .disposed(by: disposeBag)
        
        chartButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.coordinator.showChart(coinName: owner.coinName)
            })
            .disposed(by: disposeBag)
    }
}
