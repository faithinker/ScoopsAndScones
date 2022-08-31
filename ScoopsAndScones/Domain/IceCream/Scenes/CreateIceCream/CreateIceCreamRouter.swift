//
//  CreateIceCreamRouter.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

protocol CreateIceCreamRoutingLogic {
    var navigationController: UINavigationController? { get }
    
    var routeToIngredientListRelay: PublishRelay<Void> { get }
    
    func routeToIngredientList(with data: [String], index: Int)
}

protocol CreateIceCreamDataPassing {
    var dataStore: CreateIceCreamDataStore? { get set }
}

class CreateIceCreamRouter: NSObject, CreateIceCreamRoutingLogic, CreateIceCreamDataPassing {
    
    var navigationController: UINavigationController?
    
    var routeToIngredientListRelay: PublishRelay<Void> = .init()
    
    weak var viewController: CreateIceCreamViewController?
    var dataStore: CreateIceCreamDataStore?
    
    func routeToIngredientList(with data: [String], index: Int) {
        let viewController = IngredientListViewController(data: data)
        viewController.router?.dataStore?.name = data
        viewController.router?.dataStore?.iceCreamIndex = index
        viewController.router?.navigationController = navigationController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    // MARK: Navigation
    
    func navigateToIngredientList(source: CreateIceCreamViewController, destination: IngredientListViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToIngredientList(source: CreateIceCreamDataStore, destination: inout IngredientListDataStore) {
        guard let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row else { print("selectedRow is Nil"); return }
        
        if selectedRow == 0 {
            destination.name = source.iceCream?.cones ?? []
        } else if selectedRow == 1 {
            destination.name = source.iceCream?.flavors ?? []
        } else if selectedRow == 2 {
            destination.name = source.iceCream?.toppings ?? []
        }
           
    }
}
