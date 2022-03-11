//
//  LeaderBoardTableViewCell.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/03/01.
//

import UIKit

final class LeaderBoardTableViewCell: UITableViewCell {
    // MARK: - Views
    private let iconLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    private let titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.font = UIFont.preferredFont(forTextStyle: .headline)
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

    private var statusEmoji: (Bool, Bool) -> String = {
        switch ($0, $1) {
        case (true, true):
            return "🥰"
        case (true, false):
            return "🥺"
        case (false, true):
            return "😕"
        case (false, false):
            return "😩"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not implemented.")
    }

    func configure(name: String, canDeposit: Bool, canWithDrawal: Bool) {
        iconLabel.text = statusEmoji(canDeposit, canWithDrawal)
        titleLabel.text = name
        topDescriptionLabel.configure(
            text: "입금 가능",
            image: canDeposit ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "xmark.circle"),
            imageColor: canDeposit ? .systemGreen : .systemRed
        )
        bottomDescriptionLabel.configure(
            text: "출금 가능",
            image: canWithDrawal ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "xmark.circle"),
            imageColor: canWithDrawal ? .systemGreen : .systemRed
        )
    }

    private func setUI() {
        contentView.addSubviews(iconLabel, titleLabel, descriptionStack)

        // TODO: 동적으로 accessibilityLabel 변경
        topDescriptionLabel.accessibilityLabel = "입금 가능"
        bottomDescriptionLabel.accessibilityLabel = "출금 불가능"
    }

    private func setConstraint() {
        iconLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.layoutMarginsGuide.snp.leading).offset(8)
            $0.top.equalTo(contentView.layoutMarginsGuide.snp.top).offset(16)
            $0.bottom.equalTo(contentView.layoutMarginsGuide.snp.bottom).offset(-16)
            $0.height.equalTo(iconLabel.snp.width)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconLabel.snp.trailing).offset(8)
            $0.top.equalTo(iconLabel.snp.top)
            $0.trailing.equalTo(descriptionStack.snp.leading).offset(-8)
            $0.bottom.equalTo(iconLabel.snp.bottom)
        }

        descriptionStack.snp.makeConstraints {
            $0.top.equalTo(iconLabel.snp.top)
            $0.trailing.equalTo(contentView.layoutMarginsGuide.snp.trailing).offset(-8)
            $0.bottom.equalTo(iconLabel.snp.bottom)
        }
    }
}
