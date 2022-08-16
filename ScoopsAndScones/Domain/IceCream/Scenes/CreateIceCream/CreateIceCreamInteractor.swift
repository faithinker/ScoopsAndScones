//
//  CreateIceCreamInteractor.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CreateIceCreamBusinessLogic {
    func loadIceCream(request: CreateIceCream.LoadIceCream.Request)
}

protocol CreateIceCreamDataStore {
    //var name: String { get set }
}

class CreateIceCreamInteractor: CreateIceCreamBusinessLogic, CreateIceCreamDataStore {
    
    var presenter: CreateIceCreamPresentationLogic?
    var worker: CreateIceCreamWorker?
    //var name: String = ""
    
    // MARK: #2 Communicate NetworkWorker
    func loadIceCream(request: CreateIceCream.LoadIceCream.Request) {
        worker = CreateIceCreamWorker()
        worker?.doSomeWork()
        
        let iceCream = Bundle.main.decode(IceCream.self, from: "icecream.json")
        let response = CreateIceCream.LoadIceCream.Response(iceCreamData: iceCream)
        presenter?.presentIceCream(response: response)
    }
}
