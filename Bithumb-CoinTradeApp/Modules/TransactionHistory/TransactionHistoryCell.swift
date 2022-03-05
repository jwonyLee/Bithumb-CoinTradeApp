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
        contentView.addSubview(stackView)
    }
    
    private func setConstraints() {
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(quantityLabel)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(
        viewData: TransactionHistoryViewData
    ) {
        dateLabel.text = viewData.transactionDate
        
        priceLabel.text = String(format: "%.0f", viewData.price)
        quantityLabel.text = String(format: "%.4f", viewData.quantity)
        
        if viewData.type == .bid {
            priceLabel.textColor = .red
            quantityLabel.textColor = .red
        } else {
            priceLabel.textColor = .blue
            quantityLabel.textColor = .blue
        }
    }
}
