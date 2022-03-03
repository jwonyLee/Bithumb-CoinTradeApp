//
//  CoinCoordinator.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/02/23.
//

import UIKit

final class CoinCoordinator: Coordinator {
    var navigationController: UINavigationController
    var repository: RESTAPIRepositable
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.repository = RESTAPIRepository()
    }
    
    func start() {
        let mainTabBarViewController = MainTabBarViewController()
        let coinListViewController = CoinListViewController(coordinator: self)
        coinListViewController.tabBarItem = UITabBarItem(title: "코인 목록",
                                                         image: nil,
                                                         selectedImage: nil)
        let leaderBoardViewModel: LeaderBoardViewModelType = LeaderBoardViewModel(repository: repository)
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
