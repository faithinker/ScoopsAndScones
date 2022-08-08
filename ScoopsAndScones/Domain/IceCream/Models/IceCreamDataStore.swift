//
//  IceCreamDataStore.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//

import Foundation

class IceCreamDataStore {
    var displayedCones: [String] = []
    var displayedFlavors: [String] = []
    var displayedToppings: [String] = []
}

extension IceCreamDataStore {
  static var sample: IceCreamDataStore {
    let model = IceCreamDataStore()
    model.displayedCones = ["Sugar Cone", "Cake Cone"]
    model.displayedFlavors = ["Chocolate", "Strawberry"]
    model.displayedToppings = ["Hot Fudge", "Caramel"]

    return model
  }
}
