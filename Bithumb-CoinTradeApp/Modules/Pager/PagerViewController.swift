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

final class PagerViewController: BaseViewController {
    private lazy var headerStackView = UIStackView(arrangedSubviews: [transactionHistoryButton, chartButton, orderbookButton]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
    }

    private let transactionHistoryButton = UIButton().then {
        $0.setTitle("체결 내역", for: .normal)
        $0.setTitleColor(.label, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.label.cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    private let chartButton = UIButton().then {
        $0.setTitle("차트", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    private let orderbookButton = UIButton().then {
        $0.setTitle("호가 정보", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    private let containerView: UIView = UIView()

    var transactionHistoryViewController: TransactionHistoryViewController?
    var chartViewController: UIViewController?
    var orderbookViewController: UIViewController?

    private var coordinator: CoinListCoordinatable

    // MARK: - Constants
    private let defaultMargin: CGFloat = 16.0

    init(coordinator: CoinListCoordinatable) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("required init?(coder:) has not implemented.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        add(asChildViewController: transactionHistoryViewController)
    }
    
    // MARK: - setUI
    
    override func setUI() {
        view.addSubviews(headerStackView, containerView)
    }
    
    // MARK: - setConstraint
    
    override func setConstraint() {
        headerStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(defaultMargin)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(defaultMargin)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-defaultMargin)
        }

        containerView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(defaultMargin)
            $0.top.equalTo(headerStackView.snp.bottom).offset(defaultMargin)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-defaultMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - subscribeUI
    
    override func subscribeUI() {
        transactionHistoryButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.add(asChildViewController: owner.transactionHistoryViewController)
                owner.setEnabled(owner.transactionHistoryButton)
            }
            .disposed(by: disposeBag)
        chartButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.add(asChildViewController: owner.chartViewController)
                owner.setEnabled(owner.chartButton)
            }
            .disposed(by: disposeBag)
        orderbookButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.add(asChildViewController: owner.orderbookViewController)
                owner.setEnabled(owner.orderbookButton)
            }
            .disposed(by: disposeBag)
    }

    private func add(asChildViewController child: UIViewController?) {
        guard let child = child else {
            return
        }

        addChild(child)
        containerView.addSubviews(child.view)

        child.view.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }

        child.didMove(toParent: self)
    }

    private func remote(asChildViewController child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

    private func setEnabled(_ button: UIButton) {
        headerStackView.arrangedSubviews
            .compactMap { $0 as? UIButton }
            .forEach {
                if $0 == button {
                    $0.layer.borderColor = UIColor.label.cgColor
                    $0.setTitleColor(.label, for: .normal)
                } else {
                    $0.layer.borderColor = UIColor.gray.cgColor
                    $0.setTitleColor(.gray, for: .normal)
                }
            }
    }
}
