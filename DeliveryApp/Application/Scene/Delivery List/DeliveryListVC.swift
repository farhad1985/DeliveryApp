//
//  ViewController.swift
//  DeliveryApp
//
//  Created by Farhad on 2/18/21.
//

import UIKit
import Notifire
import RxSwift
import RxCocoa

class DeliveryListVC: MainVC {
    
    var favoriteAction = PublishSubject<Int>()
    
    private var stMain = UIStackView()
    private var isScroll = false
    
    private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableView.automaticDimension
            
        }
    }
    private var pullToRefresh = UIRefreshControl()
    private var activity = UIActivityIndicatorView(style: .medium)
    
    private var viewModel = DeliveryListViewModel(repo: DeliveryRepository(apiDeliveryService: DeliveryService(),
                                                                           storgeDeliveryService: DeliveryStorgeService()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        onSubscribe()
        
        pullToRefresh.addTarget(self,
                                action: #selector(fetchPullToRefresh),
                                for: .valueChanged)
        
        viewModel.fetchDeliveries()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        stMain.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stMain.leftAnchor.constraint(equalTo: view.leftAnchor),
            stMain.rightAnchor.constraint(equalTo: view.rightAnchor),
            stMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stMain.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: stMain.leftAnchor),
            activity.widthAnchor.constraint(equalToConstant: 50),
            activity.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        tableView = UITableView()
        view.addSubview(stMain)
        
        stMain.alignment = .center
        stMain.axis = .vertical
        
        stMain.addArrangedSubview(tableView)
        stMain.addArrangedSubview(activity)
        
        tableView.addSubview(pullToRefresh)
        
        title = "My Deliveries"
    }
    
    @objc private func fetchPullToRefresh() {
        viewModel.onChangeState.onNext(.pullToRefresh)
    }
}

extension DeliveryListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = DeliveryItemCell()
        let model = viewModel.dataSource[indexPath.row]
        cell.setConfig(model: model)
        
        cell.layoutSubviews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailDeliveryVC()
        let model = viewModel.dataSource[indexPath.row]
        
        detailVC.deliveryItem = model
        detailVC.index = indexPath.row
        detailVC.favoriteAction.bind(to: favoriteAction).disposed(by: bag)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let content = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if content >= scrollView.contentSize.height && scrollView.contentSize.height != 0{
            viewModel.onChangeState.onNext(.nextPage)
        }
    }
}

extension DeliveryListVC {
    func onSubscribe() {
        favoriteAction.subscribe { [weak self] (index) in
            self?.viewModel.favoriteDelivery(at: index)
        }.disposed(by: bag)
        
        viewModel.onChangeState
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self]  (state) in
                switch state.element {
                
                case .nextPage:
                    self?.viewModel.nextPage()
                    
                case .error(let msg):
                    Notifire.shared.show(type: .error,
                                         message: msg,
                                         animation: .jelly)
                    
                case .startLoading:
                    self?.activity.isHidden = false
                    self?.activity.startAnimating()
                    
                case .finishLoading:
                    self?.activity.isHidden = true
                    self?.pullToRefresh.endRefreshing()
                    
                case .tableReload:
                    self?.tableView.reloadData()
                    
                case .pullToRefresh:
                    self?.viewModel.startFetchDeliveryList()
                    
                default: break
                }
            }.disposed(by: bag)
        
    }
}
