//
//  LeaderBoardTableViewCell.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/03/01.
//

import UIKit

final class LeaderBoardTableViewCell: UITableViewCell {
    // MARK: - Views
    private let iconImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.backgroundColor = .blue
    }
    private let titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
        $0.text = "비트코인"
        $0.textColor = .label
        $0.numberOfLines = 0
    }
    private let topDescriptionLabel = LabelWithRoundImageView().then {
        $0.isAccessibilityElement = true
    }
    private let bottomDescriptionLabel = LabelWithRoundImageView().then {
        $0.isAccessibilityElement = true
    }

    private lazy var descriptionStack = UIStackView(
        arrangedSubviews: [topDescriptionLabel, bottomDescriptionLabel]
    ).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 8
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not implemented.")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.iconImageView.layer.cornerRadius = self.iconImageView.frame.height / 2
        }
    }

    func configure(name: String) {
        titleLabel.text = name
    }

    private func setUI() {
        contentView.addSubviews(iconImageView, titleLabel, descriptionStack)

        topDescriptionLabel.configure(text: "입금 가능", image: UIImage(systemName: "checkmark.circle"))
        bottomDescriptionLabel.configure(text: "출금 가능", image: UIImage(systemName: "xmark.circle"))
        // TODO: 동적으로 accessibilityLabel 변경
        topDescriptionLabel.accessibilityLabel = "입금 가능"
        bottomDescriptionLabel.accessibilityLabel = "출금 불가능"
    }

    private func setConstraint() {
        iconImageView.snp.makeConstraints {
            $0.leading.equalTo(contentView.layoutMarginsGuide.snp.leading).offset(8)
            $0.top.equalTo(contentView.layoutMarginsGuide.snp.top).offset(16)
            $0.bottom.equalTo(contentView.layoutMarginsGuide.snp.bottom).offset(-16)
            $0.height.equalTo(iconImageView.snp.width)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
            $0.top.equalTo(iconImageView.snp.top)
            $0.trailing.equalTo(descriptionStack.snp.leading).offset(-8)
            $0.bottom.equalTo(iconImageView.snp.bottom)
        }

        descriptionStack.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.top)
            $0.trailing.equalTo(contentView.layoutMarginsGuide.snp.trailing).offset(-8)
            $0.bottom.equalTo(iconImageView.snp.bottom)
        }
    }
}
