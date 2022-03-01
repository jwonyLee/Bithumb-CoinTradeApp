//
//  CoinCell.swift
//  Bithumb-CoinTradeApp
//
//  Created by jaeyoung Yun on 2022/02/27.
//

import UIKit
import RxSwift

class CoinCell: UITableViewCell {
    static let reuseIdentifier = NSStringFromClass(CoinCell.self)
    private var disposeBag = DisposeBag()
    
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .init(systemName: "bitcoinsign.circle")
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
        $0.tintColor = .red
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
        contentView.addSubview(iconImageView)
        contentView.addSubview(coinInfoStackView)
        contentView.addSubview(likeButton)
        
        likeButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.isLiked.toggle()
                owner.likeButton.setImage(
                    owner.isLiked ? owner.likedImage : owner.dislikedImage,
                    for: .normal
                )
                
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

        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(40)
            make.height.greaterThanOrEqualTo(40)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        coinInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.centerY.equalTo(iconImageView)
            make.trailing.equalTo(likeButton.snp.leading).offset(20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configure(
        icon: UIImage? = nil,
        coinName: String,
        price: String,
        fluctateRate: String,
        isLiked: Bool,
        didTapLikeButton: (() -> Void)? = nil
    ) {
        if let icon = icon {
            iconImageView.image = icon
        }
        
        coinNameLabel.text = coinName
        
        let priceAttributedString = NSMutableAttributedString(string: price + "원  ")
        let fluctateRateAttributedString = NSMutableAttributedString(
            string: "-\(price)%",
            attributes: [.foregroundColor: UIColor.blue]
        )
        
        priceAttributedString.append(fluctateRateAttributedString)
        
        priceLabel.attributedText = priceAttributedString
        
        self.isLiked = isLiked
        likeButton.setImage(
            isLiked ? likedImage : dislikedImage,
            for: .normal
        )
        
        self.didTapLikeButton = didTapLikeButton
    }
}
