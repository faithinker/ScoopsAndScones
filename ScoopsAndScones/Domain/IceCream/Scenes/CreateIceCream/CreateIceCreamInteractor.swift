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
    
    func didSelectRow(at index: Int)
}

protocol CreateIceCreamDataStore {
    var iceCream: IceCream? { get set }
}

class CreateIceCreamInteractor: CreateIceCreamBusinessLogic, CreateIceCreamDataStore {
    
    var iceCream: IceCream?
    
    var presenter: CreateIceCreamPresentationLogic?
    var worker: CreateIceCreamWorker?
    
    private var names: [String] = []
    
    // MARK: #2 Communicate NetworkWorker
    func loadIceCream(request: CreateIceCream.LoadIceCream.Request) {
        worker = CreateIceCreamWorker()
        worker?.doSomeWork()
        
        let iceCream = Bundle.main.decode(IceCream.self, from: "icecream.json")
        self.iceCream = iceCream
        let response = CreateIceCream.LoadIceCream.Response(iceCreamData: iceCream)
        presenter?.presentIceCream(response: response)
    }
    
    func didSelectRow(at index: Int) {
        if index == 0 {
            names = iceCream?.cones ?? []
        } else if index == 1 {
            names = iceCream?.flavors ?? []
        } else if index == 2 {
            names = iceCream?.toppings ?? []
        }
        
        presenter?.presentIngrdientList(passingData: names, passingIndex: index)
    }
}
