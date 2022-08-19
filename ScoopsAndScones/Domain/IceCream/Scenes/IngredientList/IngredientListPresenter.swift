//
//  IngredientListPresenter.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/16.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol IngredientListPresentationLogic {
    func presentIngredient(response: IngredientList.Something.Response)
}

class IngredientListPresenter: IngredientListPresentationLogic {
    
    weak var viewController: IngredientListDisplayLogic?
    
    // MARK: Do something
    
    func presentIngredient(response: IngredientList.Something.Response) {
        
        typealias Name = IngredientList.Something.ViewModel.DisplayedName
        
        var displayedList: [IngredientList.Something.ViewModel.DisplayedName] = []
        
        for i in 0..<response.name.count {
            displayedList.append(Name(name: response.name[i]))
        }
        
        let viewModel = IngredientList.Something.ViewModel(displayedList: displayedList)
        viewController?.displayFetchedNames(viewModel: viewModel)
    }
}
