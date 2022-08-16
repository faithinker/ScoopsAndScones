//
//  CreateIceCreamModels.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: #0 Make Model

enum CreateIceCream {
    enum LoadIceCream {
        struct Request {
        }
        struct Response {
            var iceCreamData: IceCream
        }
        struct ViewModel {
            var cones: [String]
            var flavors: [String]
            var toppings: [String]
        }
    }
}
