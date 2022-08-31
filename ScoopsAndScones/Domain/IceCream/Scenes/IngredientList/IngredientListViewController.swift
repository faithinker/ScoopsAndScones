//
//  IngredientListViewController.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/16.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol IngredientListDisplayLogic: class {
    func displayFetchedNames(viewModel: IngredientList.Something.ViewModel)
    
    func displayPresentToHome(didObtainName: String)
}

class IngredientListViewController: UITableViewController, IngredientListDisplayLogic {
    
    typealias Name = IngredientList.Something.ViewModel.DisplayedName

    
    var displayedNames: [Name] = []
    
    var interactor: IngredientListBusinessLogic?
    var router: (NSObjectProtocol & IngredientListRoutingLogic & IngredientListDataPassing)?
    
    // MARK: Object lifecycle
    init(data: [String]) {
        for name in data {
            displayedNames.append(Name(name: name))
        }
        super.init(style: .plain)
        setup()
        setupLayout()
    }
    
    
    init() {
        super.init(style: .plain)
        setup()
        setupLayout()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //doSomething()
    }
    
    // MARK: Do something
    
    lazy var nameLabel = UILabel()
    
    func doSomething() {
        let request = IngredientList.Something.Request()
        interactor?.getList(request: request)
    }
    
    func displayFetchedNames(viewModel: IngredientList.Something.ViewModel) {
        displayedNames = viewModel.displayedList
        tableView.reloadData()
    }
    
    func displayPresentToHome(didObtainName: String) {
        router?.routeToHome(with: didObtainName)
    }
}
