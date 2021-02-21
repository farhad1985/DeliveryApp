//
//  DetailDeliveryViewModel.swift
//  DeliveryApp
//
//  Created by Farhad on 2/19/21.
//

import RxSwift
import RxCocoa

class DetailDeliveryViewModel {
    
    enum State {
        case favorite
    }
    
    
    var fromPath = BehaviorRelay(value: "")
    var toPath = BehaviorRelay(value: "")
    var goodImage = BehaviorRelay(value: "")
    var feeItem = BehaviorRelay(value: "")
    
    var titleFavoriteButton = BehaviorRelay(value: "")
    var deliveryItem: DeliverItem?
    
    private let repo: DeliveryRepositoriable
    
    init(repo: DeliveryRepositoriable ) {
        self.repo = repo
    }
    
    var onChangeState = PublishSubject<State>()

    func setData(model: DeliverItem?) {
        fromPath.accept(model?.route?.start ?? "")
        toPath.accept(model?.route?.end ?? "")
        goodImage.accept(model?.goodsPicture ?? "")
        feeItem.accept("$\(model?.fee ?? "")")
        
        let isFavorite = model?.isFavorite ?? false
        
        if isFavorite {
            titleFavoriteButton.accept("Remove Favorite")
        } else {
            titleFavoriteButton.accept("Add To Favorite")
        }
    }
    
    func favorite() {
        guard var item = deliveryItem else { return }
        
        item.isFavorite = !item.isFavorite
        
        repo.setFavorite(item: item)
        onChangeState.onNext(.favorite)
    }
}
