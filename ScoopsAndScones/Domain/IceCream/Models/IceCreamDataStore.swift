//
//  IceCreamDataStore.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//

import Foundation

class IceCreamDataStore {
    var displayedMainMenu: [String] = []
    
    var displayedCones: [String] = []
    var displayedFlavors: [String] = []
    var displayedToppings: [String] = []
}

extension IceCreamDataStore {
  static var sample: IceCreamDataStore {
    let model = IceCreamDataStore()
    model.displayedMainMenu = ["Select a cone or cup", "Choose your flavor", "Choose a topping"]
    model.displayedCones = ["Sugar Cone", "Cake Cone", "Waffle Cone", "Cup"]
    model.displayedFlavors = ["Chocolate", "Strawberry", "Vanilla", "Pistachio", "Hazelnut"]
    model.displayedToppings = ["Hot Fudge", "Sprinkles", "Mystery Sauce", "Chocolate Chips"]
      
    return model
  }
}
