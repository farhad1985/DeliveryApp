//
//  DeliveryRepository.swift
//  RepositoryPlatform
//
//  Created by Farhad on 2/19/21.
//

import RxSwift

class DeliveryRepository: DeliveryRepositoriable {
    
    private let apiDeliveryService: APIDeliveriable
    private let storgeDeliveryService: DeliveryStorgable
    
    private let bag = DisposeBag()

    init(apiDeliveryService: APIDeliveriable,
         storgeDeliveryService: DeliveryStorgable) {
        
        self.apiDeliveryService = apiDeliveryService
        self.storgeDeliveryService = storgeDeliveryService
    }
    
    func fetchDeliveryList(offset: Int) -> Observable<ResultReponse<[DeliverItem]>> {
        
        return Observable<ResultReponse<[DeliverItem]>>.create { observer in
            
            let db = self.storgeDeliveryService.getDeliveryList()
            let count = db.count
            
            if count > 0 && offset * 20 <= count{
                observer.onNext(ResultReponse.success(value: db))
                
            } else {
                
                self.apiDeliveryService.fetchDeliveryList(offset: offset).subscribe { [weak self] (result) in
                    switch result.element {
                    case .success(let value):
                        self?.storgeDeliveryService.saveDeliveryList(items: value)
                        observer.onNext(ResultReponse.success(value: value))
                        
                    case .failure(let error):
                        observer.onNext(ResultReponse.failure(error: error))
                        
                    default: break
                    }
                }.disposed(by: self.bag)
            }
            
            return Disposables.create()
        }
    }
    
    func setFavorite(item: DeliverItem) {
        storgeDeliveryService.setFavorite(item: item)
    }
    
    func removeAll() {
        storgeDeliveryService.removeAll()
    }

}

