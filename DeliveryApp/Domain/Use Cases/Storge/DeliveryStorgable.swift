//
//  DeliveryStorge.swift
//  Domain
//
//  Created by Farhad on 2/19/21.
//

protocol DeliveryStorgable {
    
    func getDeliveryList() -> [DeliverItem]
    
    func saveDeliveryList(items: [DeliverItem])
    
    func removeAll()
    
    func setFavorite(item: DeliverItem)
}
