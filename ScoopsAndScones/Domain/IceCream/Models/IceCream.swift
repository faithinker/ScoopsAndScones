//
//  IceCream.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//

import Foundation

struct IceCream: Codable, Equatable {
  let cones: [String]
  let flavors: [String]
  let toppings: [String]
}
