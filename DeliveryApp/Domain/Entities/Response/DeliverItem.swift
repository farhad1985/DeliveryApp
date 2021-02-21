//
//  a.swift
//  Domain
//
//  Created by Farhad on 2/19/21.
//

import ObjectMapper

struct DeliverItem: Mappable {
    var id, remarks: String?
    var pickupTime: Date?
    var goodsPicture: String?
    var deliveryFee: String = ""
    var surcharge: String = ""
    var route: Route?
    var sender: Sender?
    var isFavorite = false
    
    var fee: String {
        let deliveryFeePrice = getPrice(fee: deliveryFee)
        let surchargePrice = getPrice(fee: surcharge)
        
        let sum = deliveryFeePrice + surchargePrice
        return String(format: "%0.2f", sum)
    }
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        remarks <- map["remarks"]
        pickupTime <- map["pickupTime"]
        goodsPicture <- map["goodsPicture"]
        deliveryFee <- map["deliveryFee"]
        surcharge <- map["surcharge"]
        route <- map["route"]
        sender <- map["sender"]
    }
    
    private func getPrice(fee: String) -> Double {
        return Double(fee.replacingOccurrences(of: "$", with: "")) ?? 0
    }
}
