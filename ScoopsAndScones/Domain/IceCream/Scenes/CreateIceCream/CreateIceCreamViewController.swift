//
//  CreateIceCreamViewController.swift
//  ScoopsAndScones
//
//  Created by jhKim on 2022/08/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import NSObject_Rx

protocol CreateIceCreamDisplayLogic: class {
    func displayIceCream(viewModel: CreateIceCream.LoadIceCream.ViewModel)
}

class CreateIceCreamViewController: UIViewController, CreateIceCreamDisplayLogic {
    
    var interactor: CreateIceCreamBusinessLogic?
    var router: (NSObjectProtocol & CreateIceCreamRoutingLogic & CreateIceCreamDataPassing)?
    
    var iceCream = IceCreamDataStore()
    
    
    // MARK: View
    
    private lazy var subTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 11)
        $0.text = "LET'S MAKE AN ICE CREAM!"
        $0.textColor = .systemGray
    }
    
    private lazy var tableView = UITableView().then {
        $0.layer.cornerRadius = 15
        $0.layer.backgroundColor = UIColor.cyan.cgColor
        $0.rowHeight = 50 //UITableView.automaticDimension
        $0.estimatedRowHeight = 50
        $0.showsVerticalScrollIndicator = false
        $0.register(IceCreamCell.self, forCellReuseIdentifier: IceCreamCell.identifier)
    }
    
    private lazy var doneButton = UIButton().then {
        $0.isEnabled = false
        $0.layer.cornerRadius = 8
        $0.setTitle("DONE", for: .normal)
        $0.setTitleColor(.secondaryLabel, for: .normal)
        $0.backgroundColor = .white
    }
    
    private lazy var resultView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .white
    }
    
    private lazy var preparingLabel = UILabel().then {
        $0.text = "Preparing..."
        $0.textAlignment = .center
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = CreateIceCreamInteractor()
        let presenter = CreateIceCreamPresenter()
        let router = CreateIceCreamRouter()
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
        setupNavigation()
        setupLayout()
        bindData()
        fetchIceCream()
    }
    
    // MARK: Do something
    
    //lazy var nameLabel = UILabel()
    
    // MARK: #1 Load Data
    func fetchIceCream() {
        let request = CreateIceCream.LoadIceCream.Request()
        interactor?.loadIceCream(request: request)
    }
    
    // MARK: #4 ViewModel Data bind to DataStore
    func displayIceCream(viewModel: CreateIceCream.LoadIceCream.ViewModel) {
        iceCream.displayedCones = viewModel.cones
        iceCream.displayedFlavors = viewModel.flavors
        iceCream.displayedToppings = viewModel.toppings
    }
    
    private func setupNavigation() {
        navigationItem.title = "Scoops&Scones"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemGray6
        view.addSubviews([subTitle, tableView, doneButton, resultView])
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(5)
            $0.height.equalTo(150)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        doneButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(30)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        resultView.snp.makeConstraints {
            $0.top.equalTo(doneButton.snp.bottom).offset(30)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        resultView.addSubview(preparingLabel)
        preparingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func bindData() {
        Observable.just(IceCreamDataStore.sample.displayedMainMenu)
            .bind(to: tableView.rx.items(cellIdentifier: IceCreamCell.identifier, cellType: IceCreamCell.self)) { [weak self] row, element, cell in
                guard let `self` = self else { return }
                cell.configure(element)
            }.disposed(by: rx.disposeBag)
        
        
    }
}
