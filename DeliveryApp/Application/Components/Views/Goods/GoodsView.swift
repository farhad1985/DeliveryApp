//
//  GoodsView.swift
//  DeliveryApp
//
//  Created by Farhad on 2/19/21.
//

import UIKit
import RxSwift
import RxCocoa

class GoodsView: UIView, Cornerable {
    
    var goodImage = BehaviorRelay(value: "")

    private let stack = UIStackView()
    
    private let lblTitle = UILabel()
    private let imgGood = UIImageView()
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
            imgGood.widthAnchor.constraint(equalToConstant: 100),
            imgGood.heightAnchor.constraint(equalToConstant: 100),
        ])
    }

    private func setupView() {
        backgroundColor = Theme.Color.grey
        setCorner(radius: 8)

        lblTitle.textColor = .black
        lblTitle.text = "Goods To Deliver"
        
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 16
        
        imgGood.contentMode = .scaleAspectFill
        imgGood.layer.masksToBounds = true
        imgGood.layer.cornerRadius = 8

        addSubview(stack)
        
        stack.addArrangedSubview(lblTitle)
        stack.addArrangedSubview(imgGood)
    }
    
    private func bindUI() {
        goodImage.bind(to: imgGood.rx.image).disposed(by: bag)
    }
}
