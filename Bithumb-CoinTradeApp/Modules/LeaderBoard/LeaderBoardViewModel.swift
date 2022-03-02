//
//  LeaderBoardViewModel.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/03/02.
//

import Foundation

import RxSwift
import RxRelay

protocol LeaderBoardViewModelType {
    var disposeBag: DisposeBag { get set }
    var assetStatusRelay: BehaviorRelay<AssetStatus?> { get set }
    var repository: RESTAPIRepositable { get set }
    func fetchAssetStatus()
}

final class LeaderBoardViewModel: LeaderBoardViewModelType {
    // MARK: - Rx
    var disposeBag = DisposeBag()
    var assetStatusRelay: BehaviorRelay<AssetStatus?> = BehaviorRelay<AssetStatus?>(value: nil)

    // MARK: - Properties
    var repository: RESTAPIRepositable

    init(repository: RESTAPIRepositable) {
        self.repository = repository
        fetchAssetStatus()
    }

    func fetchAssetStatus() {
        repository.requestAssetStatus(orderCurrency: "ALL")
            .subscribe(with: self) { owner, assetStatus in
                owner.assetStatusRelay.accept(assetStatus)
            }
            .disposed(by: disposeBag)
    }
}
