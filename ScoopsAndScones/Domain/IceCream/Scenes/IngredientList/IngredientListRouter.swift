//
//  IngredientListRouter.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/16.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol IngredientListRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol IngredientListDataPassing {
    var dataStore: IngredientListDataStore? { get }
}

class IngredientListRouter: NSObject, IngredientListRoutingLogic, IngredientListDataPassing {
    
    weak var viewController: IngredientListViewController?
    var dataStore: IngredientListDataStore?
    
    // MARK: Routing
    
//    func routeToSomewhere(segue: UIStoryboardSegue?) {
//        if let segue = segue {
//            let destinationVC = segue.destination as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//            navigateToSomewhere(source: viewController!, destination: destinationVC)
//        }
//    }
    
    // MARK: Navigation
    
//    func navigateToSomewhere(source: IngredientListViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
    
    // MARK: Passing data
    
//    func passDataToSomewhere(source: IngredientListDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
