//
//  Route.swift
//  Domain
//
//  Created by Farhad on 2/19/21.
//

import ObjectMapper

struct Route: Mappable {
    var start, end: String?
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        start <- map["start"]
        end <- map["end"]
    }
}
