//
//  CreateIceCreamImageView.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/31.
//

import UIKit

class CreateIceCreamImageView: UIView {
    
    var selectedCone: String = "" {
        willSet {
            coneImage.image = UIImage(named: newValue)
        }
    }
    var selectedFlavor: String = "" {
        willSet {
            flavorImage.image = UIImage(named: newValue)
        }
    }
    var selectedTopping: String = "" {
        willSet {
            toppingImage.image = UIImage(named: newValue)
        }
    }
    
    private var coneImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var flavorImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var toppingImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubviews([coneImage, flavorImage, toppingImage])
        
        coneImage.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(220)
        }
        flavorImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(coneImage.snp.top).offset(70)
            $0.width.equalTo(120)
            $0.height.equalTo(120)
        }
        toppingImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(flavorImage.snp.centerY).offset(60)
            $0.width.equalTo(120)
            $0.height.equalTo(120)
        }
    }
}
