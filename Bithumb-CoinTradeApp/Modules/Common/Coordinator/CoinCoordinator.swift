//
//  CoinCoordinator.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/23.
//

import UIKit

final class CoinCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let restAPIRepository: RESTAPIRepositable
    private let webSocketService: WebSocketServiceType
    
    init(
        navigationController: UINavigationController,
        restAPIRepository: RESTAPIRepositable,
        webSocketService: WebSocketServiceType
    ) {
        self.navigationController = navigationController
        self.restAPIRepository = restAPIRepository
        self.webSocketService = webSocketService
    }
    
    func start() {
        let mainTabBarViewController = MainTabBarViewController()
        
        let coinListViewModel = CoinListViewModel(
            webSocketService: webSocketService,
            restAPIRepository: restAPIRepository
        )
        let coinListViewController = CoinListViewController(coordinator: self, viewModel: coinListViewModel)
        
        coinListViewController.tabBarItem = UITabBarItem(title: "코인 목록",
                                                         image: nil,
                                                         selectedImage: nil)
        
        let leaderBoardViewModel: LeaderBoardViewModelType = LeaderBoardViewModel(repository: restAPIRepository)
        let leaderBoardViewController = LeaderBoardViewController(viewModel: leaderBoardViewModel)
        leaderBoardViewController.tabBarItem = UITabBarItem(title: "입출금 현황",
                                                            image: nil,
                                                            selectedImage: nil)
        
        mainTabBarViewController.viewControllers = [coinListViewController, leaderBoardViewController]
        navigationController.pushViewController(mainTabBarViewController, animated: true)
    }
}

// MARK: - CoinListCoordinatable
extension CoinCoordinator: CoinListCoordinatable {
    func showPager(coinName: String) {
        let pagerViewController = PagerViewController(coinName: coinName, coordinator: self)
        navigationController.pushViewController(pagerViewController, animated: true)
    }
}

// MARK: - TransactionHistoryCoodinatable
extension CoinCoordinator: TransactionHistoryCoodinatable {
    
}

// MARK: - PagerCoordinatable
extension CoinCoordinator: PagerCoodinatable {
    func showChart() {
        //
    }

    func showOrderbook() {
        //
    }

    func showTransactionHistory(coinName: String) {
        let viewModel = TransactionHistoryViewModel(coinName: coinName, webSocketService: webSocketService)
        
        let transactionHistoryViewController = TransactionHistoryViewController(coordinator: self, viewModel: viewModel)
        navigationController.pushViewController(transactionHistoryViewController, animated: true)
    }
}
