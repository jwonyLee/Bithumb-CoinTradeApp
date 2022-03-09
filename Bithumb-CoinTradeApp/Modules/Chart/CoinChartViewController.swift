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

final class CoinChartViewController: BaseViewController {
    private let coordinator: CoinListCoordinatable
    private let viewModel: CoinChartViewModel
    
    let chart = CandleStickChartView().then {
        $0.backgroundColor = .white
        $0.noDataText = "no data"
        $0.drawGridBackgroundEnabled = false
        $0.maxVisibleCount = 10
        $0.scaleYEnabled = false
    }
    
    init(
        coordinator: CoinListCoordinatable,
        viewModel: CoinChartViewModel
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        chart.delegate = self
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
        chartDataSet.increasingColor = .systemRed
        chartDataSet.increasingFilled = true
        chartDataSet.decreasingColor = .systemBlue
        chartDataSet.decreasingFilled = true
        chartDataSet.shadowColor = .black
        chartDataSet.shadowWidth = 0.7
        if !data.isEmpty {
            DispatchQueue.main.async {
                self.chart.setVisibleYRange(minYRange: data[data.count-1][4].rawValue/10, maxYRange: data[data.count-1][3].rawValue / 10, axis: .right)

                self.chart.sizeThatFits(CGSize(width: ((Double(data.count))/30.0), height: ((data[data.count-1][3].rawValue) - data[data.count-1][4].rawValue/10) * 3))

                self.chart.zoom(scaleX: ((Double(data.count))/30.0), scaleY: 1, x: CGFloat(Int.max), y: 1)
                self.chart.moveViewTo(xValue: Double(Int.max), yValue: (data[data.count-1][3].rawValue + data[data.count-1][4].rawValue) / 2.0, axis: .right)
            }

        }
//        chart.setScaleMinima(0.99, scaleY: 0.99)
        
        
//        if data.count != 0 {
//            chart.setVisibleXRangeMaximum(1000)
//        }
        
        //radius 조절 : https://github.com/danielgindi/Charts/pull/4625 PR중
//        chartDataSet.barCornerRadius = 3
        let chartData = CandleChartData(dataSet: chartDataSet)
        chart.data = chartData
    }
}

extension CoinChartViewController: ChartViewDelegate {
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("\(scaleX) - \(scaleY)")
    }
}
