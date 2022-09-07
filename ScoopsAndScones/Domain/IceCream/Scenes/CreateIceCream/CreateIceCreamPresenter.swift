//
//  CreateIceCreamPresenter.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CreateIceCreamPresentationLogic {
    func presentIceCream(response: CreateIceCream.LoadIceCream.Response)
    
    func presentIngrdientList(passingData: [String], passingIndex: Int)
}

/*
 입력으로 Response를 받고 출력으로 ViewModel을 생성한다.
 이것을 이제 ViewController에게 전달한다.
 */

class CreateIceCreamPresenter: CreateIceCreamPresentationLogic {
    
    weak var viewController: CreateIceCreamDisplayLogic?
    
    // MARK: #3 Formatted Data inject into the Viewmodel
    func presentIceCream(response: CreateIceCream.LoadIceCream.Response) {
        let viewModel = CreateIceCream.LoadIceCream.ViewModel(cones: response.iceCreamData.cones, flavors: response.iceCreamData.flavors, toppings: response.iceCreamData.toppings)
        viewController?.displayIceCream(viewModel: viewModel)
    }
    
    // MARK: Presenter -> ViewController
    func presentIngrdientList(passingData: [String], passingIndex: Int) {
        viewController?.displayIngredientList(with: passingData, index: passingIndex)
    }
}


/*
 Unit Test 3단계
 Given : 로직 스파이 생성해서 VC에게 할당당한다.
 When : 가짜 컨텍트 객체를 만들고 Response를 감싸서 presenter에게 전달해준다.
 Then : 디스플레이로직 뷰모델에 잘 전달되었는지 체크..
 
 Presenter를 테스트하는데.. VC, Interactor가 필요없다.
 서로 독립적 개발과 테스트가 가능하다는 것이 장점
 
 
 */
