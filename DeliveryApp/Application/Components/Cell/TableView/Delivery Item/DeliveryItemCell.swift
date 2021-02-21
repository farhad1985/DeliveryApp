//
//  DeliveryItemCell.swift
//  DeliveryApp
//
//  Created by Farhad on 2/18/21.
//

import UIKit
import Kingfisher
import RxSwift

class DeliveryItemCell: UITableViewCell {
    
    var bag = DisposeBag()
    
    // Views
    private var vwMain = UIView()
    
    // Images
    private var imgItem = UIImageView()
    private var imgFavourite = UIImageView()

    // Labels
    private var lblFromPath = UILabel()
    private var lblToPath = UILabel()
    private var lblValueFromPath = UILabel()
    private var lblValueToPath = UILabel()
    private var lblPrice = UILabel()
    
    // Stacks
    private var stMain = UIStackView()
    private var stLabels = UIStackView()
    private var stPaths = UIStackView()
    private var stRow1 = UIStackView()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: "DeliveryItemCell")
        
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bag = DisposeBag()
    }
    
    func setConfig(model: DeliverItem) {
        imgItem.kf.setImage(with: URL(string: model.goodsPicture ?? ""))
        lblValueFromPath.text = model.route?.start ?? ""
        lblValueToPath.text = model.route?.end ?? ""
        lblPrice.text = "$\(model.fee)"
        
        if model.isFavorite {
            imgFavourite.alpha = 1
        } else {
            imgFavourite.alpha = 0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        vwMain.translatesAutoresizingMaskIntoConstraints = false
        stMain.translatesAutoresizingMaskIntoConstraints = false

        imgItem.translatesAutoresizingMaskIntoConstraints = false
        stLabels.translatesAutoresizingMaskIntoConstraints = false

        stPaths.translatesAutoresizingMaskIntoConstraints = false

        lblFromPath.translatesAutoresizingMaskIntoConstraints = false
        lblToPath.translatesAutoresizingMaskIntoConstraints = false

        lblFromPath.translatesAutoresizingMaskIntoConstraints = false
        lblToPath.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imgItem.widthAnchor.constraint(equalToConstant: 90),
            imgItem.heightAnchor.constraint(equalToConstant: 90),

            vwMain.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            vwMain.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            vwMain.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            vwMain.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stMain.leftAnchor.constraint(equalTo: vwMain.leftAnchor),
            stMain.rightAnchor.constraint(equalTo: vwMain.rightAnchor, constant: -16),
            stMain.topAnchor.constraint(equalTo: vwMain.topAnchor),
            stMain.bottomAnchor.constraint(equalTo: vwMain.bottomAnchor),
                      
            stLabels.widthAnchor.constraint(equalToConstant: 50),
            stRow1.widthAnchor.constraint(equalToConstant: 60),

            imgFavourite.widthAnchor.constraint(equalToConstant: 25),
            imgFavourite.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}

// MARK: - SetupView
extension DeliveryItemCell: Shadowable {
    private func setupView() {
        
        selectionStyle = .none
        backgroundColor = .clear
        
        vwMain.backgroundColor = .white
        
        stMain.spacing = 4
        stMain.alignment = .center
        
        stLabels.axis = .vertical
        stLabels.distribution = .fillEqually
        stLabels.alignment = .leading
        
        stLabels.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        stPaths.axis = .vertical
        stPaths.distribution = .fillEqually
        stPaths.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        stRow1.axis = .vertical
        stRow1.alignment = .trailing
        
        imgItem.contentMode = .scaleAspectFill
        imgItem.layer.masksToBounds = true
        
        imgFavourite.image = UIImage(named: "like")
        imgFavourite.tintColor = .red
        
        lblFromPath.textColor = .darkGray
        lblFromPath.text = "From:"
        
        lblToPath.textColor = .darkGray
        lblToPath.text = "To:"

        lblPrice.textColor = .darkGray
        lblPrice.text = "$85"
        lblPrice.font = UIFont.systemFont(ofSize: 15)

        lblValueFromPath.text = "$85"
        lblValueToPath.text = "$85"
        
        addShadow()
                
        vwMain.layer.cornerRadius = 8
        vwMain.layer.masksToBounds = true

        // add views
        setupAddViews()
    }
    
    private func setupAddViews() {
        addSubview(vwMain)
        
        vwMain.addSubview(stMain)
        
        stMain.addArrangedSubview(imgItem)
        stMain.addArrangedSubview(stLabels)
        stMain.addArrangedSubview(stPaths)
        stMain.addArrangedSubview(stRow1)

        stLabels.addArrangedSubview(lblFromPath)
        stLabels.addArrangedSubview(lblToPath)

        stPaths.addArrangedSubview(lblValueFromPath)
        stPaths.addArrangedSubview(lblValueToPath)

        stRow1.addArrangedSubview(imgFavourite)
        stRow1.addArrangedSubview(lblPrice)
    }
}
