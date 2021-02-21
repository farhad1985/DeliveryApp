//
//  PathsView.swift
//  DeliveryApp
//
//  Created by Farhad on 2/18/21.
//

import UIKit
import RxCocoa
import RxSwift

class PathsView: UIView, Cornerable {
    var fromPath = BehaviorRelay(value: "")
    var toPath = BehaviorRelay(value: "")

    private let stack = UIStackView()
    private let stackKeys = UIStackView()
    private let stackValues = UIStackView()
    
    private let lblKeyFrom = UILabel()
    private let lblKeyTo = UILabel()
    private let lblValueFrom = UILabel()
    private let lblValueTo = UILabel()
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
        
        lblKeyFrom.textColor = .gray
        lblKeyTo.textColor = .gray
                
        stackKeys.axis = .vertical
        stackKeys.alignment = .leading
        stackKeys.spacing = 16

        stackValues.axis = .vertical
        stackValues.alignment = .trailing
        stackValues.spacing = 16

        lblKeyFrom.text = "From"
        lblKeyTo.text = "To"
        
        lblValueFrom.text = ""
        lblValueTo.text = ""

        addSubview(stack)
        
        stack.addArrangedSubview(stackKeys)
        stack.addArrangedSubview(stackValues)
        
        stackKeys.addArrangedSubview(lblKeyFrom)
        stackKeys.addArrangedSubview(lblKeyTo)

        stackValues.addArrangedSubview(lblValueFrom)
        stackValues.addArrangedSubview(lblValueTo)

    }
    
    private func bindUI() {
        fromPath.bind(to: lblValueFrom.rx.text).disposed(by: bag)
        toPath.bind(to: lblValueTo.rx.text).disposed(by: bag)
    }
}
