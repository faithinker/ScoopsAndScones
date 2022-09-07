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
    
    func displayIngredientList(with data: [String], index: Int)
}

class CreateIceCreamViewController: UIViewController, CreateIceCreamDisplayLogic {
    
    let selectedItems = BehaviorRelay<[String]>(value: Array(repeating: "", count: 3))
    
    var interactor: CreateIceCreamBusinessLogic?
    var router: (NSObjectProtocol & CreateIceCreamRoutingLogic & CreateIceCreamDataPassing)?
    
    var iceCream = IceCreamDataStore()
    
    // MARK: View
    
    private lazy var subTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 11)
        $0.text = "LET'S MAKE AN ICE CREAM!"
        $0.textColor = .systemGray
    }
    
    public lazy var tableView = UITableView().then {
        $0.layer.cornerRadius = 15
        $0.layer.backgroundColor = UIColor.cyan.cgColor
        $0.rowHeight = 50 //UITableView.automaticDimension
        $0.estimatedRowHeight = 50
        $0.showsVerticalScrollIndicator = false
        $0.register(IceCreamCell.self, forCellReuseIdentifier: IceCreamCell.identifier)
    }
    
    private lazy var doneButton = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.setTitle("DONE", for: .normal)
        $0.setTitle("DONE", for: .disabled)
        $0.setTitleColor(.secondaryLabel, for: .disabled)
        $0.setTitleColor(.systemBlue, for: .normal)
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
    
    private lazy var iceCreamImageView = CreateIceCreamImageView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupLayout()
        bindData()
        fetchIceCream()
    }
    
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
    
    func displayIngredientList(with data: [String], index: Int) {
        self.router?.routeToIngredientList(with: data, index: index)
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
        
        resultView.addSubviews([preparingLabel, iceCreamImageView])
        preparingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        iceCreamImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(270)
        }
    }
    
    private func bindData() {
        Observable.just(IceCreamDataStore.sample.displayedMainMenu)
            .bind(to: tableView.rx.items(cellIdentifier: IceCreamCell.identifier, cellType: IceCreamCell.self)) { [weak self] row, element, cell in
                guard let `self` = self else { return }
                cell.configure(element)
                cell.selectedIngredient = self.selectedItems.value[row]
            }.disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] index in
                guard let `self` = self else { return }
                self.interactor?.didSelectRow(at: index.row)
            }).disposed(by: rx.disposeBag)
        
        /// 여기서 로직 처리하는게 틀린것 같다...
        /// Interactor에서 Input이 올바른지 로직처리를 하고 그다음에 Presenter에서 View에 맞게 변형시킨뒤,
        /// View에서는 단순하게 표현만하는게 맞지 않나...?
        selectedItems.subscribe(onNext: { [weak self] values in
            guard let `self` = self else { return }
            
            let bool = values.filter { $0 != "" }.isEmpty
            
            self.updateView(bool)
            
            let allSelected = values.filter { $0 == "" }.isEmpty
            
            self.doneButton.isEnabled = allSelected
            
            for i in 0..<values.count {
                let cell = self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? IceCreamCell
                cell?.selectedIngredient = values[i]
                
                if i == 0 {
                    self.iceCreamImageView.selectedCone = values[i]
                } else if i == 1{
                    self.iceCreamImageView.selectedFlavor = values[i]
                } else if i == 2 {
                    self.iceCreamImageView.selectedTopping = values[i]
                }
            }
        }).disposed(by: rx.disposeBag)
        
        doneButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.alertShow()
            }).disposed(by: rx.disposeBag)
    }
    
    private func alertShow() {
        let alert = UIAlertController(title: "Your ice cream is ready!", message: "Let's make a new one. You can never have too much ice cream...", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            guard let `self` = self else { return }
            self.selectedItems.accept(Array(repeating: "", count: 3))
        })
        alert.addAction(cancelAction)
        self.present(alert, animated: false)
    }
    
    // 재료가 선택될 시 UI Update
    private func updateView(_ bool: Bool) {
        self.preparingLabel.isHidden = !bool
        self.resultView.snp.updateConstraints {
            $0.height.equalTo(bool ? 50 : 250)
        }
    }
}
