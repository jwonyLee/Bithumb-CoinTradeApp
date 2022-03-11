//
//  TransactionHistoryCell.swift
//  Bithumb-CoinTradeApp
//
//  Created by temp2 on 2022/03/02.
//

import UIKit
import RxSwift

class TransactionHistoryCell: UITableViewCell {
    private var disposeBag = DisposeBag()
    
    private let dateLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    
    private let priceLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    
    private let quantityLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
//        contentView.addSubview(stackView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityLabel)
    }
    
    private func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        priceLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom)
        }
        quantityLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom)
        }
    }
    
    func configure(
        viewData: TransactionHistoryViewData
    ) {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SS"
        
        let date = dateFormatter.date(from: viewData.transactionDate)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateLabel.text = dateFormatter.string(from: date ?? Date())
        
        priceLabel.text = String(format: "%.0f", viewData.price)
        quantityLabel.text = String(format: "%.4f", viewData.quantity)
        
        if viewData.type == .bid {
            priceLabel.textColor = .systemRed
            quantityLabel.textColor = .systemRed
        } else {
            priceLabel.textColor = .systemBlue
            quantityLabel.textColor = .systemBlue
        }
    }
}
