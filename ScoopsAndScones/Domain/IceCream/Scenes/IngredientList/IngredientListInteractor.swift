//
//  IngredientListInteractor.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/16.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol IngredientListBusinessLogic {
    func getList(request: IngredientList.Something.Request)
}

protocol IngredientListDataStore {
    var name: [String]! { get set }
}

class IngredientListInteractor: IngredientListBusinessLogic, IngredientListDataStore {
    
    var presenter: IngredientListPresentationLogic?
    var worker: IngredientListWorker?
    var name: [String]!
    
    // MARK: Do something
    
    func getList(request: IngredientList.Something.Request) {
        worker = IngredientListWorker()
        worker?.doSomeWork()
        
        let response = IngredientList.Something.Response(name: name)
        presenter?.presentIngredient(response: response)
    }
}
