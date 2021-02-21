//
//  Cornerable.swift
//  DeliveryApp
//
//  Created by Farhad on 2/19/21.
//

import UIKit

protocol Cornerable where Self: UIView {}

extension Cornerable {
    
    func setCorner(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}

