//
//  CoinCoordinator.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/23.
//

import UIKit

final class CoinCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainTabBarViewController = MainTabBarViewController()
        let coinListViewModel = CoinListViewModel()
        let coinListViewController = CoinListViewController(coordinator: self, viewModel: coinListViewModel)
        
        coinListViewController.tabBarItem = UITabBarItem(title: "코인 목록",
                                                         image: nil,
                                                         selectedImage: nil)
        let leaderBoardViewController = LeaderBoardViewController()
        leaderBoardViewController.tabBarItem = UITabBarItem(title: "입출금 현황",
                                                            image: nil,
                                                            selectedImage: nil)
        mainTabBarViewController.viewControllers = [coinListViewController, leaderBoardViewController]
        navigationController.pushViewController(mainTabBarViewController, animated: true)
    }
}

// MARK: - CoinListCoordinatable
extension CoinCoordinator: CoinListCoordinatable {
    func showPager() {
        let pagerViewController = PagerViewController(coordinator: self)
        navigationController.pushViewController(pagerViewController, animated: true)
    }
}

// MARK: - PagerCoordinatable
extension CoinCoordinator: PagerCoodinatable {
    func showChart() {
        //
    }

    func showOrderbook() {
        //
    }

    func showTransactionHistory() {
        //
    }
}
