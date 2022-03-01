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
    private let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        NotificationCenter.default.rx
            .notification(UIContentSizeCategory.didChangeNotification, object: nil)
            .subscribe(with: self) { owner, _ in
                DispatchQueue.main.async {
                    owner.tableView.reloadData()
                }
            }
            .disposed(by: disposeBag)
    }

    override func subscribeUI() {
        let dataObservable = Observable.of(data)
        dataObservable.bind(to: tableView.rx.items) { tableView, _, element in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardTableViewCell.reuseIdentifier) as? LeaderBoardTableViewCell else { return LeaderBoardTableViewCell() }

            cell.configure(name: "비트코인 \(element)")

            return cell
        }
        .disposed(by: disposeBag)
    }
}
