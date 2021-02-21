//
//  Router.swift
//  APIPlatform
//
//  Created by Farhad on 2/19/21.
//

import Foundation

let baseURL = "https://mock-api-mobile.dev.lalamove.com"

enum Router {
    case deliveryList(offset: Int, limit: Int)
    
    var url: String {
        switch self {
        case .deliveryList(let offset, let limit):
            return baseURL + "/v2/deliveries/?offset=\(offset)&limit=\(limit)"
        }
    }
}
