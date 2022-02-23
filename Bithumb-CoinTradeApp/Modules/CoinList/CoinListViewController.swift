//
//  CoinListViewController.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/23.
//

import UIKit

import RxCocoa
import SnapKit
import Then

protocol CoinListCoordinatable {
    func showPager()
}

final class CoinListViewController: BaseViewController {
    private var coordinator: CoinListCoordinatable

    init(coordinator: CoinListCoordinatable) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("required init?(coder:) has not implemented.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton().then {
            $0.setTitle("누르면 Pager로 넘어가요", for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.sizeToFit()
        }

        button.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.coordinator.showPager()
            }
            .disposed(by: disposeBag)
        view.addSubview(button)

        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
}
