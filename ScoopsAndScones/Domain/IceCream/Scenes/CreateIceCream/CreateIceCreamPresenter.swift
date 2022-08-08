//
//  CreateIceCreamPresenter.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CreateIceCreamPresentationLogic {
    func presentSomething(response: CreateIceCream.Something.Response)
}

class CreateIceCreamPresenter: CreateIceCreamPresentationLogic {
    
    weak var viewController: CreateIceCreamDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: CreateIceCream.Something.Response) {
        let viewModel = CreateIceCream.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
