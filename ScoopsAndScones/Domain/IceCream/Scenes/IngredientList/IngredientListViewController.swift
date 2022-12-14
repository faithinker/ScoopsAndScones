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
    
    // viewDidLoad?????? ????????? router??? ???????????? nil????????? ?????????. ViewLifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getList()
        // Response ????????? ?????? ???????????? ??????????
        getListTest()
    }
    
    func getList() {
        interactor?.getList()
    }
    
    func getListTest() { //????????? ?????????????????? ??? 16??? 20??? map?????? ?????? ?????? ???????????? ???????????? ????????? ??????.
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
