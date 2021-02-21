//
//  DeliveryDTO.swift
//  DeliveryApp
//
//  Created by Farhad on 2/20/21.
//

import RealmSwift

class DeliveryDTO: Object {
    @objc dynamic var id: String?
    @objc dynamic var remarks: String?
    @objc dynamic var pickupTime: Date?
    @objc dynamic var goodsPicture: String?
    @objc dynamic var deliveryFee: String = ""
    @objc dynamic var surcharge: String = ""
    @objc dynamic var isFavorite = false
    
    @objc dynamic var route: RouteDTO?
    @objc dynamic var sender: SenderDTO?
    
    override init() {
        super.init()
    }
    
    init(model: DeliverItem) {
        self.id = model.id
        self.remarks = model.remarks
        self.pickupTime = model.pickupTime
        self.goodsPicture = model.goodsPicture
        self.deliveryFee = model.deliveryFee
        self.surcharge = model.surcharge
        self.isFavorite = model.isFavorite
        
        if let modelRoute = model.route {
            self.route = RouteDTO(model: modelRoute)
        }
        
        if let modelSender = model.sender {
            self.sender = SenderDTO(model: modelSender)
        }
    }
    
    func getDeliverItem() -> DeliverItem {
        var item =  DeliverItem()
        var routeItem = Route()
        var senderItem = Sender()

        item.id = id
        item.remarks = remarks
        item.pickupTime = pickupTime
        item.goodsPicture = goodsPicture
        item.deliveryFee = deliveryFee
        item.surcharge = surcharge
        item.isFavorite = isFavorite
        
        senderItem.phone = sender?.phone
        senderItem.email = sender?.email
        senderItem.name = sender?.name

        routeItem.start = route?.start
        routeItem.end = route?.end

        item.route = routeItem
        item.sender = senderItem

        return item
    }
}
