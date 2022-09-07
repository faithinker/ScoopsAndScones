//
//  IngredientListViewController.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/16.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol IngredientListDisplayLogic: class {
    func displayFetchedNames(viewModel: IngredientList.Menu.ViewModel)
    
    func displayPresentToHome(didObtainName: String, index: Int)
}

class IngredientListViewController: UITableViewController, IngredientListDisplayLogic {
    
    typealias Name = IngredientList.Menu.ViewModel.DisplayedName

    
    var displayedNames: [Name] = []
    
    var interactor: IngredientListBusinessLogic?
    var router: (NSObjectProtocol & IngredientListRoutingLogic & IngredientListDataPassing)?
    
    init() {
        super.init(style: .plain)
        setup()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupLayout()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedName = displayedNames[indexPath.row]
        
        let cell: UITableViewCell = {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        
        cell.textLabel?.text = displayedName.name
        
        return cell
    }
    // $1
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectRow(at: indexPath.row)
    }
    
    func setupLayout() {
        view.backgroundColor = .systemGray6
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = IngredientListInteractor()
        let presenter = IngredientListPresenter()
        let router = IngredientListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // viewDidLoad에서 호출시 router의 데이터가 nil값으로 나온다. ViewLifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getList()
        // Response 객체를 따로 넘기는게 맞는가?
        getListTest()
    }
    
    func getList() {
        interactor?.getList()
    }
    
    func getListTest() { //네이버 클린스위프트 ㅣ 16분 20초 map에서 따로 함수 호출해서 정리하는 방법도 있다.
        let request = IngredientList.Menu.Request(displayedName: router?.dataStore?.name ?? [])
        interactor?.getList(request: request)
    }
    
    func displayFetchedNames(viewModel: IngredientList.Menu.ViewModel) {
        displayedNames = viewModel.displayedList
        tableView.reloadData()
    }
    
    func displayPresentToHome(didObtainName: String, index: Int) {
        router?.routeToHome(with: didObtainName, index: index)
    }
}
