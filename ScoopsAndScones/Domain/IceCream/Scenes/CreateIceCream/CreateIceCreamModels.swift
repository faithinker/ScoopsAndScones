//
//  CreateIceCreamModels.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: #0 Make Model
// 파일명이름으로 네임스페이스 이름 선언
enum CreateIceCream {
    // VC에서 IceCreamㅑLoadIceCream.Response)의 데이터를 직접 접근 하는 것보다는..
    // 출력 타입을 따로 만들어서
    // Presenter에서 만들어서 => VC에서는 출력만 하도록 
    struct DisplayedIceCream {
        let title: String
        let selectedItem: String
    }
    
    // 기능 단위로 네임스페이스 선언
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
    
    enum DeleteIceCream {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
}
