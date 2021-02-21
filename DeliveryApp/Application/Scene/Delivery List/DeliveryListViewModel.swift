//
//  DeliveryListViewModel.swift
//  DeliveryApp
//
//  Created by Farhad on 2/19/21.
//

import RxSwift
import RxCocoa

class DeliveryListViewModel {
    
    enum State {
        case startLoading
        case finishLoading
        case tableReload
        case error(msg: String)
        case pullToRefresh
        case nextPage
    }
    
    var dataSource: [DeliverItem] = []

    private let repo: DeliveryRepositoriable
    private var offset = 0
    
    init(repo: DeliveryRepositoriable ) {
        self.repo = repo
    }
    
    var onChangeState = PublishSubject<State>()
    
    private var bag = DisposeBag()
    private var isAllow = true
    private var isNextPage = false
    
    func favoriteDelivery(at index: Int) {
        dataSource[index].isFavorite = !dataSource[index].isFavorite
        onChangeState.onNext(.tableReload)
    }
    
    func nextPage() {
        guard isNextPage && isAllow else { return }
        
        isNextPage = false
        offset += 1
        fetchDeliveries()
    }
    
    func startFetchDeliveryList() {
        isAllow = true
        offset = 0
        dataSource.removeAll()
        onChangeState.onNext(.tableReload)
        fetchDeliveries()
    }
    
    func fetchDeliveries() {
        onChangeState.onNext(.startLoading)

        repo.fetchDeliveryList(offset: offset)
            .subscribe{ [weak self] result in
                switch result.element {
                case .success(let value):
                    
                    self?.dataSource += value
                    let currentCout = self?.dataSource.count ?? 0
                    
                    self?.offset = currentCout / 20

                    self?.onChangeState.onNext(.tableReload)

                case .failure(let error):
                    self?.onChangeState.onNext(.error(msg: error.localize))
                    
                default: break
                }
                
                self?.isAllow = true
                self?.isNextPage = true
                self?.onChangeState.onNext(.finishLoading)
            }
            .disposed(by: bag)
        
    }
    
}
