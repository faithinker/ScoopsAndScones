//
//  IngredientListInteractor.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/16.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol IngredientListBusinessLogic {
    func getList()
    
    func getList(request: IngredientList.Menu.Request)
    
    func didSelectRow(at index: Int)
}

protocol IngredientListDataStore {
    var name: [String]? { get set }
    
    var iceCreamIndex: Int! { get set }
}

class IngredientListInteractor: IngredientListBusinessLogic, IngredientListDataStore {
    
    var presenter: IngredientListPresentationLogic?
    var name: [String]?
    var iceCreamIndex: Int!
    
    func getList() {
        let response = IngredientList.Menu.Response(name: name ?? [])
        presenter?.presentIngredientList(response: response)
    }
    
    func getList(request: IngredientList.Menu.Request) {
        let response = IngredientList.Menu.Response(name: request.displayedName)
        presenter?.presentIngredientList(response: response)
    }
    
    // MARK: Input
    func didSelectRow(at index: Int) {
        if let nameList = name {
            presenter?.presentIngredient(data: nameList[index], index: iceCreamIndex)
        }
    }
    
    // MARK: Output
}
