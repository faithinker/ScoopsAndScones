//
//  CreateIceCreamConfigurator.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/17.
//

import UIKit

class CreateIceCreamConfigurator {
    static func configureModule(viewController: CreateIceCreamViewController) {
        
        let router = CreateIceCreamRouter()
        let interactor = CreateIceCreamInteractor()
        let presenter = CreateIceCreamPresenter()
        
        viewController.router = router
        viewController.interactor = interactor
        
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
        
    }
}
