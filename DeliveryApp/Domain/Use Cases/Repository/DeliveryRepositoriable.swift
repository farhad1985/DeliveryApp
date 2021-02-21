//
//  File.swift
//  Domain
//
//  Created by Farhad on 2/19/21.
//

import RxSwift

protocol DeliveryRepositoriable {
    
    func fetchDeliveryList(offset: Int) -> Observable<ResultReponse<[DeliverItem]>>
    
    func removeAll()
    
    func setFavorite(item: DeliverItem) 
}
