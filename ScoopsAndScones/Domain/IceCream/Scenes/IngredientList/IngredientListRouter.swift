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
    
    func routeToHome(with ingredient: String)
}

protocol IngredientListDataPassing {
    var dataStore: IngredientListDataStore? { get set }
}

class IngredientListRouter: NSObject, IngredientListRoutingLogic, IngredientListDataPassing {
    
    weak var navigationController: UINavigationController?
    
    weak var viewController: IngredientListViewController?
    var dataStore: IngredientListDataStore?
    
    // MARK: Routing
    func routeToHome(with ingredient: String) {
        //guard let createIceCreamVC = navigationController?.viewControllers.first(where: { $0 is CreateIceCreamViewController }) else { print("Error"); return }
        
//        let createIceCreamVC = navigationController?.viewControllers.first as! CreateIceCreamViewController
//
//        createIceCreamVC.selectedItems[0] = ingredient
        
        navigationController?.popViewController(animated: true)
        //viewController?.dismiss(animated: true)
    }
}
