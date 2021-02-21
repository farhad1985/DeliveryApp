//
//  SenderDTO.swift
//  DeliveryApp
//
//  Created by Farhad on 2/20/21.
//

import RealmSwift

class SenderDTO: Object {
    @objc dynamic var phone: String?
    @objc dynamic var name: String?
    @objc dynamic var email: String?

    override init() {
        super.init()
    }
    
    init(model: Sender) {
        self.phone = model.phone
        self.name = model.name
        self.email = model.email
    }
}
