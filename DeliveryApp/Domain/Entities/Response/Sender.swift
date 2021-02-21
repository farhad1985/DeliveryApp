//
//  Sender.swift
//  Domain
//
//  Created by Farhad on 2/19/21.
//

import ObjectMapper

struct Sender: Mappable {
    var phone, name, email: String?
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        phone <- map["phone"]
        name <- map["name"]
        email <- map["email"]
    }
}
