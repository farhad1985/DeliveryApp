//
//  Result.swift
//  Domain
//
//  Created by Farhad on 2/19/21.
//

import Foundation

enum ResultReponse<T> {
    case success(value: T)
    case failure(error: DeliveryError)
}
