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

    let tableView = UITableView().then {
        $0.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseIdentifier)
        $0.estimatedRowHeight = 80
        $0.rowHeight = UITableView.automaticDimension
    }
    
    var dataSource: UITableViewDiffableDataSource<Int, String>?
    
    init(coordinator: CoinListCoordinatable) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("required init?(coder:) has not implemented.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUI() {
        view.addSubview(tableView)
        
        configureDataSource()
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, String>()
        snapShot.appendSections([0])
        snapShot.appendItems(["1", "2", "3"])
        dataSource?.apply(snapShot)
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.reuseIdentifier, for: indexPath) as? CoinCell else { return UITableViewCell() }
            
            cell.configure(
                icon: nil,
                coinName: itemIdentifier,
                price: itemIdentifier,
                fluctateRate: itemIdentifier,
                isLiked: false) { [weak self] in
                    self?.didTapLikeButton(itemIdentifier)
                }
            
            return cell
        })
        
        tableView.dataSource = dataSource
    }
    
    override func setConstraint() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        
    }
    
    override func subscribeUI() {
        
    }
    
    func didTapLikeButton(_ id: String) {
        print("like button tapped", id)
    }
}
