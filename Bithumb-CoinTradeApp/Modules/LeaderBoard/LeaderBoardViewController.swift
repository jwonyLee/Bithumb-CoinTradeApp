//
//  LeaderBoardViewController.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/23.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class LeaderBoardViewController: BaseViewController {
    // MARK: - Views
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Properties
    private var viewModel: LeaderBoardViewModelType

    init(viewModel: LeaderBoardViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not implemented.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAssetStatus()
    }

    override func setUI() {
        navigationItem.searchController = searchController
        view.addSubview(tableView)

        tableView.register(
            LeaderBoardTableViewCell.self,
            forCellReuseIdentifier: LeaderBoardTableViewCell.reuseIdentifier
        )
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func setConstraint() {
        tableView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }

    override func bind() {
        viewModel.assetStatusRelay
            .compactMap { $0?.data }
            .bind(to: tableView.rx.items(
                cellIdentifier: LeaderBoardTableViewCell.reuseIdentifier,
                cellType: LeaderBoardTableViewCell.self
            )) { _, element, cell in
                guard let value = element.value else {
                    return
                }
                let canDeposit = value.depositStatus == 1 ? true : false
                let canWithDrawal = value.withdrawalStatus == 1 ? true : false
                cell.configure(name: element.key, canDeposit: canDeposit, canWithDrawal: canWithDrawal)
            }
            .disposed(by: disposeBag)
    }

    override func subscribeUI() {}
}
