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
    private let coordinator: CoinListCoordinatable
    private let viewModel: CoinListViewModelType

    private let tableView = UITableView().then {
        $0.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseIdentifier)
        $0.estimatedRowHeight = 80
        $0.rowHeight = UITableView.automaticDimension
    }
    
    private var dataSource: UITableViewDiffableDataSource<Int, TickerViewData>?
    
    init(
        coordinator: CoinListCoordinatable,
        viewModel: CoinListViewModelType
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - bind
    
    override func bind() {
        viewModel.coinListObservable
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, coins in
                owner.loadCoins(coins)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - subscribeUI
    
    override func subscribeUI() {
        
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.reuseIdentifier, for: indexPath) as? CoinCell else { return UITableViewCell() }
            
            cell.configure(
                viewData: itemIdentifier,
                didTapLikeButton: { [weak self] in
                    self?.didTapLikeButton(itemIdentifier.coinName)
                }
            )
            
            return cell
        })
        
        dataSource?.defaultRowAnimation = .none
        tableView.dataSource = dataSource
    }
    
    private func loadCoins(_ coins: [TickerViewData]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, TickerViewData>()
        snapShot.appendSections([0])
        snapShot.appendItems(coins)
        
        dataSource?.apply(snapShot)
    }
    
    private func didTapLikeButton(_ coinName: String) {
        viewModel.changeLikeState(coinName)
    }
}
