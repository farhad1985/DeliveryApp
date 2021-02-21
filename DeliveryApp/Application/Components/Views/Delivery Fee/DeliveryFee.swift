//
//  DeliveryFee.swift
//  DeliveryApp
//
//  Created by Farhad on 2/19/21.
//

import UIKit
import RxCocoa
import RxSwift

class DeliveryFee: UIView, Cornerable {
    var feeItem = BehaviorRelay(value: "")

    private let stack = UIStackView()
    
    private let lblTitle = UILabel()
    private let lblPrice = UILabel()
    private var bag = DisposeBag()

    init() {
        super.init(frame: .zero)
        
        setupView()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        bindUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }

    private func setupView() {
        backgroundColor = Theme.Color.grey
        setCorner(radius: 8)

        lblTitle.textColor = .black
        lblTitle.text = "Delivery Fee"
        
        lblPrice.textColor = .black
        lblPrice.text = ""

        addSubview(stack)
        
        stack.addArrangedSubview(lblTitle)
        stack.addArrangedSubview(lblPrice)
    }
    
    private func bindUI() {
        feeItem.bind(to: lblPrice.rx.text).disposed(by: bag)
    }
}
