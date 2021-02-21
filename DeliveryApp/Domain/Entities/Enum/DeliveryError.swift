//
//  DeliveryError.swift
//  Domain
//
//  Created by Farhad on 2/19/21.
//

import Foundation

enum DeliveryError: LocalizedError {
    case noData
    case unknown
    
    var localize: String {
        switch self {
        case .noData:
            return "No Data"
        default:
            return "Unknown"
        }
    }
}
