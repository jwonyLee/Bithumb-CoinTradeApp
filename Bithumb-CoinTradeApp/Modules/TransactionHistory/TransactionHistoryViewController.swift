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
    private let coordinator: TransactionHistoryCoodinatable
    private let viewModel: TransactionHistoryViewModelType
    
    private let header = UITextView().then {
        $0.text = "시간, 가격, 채결량"
        $0.sizeToFit()
    }
    
    private lazy var tableView = UITableView().then {
        $0.register(TransactionHistoryCell.self, forCellReuseIdentifier: TransactionHistoryCell.reuseIdentifier)
        $0.rowHeight = 30
        $0.tableHeaderView = header
    }
    
    private var dataSource: UITableViewDiffableDataSource<Int, TransactionHistoryViewData>?

    init(
        coordinator: TransactionHistoryCoodinatable,
        viewModel: TransactionHistoryViewModelType
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        
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
        view.addSubview(tableView)
        
        configureDataSource()
    }
    
    // MARK: - setConstraint
    
    override func setConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - bind
    
    override func bind() {
        viewModel.transactionListObservable
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, transactionHistory in
                owner.loadHistory(transactionHistory)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - subscribeUI
    
    override func subscribeUI() {
    }
    
    // MARK: - Helpers
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionHistoryCell.reuseIdentifier, for: indexPath) as? TransactionHistoryCell else { return UITableViewCell() }
            
            cell.configure(viewData: itemIdentifier)
            
            return cell
        })
        
        dataSource?.defaultRowAnimation = .none
        tableView.dataSource = dataSource
    }
    
    private func loadHistory(_ transactionHistory: [TransactionHistoryViewData]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, TransactionHistoryViewData>()
        snapShot.appendSections([0])
        snapShot.appendItems(transactionHistory)
        
        dataSource?.apply(snapShot)
    }
}
