//
//  CoinCell.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/02/27.
//

import UIKit
import RxSwift

class CoinCell: UITableViewCell {
    private var disposeBag = DisposeBag()
    
    private let iconLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title1)
    }
    
    private let coinInfoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 2
    }
    
    private let coinNameLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.numberOfLines = 1
    }
        
    private let priceLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.numberOfLines = 0
    }
    
    private let likeButton = UIButton().then {
        $0.tintColor = .systemRed
    }
    
    private lazy var dislikedImage = UIImage(systemName: "heart")
    private lazy var likedImage = UIImage(systemName: "heart.fill")
    
    private var didTapLikeButton: (() -> Void)?
    private var isLiked = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.addSubview(iconLabel)
        contentView.addSubview(coinInfoStackView)
        contentView.addSubview(likeButton)
        
        likeButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.didTapLikeButton?()
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func likeButtonTapped() {
        print("tap")
        likeButton.setImage(likedImage, for: .normal)
        didTapLikeButton?()
    }
    
    private func setConstraints() {
        coinInfoStackView.addArrangedSubview(coinNameLabel)
        coinInfoStackView.addArrangedSubview(priceLabel)

        iconLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(40)
            make.height.greaterThanOrEqualTo(40)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        coinInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(iconLabel.snp.trailing).offset(20)
            make.centerY.equalTo(iconLabel)
            make.trailing.equalTo(likeButton.snp.leading).offset(20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configure(
        viewData: TickerViewData,
        didTapLikeButton: (() -> Void)? = nil
    ) {
        switch viewData.fluctateRateFeeling {
        case TickerViewData.FluctateRateFeeling.veryHigh:
            iconLabel.text = "😆"
        case TickerViewData.FluctateRateFeeling.high:
            iconLabel.text = "🙂"
        case TickerViewData.FluctateRateFeeling.low:
            iconLabel.text = "😭"
        case TickerViewData.FluctateRateFeeling.veryLow:
            iconLabel.text = "😱"
        }
        
        coinNameLabel.text = viewData.coinName
        
        let priceAttributedString = NSMutableAttributedString(string: viewData.price.toCurrencyFormat + "원  ")
        let fluctateRateAttributedString = NSMutableAttributedString(
            string: "\(viewData.fluctateRate)%",
            attributes: [
                .foregroundColor: viewData.fluctateRate.first == "-" ? UIColor.systemBlue : UIColor.systemRed
            ]
        )
        
        priceAttributedString.append(fluctateRateAttributedString)
        
        priceLabel.attributedText = priceAttributedString
        
        self.isLiked = viewData.isLiked
        likeButton.setImage(
            isLiked ? likedImage : dislikedImage,
            for: .normal
        )
        
        self.didTapLikeButton = didTapLikeButton
    }
}
