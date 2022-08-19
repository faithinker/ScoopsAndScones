//
//  IngredientListModels.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/16.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum IngredientList {
    // MARK: Use cases
    
    enum Something {
        struct Request {
        }
        struct Response {
            var name: [String]
        }
        struct ViewModel {
            struct DisplayedName {
                var name: String
            }
            
            var displayedList: [DisplayedName]
        }
    }
}
