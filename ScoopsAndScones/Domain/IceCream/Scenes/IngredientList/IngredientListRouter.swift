//
//  IngredientListRouter.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/16.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol IngredientListRoutingLogic {
    var navigationController: UINavigationController? { get set }
    
    func routeToHome(with ingredient: String, index: Int)
}

protocol IngredientListDataPassing {
    var dataStore: IngredientListDataStore? { get set }
}

class IngredientListRouter: NSObject, IngredientListRoutingLogic, IngredientListDataPassing {
    
    weak var navigationController: UINavigationController?
    
    weak var viewController: IngredientListViewController?
    var dataStore: IngredientListDataStore?
    
    // MARK: Routing
    func routeToHome(with ingredient: String, index: Int) {
        
        guard let createIceCreamVC = navigationController?.viewControllers.first as? CreateIceCreamViewController else { print("As Transfrom Fail"); return }
        
        
        var tempValue = createIceCreamVC.selectedItems.value
        tempValue[index] = ingredient
        
        createIceCreamVC.selectedItems.accept(tempValue)
        
        
        navigationController?.popViewController(animated: true)
    }
}
