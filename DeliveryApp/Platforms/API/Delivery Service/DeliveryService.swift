//
//  DeliveryService.swift
//  APIPlatform
//
//  Created by Farhad on 2/19/21.
//

import RxSwift
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class DeliveryService: APIDeliveriable {
        
    func fetchDeliveryList(offset: Int) -> Observable<Result<[DeliverItem], DeliveryError>>{
        
        let onChange = PublishSubject<Result<[DeliverItem], DeliveryError>>()
        
        let route = Router.deliveryList(offset: offset, limit: 20)
        
        AF.request(route.url,
                   method: .get,
                   encoding: JSONEncoding.default)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let data = Mapper<DeliverItem>().mapArray(JSONObject: value)
                    
                    onChange.onNext(.success(data ?? []))

                case .failure:
                    onChange.onNext(.failure(DeliveryError.unknown))
                }

            }
            
        return onChange
    }
}
