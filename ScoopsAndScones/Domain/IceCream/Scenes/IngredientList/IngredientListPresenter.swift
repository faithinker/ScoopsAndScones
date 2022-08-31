//
//  IngredientListPresenter.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/16.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// 함수이름에 present접두어
protocol IngredientListPresentationLogic {
    func presentIngredient(response: IngredientList.Menu.Response)
    
    func presentIngredient(data: String, index: Int)
}

class IngredientListPresenter: IngredientListPresentationLogic {
    
    weak var viewController: IngredientListDisplayLogic?
    
    // MARK: Do something
    
    func presentIngredient(response: IngredientList.Menu.Response) {
        
        typealias Name = IngredientList.Menu.ViewModel.DisplayedName
        
        var displayedList: [IngredientList.Menu.ViewModel.DisplayedName] = []
        
        for i in 0..<response.name.count {
            displayedList.append(Name(name: response.name[i]))
        }
        
        let viewModel = IngredientList.Menu.ViewModel(displayedList: displayedList)
        viewController?.displayFetchedNames(viewModel: viewModel)
    }
    
    func presentIngredient(data: String, index: Int) {
        viewController?.displayPresentToHome(didObtainName: data, index: index)
    }
}
