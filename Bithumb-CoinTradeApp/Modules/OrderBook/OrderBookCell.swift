//
//  OrderBookCell.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/03/09.
//

import UIKit

class OrderBookCell: UITableViewCell {
    private let askQuantityLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.textColor = .systemBlue
        $0.isHidden = true
    }
    
    private let priceLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .caption1)
    }
    
    private let bidQuantityLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.textColor = .systemRed
        $0.isHidden = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        askQuantityLabel.isHidden = true
        bidQuantityLabel.isHidden = true
    }
    
    private func setUI() {
        contentView.addSubviews(
            priceLabel,
            askQuantityLabel,
            bidQuantityLabel
        )
    }
    
    private func setConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        askQuantityLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(priceLabel)
        }
        
        bidQuantityLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(priceLabel)
        }
    }
    
    func configure(viewData: OrderBookViewData) {
        priceLabel.text = "\(viewData.priceToDouble.toCurrencyFormat) 원"
        
        switch viewData.orderType {
        case .ask:
            askQuantityLabel.text = viewData.quantity
            askQuantityLabel.isHidden = false
        case .bid:
            bidQuantityLabel.text = viewData.quantity
            bidQuantityLabel.isHidden = false
        }
    }
}
