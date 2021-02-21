//
//  CustomButton.swift
//  DeliveryApp
//
//  Created by Farhad on 2/19/21.
//

import UIKit

class CustomButton: UIButton, Cornerable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setConfig(title: String, image: UIImage? = nil) {
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
    }
    
    private func setupView() {
        backgroundColor = Theme.Color.red
        tintColor = .white
        semanticContentAttribute = .forceRightToLeft
        
        setCorner(radius: 8)
    }
}
