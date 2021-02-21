//
//  ExView.swift
//  DeliveryApp
//
//  Created by Farhad on 2/18/21.
//

import UIKit

protocol Shadowable where Self: UIView {}

extension Shadowable {
    
    func addShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.4
    }
}

