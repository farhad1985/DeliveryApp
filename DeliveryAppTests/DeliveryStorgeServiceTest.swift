//
//  DeliveryListViewModelTest.swift
//  DeliveryAppTests
//
//  Created by Farhad on 2/21/21.
//

import XCTest
@testable import DeliveryApp

class DeliveryStorgeServiceTest: XCTestCase {
    
    let storge: DeliveryStorgable = DeliveryStorgeService()

    func testFavoriteItem() {
        var item = DeliverItem()
        item.id = "1"
        item.isFavorite = true
        
        storge.saveDeliveryList(items: [item])
        storge.setFavorite(item: item)
        
        let obj = storge.getDeliveryList().filter {$0.id == "1"}.first
        
        XCTAssertNotNil(obj)
        XCTAssertTrue(obj?.isFavorite ?? false)
    }
    
    func testRemoveAll() {
        var item = DeliverItem()
        item.id = "2"
        item.isFavorite = true
        
        storge.saveDeliveryList(items: [item])
        
        storge.removeAll()
        
        let obj = storge.getDeliveryList()
        XCTAssertTrue(obj.count == 0)
    }
}
