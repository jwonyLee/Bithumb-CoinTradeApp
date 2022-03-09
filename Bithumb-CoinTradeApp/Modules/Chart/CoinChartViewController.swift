//
//  CoinChartViewController.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/08.
//

import Foundation

import RxCocoa
import SnapKit
import Then
import Charts

protocol CoinChartCoodinatable {
}

final class CoinChartViewController: BaseViewController {
    private let coordinator: CoinChartCoodinatable
    private let viewModel: CoinChartViewModel
    
    let chart = CandleStickChartView().then {
        $0.backgroundColor = .white
        $0.noDataText = "no data"
    }
    
    init(
        coordinator: CoinChartCoodinatable,
        viewModel: CoinChartViewModel
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
        view.addSubview(chart)
    }
    
    // MARK: - setConstraint
    
    override func setConstraint() {
        chart.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - bind
    
    override func bind() {
        viewModel.coinChartObservable
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, candlestickData in
                owner.setChart(data: candlestickData)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - subscribeUI
    
    override func subscribeUI() {
    }
    
    // MARK: - Helpers
    private func setChart(data: [[CandlestickData]]) {
        var index = 0
        var myEntries: [CandleChartDataEntry] = []
        for element in data {
//            let timestanp = element[0].rawValue
            let startPrice = element[1].rawValue
            let endPrice = element[2].rawValue
            let maxPrice = element[3].rawValue
            let minPrice = element[4].rawValue
//            let amount = element[5].rawValue
            
            let dataEntry = CandleChartDataEntry(x: Double(index), shadowH: maxPrice, shadowL: minPrice, open: startPrice, close: endPrice)
            index += 1
            myEntries.append(dataEntry)
        }
        
        let chartDataSet = CandleChartDataSet(entries: myEntries, label: "데이터셋1")
        //색상 세팅
        chartDataSet.increasingColor = .red
        chartDataSet.increasingFilled = true
        chartDataSet.decreasingColor = .blue
        chartDataSet.decreasingFilled = true
        chartDataSet.shadowColor = .black
        chartDataSet.shadowWidth = 0.7
        
        //radius 조절 : https://github.com/danielgindi/Charts/pull/4625 PR중
//        chartDataSet.barCornerRadius = 3
        let chartData = CandleChartData(dataSet: chartDataSet)
        chart.data = chartData
    }
}
