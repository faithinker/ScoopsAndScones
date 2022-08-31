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
    
    func didSelectRow(at index: Int)
}

protocol IngredientListDataStore {
    var name: [String]! { get set }
}

class IngredientListInteractor: IngredientListBusinessLogic, IngredientListDataStore {
    
    var presenter: IngredientListPresentationLogic?
    var worker: IngredientListWorker?
    var name: [String]! // VC에 있는 리스트 값을 갖고와야함
    
    // MARK: Do something
    
    func getList(request: IngredientList.Something.Request) {
        worker = IngredientListWorker()
        worker?.doSomeWork()
        
        let response = IngredientList.Something.Response(name: name)
        presenter?.presentIngredient(response: response)
    }
    
    // MARK: Input
    func didSelectRow(at index: Int) {
        presenter?.presentIngredient(data: name[index])
        
    }
    
    // MARK: Output
}
