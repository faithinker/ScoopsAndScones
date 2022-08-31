//
//  IceCreamCell.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import NSObject_Rx

class IceCreamCell: UITableViewCell {
    static let identifier = String(describing: IceCreamCell.self)
    
    var selectedIngredient: String {
        get { return "" }
        set {
            selectedItem.text = newValue
        }
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
        $0.text = "Select Cone"
    }
    
    private lazy var selectedItem = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
        $0.text = "selectedItem"
    }
    
    private lazy var detailButton = UIImageView(image: UIImage(systemName: "chevron.right")).then {
        $0.tintColor = .systemGray4
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel, selectedItem, detailButton])
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        detailButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
        }
        selectedItem.snp.makeConstraints {
            $0.trailing.equalTo(detailButton.snp.leading).offset(-15)
            $0.centerY.equalToSuperview()
        }
    }
    
    public func configure(_ titleText: String) {
        titleLabel.text = titleText
    }
}
