//
//  DeliveryAppTests.swift
//  DeliveryAppTests
//
//  Created by Farhad on 2/18/21.
//

import XCTest

@testable import DeliveryApp

class DeliveryAppTests: XCTestCase {
    
    func testRouteDeliveryList() {
        let route = Router.deliveryList(offset: 1, limit: 20)
        XCTAssertEqual(route.url, "https://mock-api-mobile.dev.lalamove.com/v2/deliveries/?offset=1&limit=20")
    }

    func testDeliverFee() {
        var deliverItem = DeliverItem()
        deliverItem.deliveryFee = "$1"
        deliverItem.surcharge = "$2"
        
        XCTAssertTrue(deliverItem.fee == "3.00")
    }
    
    func testDeliverFeeWithFractional() {
        var deliverItem = DeliverItem()
        deliverItem.deliveryFee = "$1.1"
        deliverItem.surcharge = "$2.01"
        
        XCTAssertTrue(deliverItem.fee == "3.11")
    }
    
    func testDeliverFeeWithFractional2() {
        var deliverItem = DeliverItem()
        deliverItem.deliveryFee = "$1.1000"
        deliverItem.surcharge = "$2.0122"

        XCTAssertTrue(deliverItem.fee == "3.11")
    }
}
