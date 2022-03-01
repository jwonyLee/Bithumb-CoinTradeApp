//
//  UIView+.swift
//  Bithumb-CoinTradeApp
//
//  Created by 이지원 on 2022/03/01.
//

import UIKit.UIView

extension UIView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }

    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
