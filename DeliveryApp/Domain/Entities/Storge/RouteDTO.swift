//
//  RouteDTO.swift
//  DeliveryApp
//
//  Created by Farhad on 2/20/21.
//

import RealmSwift

class RouteDTO: Object {
    @objc dynamic var start: String?
    @objc dynamic var end: String?
    
    override init() {
        super.init()
    }

    init(model: Route) {
        self.start = model.start
        self.end = model.end
    }
}
