//
//  UIView+.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        _ = views.map { self.addSubview($0) }
    }
}
