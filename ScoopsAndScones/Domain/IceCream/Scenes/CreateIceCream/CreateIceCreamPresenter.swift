//
//  CreateIceCreamPresenter.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CreateIceCreamPresentationLogic {
    func presentIceCream(response: CreateIceCream.LoadIceCream.Response)
    
    func presentIngrdientList(passingData: [String])
}

class CreateIceCreamPresenter: CreateIceCreamPresentationLogic {
    
    weak var viewController: CreateIceCreamDisplayLogic?
    
    // MARK: #3 Formatted Data inject into the Viewmodel
    func presentIceCream(response: CreateIceCream.LoadIceCream.Response) {
        let viewModel = CreateIceCream.LoadIceCream.ViewModel(cones: response.iceCreamData.cones, flavors: response.iceCreamData.flavors, toppings: response.iceCreamData.toppings)
        viewController?.displayIceCream(viewModel: viewModel)
    }
    
    // MARK: Presenter -> ViewController
    func presentIngrdientList(passingData: [String]) {
        viewController?.displayIngredientList(with: passingData)
    }
}
