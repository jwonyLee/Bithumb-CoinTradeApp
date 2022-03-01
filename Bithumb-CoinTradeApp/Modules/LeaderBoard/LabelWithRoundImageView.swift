//
//  LabelWithRoundImageView.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/03/01.
//

import UIKit

final class LabelWithRoundImageView: UIView {
    // MARK: - Views
    private let label = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontForContentSizeCategory = true
        $0.isAccessibilityElement = false
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.text = "입금 가능"
        $0.numberOfLines = 0
    }
    private let imageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    private lazy var stackView = UIStackView(arrangedSubviews: [label, imageView]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fill
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.layer.cornerRadius = imageView.layer.bounds.width / 2
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not implemented.")
    }

    func configure(text: String?, image: UIImage?) {
        label.text = text
        imageView.image = image
    }

    private func setupUI() {
        addSubview(stackView)
    }

    private func setConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
