//
//  APIDeliveriable.swift
//  Domain
//
//  Created by Farhad on 2/19/21.
//

import RxSwift

protocol APIDeliveriable {
    
    func fetchDeliveryList(offset: Int) -> Observable<Result<[DeliverItem], DeliveryError>>
}
