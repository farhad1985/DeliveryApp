//
//  StorgeService.swift
//  DeliveryApp
//
//  Created by Farhad on 2/20/21.
//

import RealmSwift

class DeliveryStorgeService: DeliveryStorgable {
    
    func getDeliveryList() -> [DeliverItem] {
        let realm = try! Realm()
        
        let deliveries = realm.objects(DeliveryDTO.self)
        var deliverList: [DeliverItem] = []
        
        for i in deliveries {
            deliverList.append(i.getDeliverItem())
        }
        
        return deliverList
    }
    
    func saveDeliveryList(items: [DeliverItem]) {
        let realm = try! Realm()
        
        let itemsDTO = List<DeliveryDTO>()
        
        for i in items {
            itemsDTO.append(DeliveryDTO(model: i))
        }
        
        try? realm.write {
            realm.add(itemsDTO)
        }
    }
    
    func setFavorite(item: DeliverItem) {
        let realm = try! Realm()
        
        let itemDTO = realm.objects(DeliveryDTO.self).filter{ $0.id == item.id}.first
        
        try? realm.write {
            itemDTO?.isFavorite = item.isFavorite
        }
    }
    
    func removeAll() {
        let realm = try! Realm()
        
        try? realm.write {
            realm.deleteAll()
        }
    }
}
