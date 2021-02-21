//
//  ExReactive.swift
//  DeliveryApp
//
//  Created by Farhad on 2/19/21.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {
    
    var image: Binder<String?> {
        return Binder(self.base, binding: { (view, data) in
            guard let url = URL(string: data ?? "") else {
                view.image = nil
                return
            }
            view.kf.setImage(with: url)
        })
    }
}
