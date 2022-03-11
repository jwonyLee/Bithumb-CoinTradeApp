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
    func showPager(coinName: String)
}

enum CoinListType {
    case krw
    case like
    case popular
}

final class CoinListViewController: BaseViewController {
    private let coordinator: CoinListCoordinatable
    private let viewModel: CoinListViewModelType
    
    private let headerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
    }
    
    private let krwButton = UIButton().then {
        $0.setTitle("원화", for: .normal)
        $0.setTitleColor(.label, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.label.cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let likeButton = UIButton().then {
        $0.setTitle("관심", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let popularButton = UIButton().then {
        $0.setTitle("인기", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    private let tableView = UITableView().then {
        $0.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseIdentifier)
        $0.estimatedRowHeight = 80
        $0.rowHeight = UITableView.automaticDimension
    }
    
    private var dataSource: UITableViewDiffableDataSource<Int, TickerViewData>?
    private var currentListType: CoinListType = .krw
    
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
        navigationItem.title = "코인 목록"

        view.addSubview(headerStackView)
        view.addSubview(tableView)
        
        headerStackView.addArrangedSubview(krwButton)
        headerStackView.addArrangedSubview(likeButton)
        headerStackView.addArrangedSubview(popularButton)
        
        configureDataSource()
    }
    
    // MARK: - setConstraint
    
    override func setConstraint() {
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        krwButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        likeButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        popularButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
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
        krwButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                guard owner.currentListType != .krw else { return }
                
                owner.deselectHeaderButtons()
                owner.selectHeaderButton(.krw)
                owner.currentListType = .krw
                
                owner.viewModel.changeList(to: .krw)
            })
            .disposed(by: disposeBag)
        
        likeButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                guard owner.currentListType != .like else { return }
                
                owner.deselectHeaderButtons()
                owner.selectHeaderButton(.like)
                owner.currentListType = .like
                
                owner.viewModel.changeList(to: .like)
            })
            .disposed(by: disposeBag)

        popularButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                guard owner.currentListType != .popular else { return }
                
                owner.deselectHeaderButtons()
                owner.selectHeaderButton(.popular)
                owner.currentListType = .popular
                
                owner.viewModel.changeList(to: .popular)
            })
            .disposed(by: disposeBag)
    }
    
    private func selectHeaderButton(_ type: CoinListType) {
        switch type {
        case .krw:
            krwButton.setTitleColor(.label, for: .normal)
            krwButton.layer.borderColor = UIColor.label.cgColor
        case .like:
            likeButton.setTitleColor(.label, for: .normal)
            likeButton.layer.borderColor = UIColor.label.cgColor
        case .popular:
            popularButton.setTitleColor(.label, for: .normal)
            popularButton.layer.borderColor = UIColor.label.cgColor
        }
    }
    
    private func deselectHeaderButtons() {
        let deselectedColor = UIColor.gray
        
        krwButton.setTitleColor(deselectedColor, for: .normal)
        krwButton.layer.borderColor = deselectedColor.cgColor
        likeButton.setTitleColor(deselectedColor, for: .normal)
        likeButton.layer.borderColor = deselectedColor.cgColor
        popularButton.setTitleColor(deselectedColor, for: .normal)
        popularButton.layer.borderColor = deselectedColor.cgColor
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
        tableView.delegate = self
    }
    
    private func loadCoins(_ coins: [TickerViewData]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, TickerViewData>()
        snapShot.appendSections([0])
        snapShot.appendItems(coins)
        
        dataSource?.apply(snapShot, animatingDifferences: false)
    }
    
    private func didTapLikeButton(_ coinName: String) {
        viewModel.changeLikeState(coinName)
    }
}

extension CoinListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator.showPager(coinName: dataSource?.itemIdentifier(for: indexPath)?.coinName ?? "")
    }
}
