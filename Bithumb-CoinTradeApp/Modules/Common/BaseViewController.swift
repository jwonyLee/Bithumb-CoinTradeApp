//
//  BaseViewController.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/23.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    // MARK: - Rx
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setUI()
        setConstraint()
        bind()
        subscribeUI()
    }

    /// add Views
    func setUI() { }

    /// setup Constraint
    func setConstraint() { }

    /// ViewModel Event -> View
    func bind() { }

    /// View Event
    func subscribeUI() { }
}
