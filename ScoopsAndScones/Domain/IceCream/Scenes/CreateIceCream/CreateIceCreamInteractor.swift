//
//  CreateIceCreamInteractor.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CreateIceCreamBusinessLogic {
    func doSomething(request: CreateIceCream.Something.Request)
}

protocol CreateIceCreamDataStore {
    //var name: String { get set }
}

class CreateIceCreamInteractor: CreateIceCreamBusinessLogic, CreateIceCreamDataStore {
    
    var presenter: CreateIceCreamPresentationLogic?
    var worker: CreateIceCreamWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: CreateIceCream.Something.Request) {
        worker = CreateIceCreamWorker()
        worker?.doSomeWork()
        
        let response = CreateIceCream.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
