//
//  OrderBookViewController.swift.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/09.
//

import UIKit

class OrderBookViewController: BaseViewController {
    private let viewModel: OrderBookViewModelType
    
    private let tableView = UITableView().then {
        $0.estimatedRowHeight = 50
        $0.rowHeight = UITableView.automaticDimension
        $0.register(OrderBookCell.self, forCellReuseIdentifier: OrderBookCell.reuseIdentifier)
        $0.separatorStyle = .none
    }
    
    private var dataSource: UITableViewDiffableDataSource<Int, OrderBookViewData>?
    
    init(
        viewModel: OrderBookViewModelType
    ) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init?(coder:) has not implemented.")
    }
    
    // MARK: - setUI

    override func setUI() {
        view.addSubviews(tableView)
        
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
        viewModel.orderBookObservable
            .subscribe(with: self, onNext: { owner, orderBooks in
                owner.reloadOrderBooks(orderBooks)
            })
            .disposed(by: disposeBag)
    }
    
    private func reloadOrderBooks(_ orderBooks: [OrderBookViewData]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, OrderBookViewData>()
        snapShot.appendSections([0])
        snapShot.appendItems(orderBooks)
        
        dataSource?.apply(snapShot, animatingDifferences: false)
    }
    
    // MARK: - subscribeUI
    
    override func subscribeUI() {
        
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderBookCell.reuseIdentifier, for: indexPath) as? OrderBookCell else { return UITableViewCell() }
            
            cell.configure(viewData: itemIdentifier)
            
            return cell
        })
        
        dataSource?.defaultRowAnimation = .none
        tableView.dataSource = dataSource
    }
}
