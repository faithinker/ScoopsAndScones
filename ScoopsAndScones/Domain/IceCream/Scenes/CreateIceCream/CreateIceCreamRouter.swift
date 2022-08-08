//
//  CreateIceCreamRouter.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol CreateIceCreamRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CreateIceCreamDataPassing {
    var dataStore: CreateIceCreamDataStore? { get }
}

class CreateIceCreamRouter: NSObject, CreateIceCreamRoutingLogic, CreateIceCreamDataPassing {
    
    weak var viewController: CreateIceCreamViewController?
    var dataStore: CreateIceCreamDataStore?
    
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
    
//    func navigateToSomewhere(source: CreateIceCreamViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
    
    // MARK: Passing data
    
//    func passDataToSomewhere(source: CreateIceCreamDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
