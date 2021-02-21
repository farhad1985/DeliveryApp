//
//  DetailDeliveryVC.swift
//  DeliveryApp
//
//  Created by Farhad on 2/18/21.
//

import UIKit
import RxSwift

class DetailDeliveryVC: MainVC {
    
    var favoriteAction = PublishSubject<Int>()
    var deliveryItem: DeliverItem?
    var index = 0
    
    private var viewModel = DetailDeliveryViewModel(repo:  DeliveryRepository(apiDeliveryService: DeliveryService(),
                                                                              storgeDeliveryService: DeliveryStorgeService()))
    
    private var stMain = UIStackView()
    
    private var vwPaths = PathsView()
    private var vwGoodsImage = GoodsView()
    private var vwDeliveryFee = DeliveryFee()
    
    private var btnFavourite = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Delivery Detial"
        
        viewModel.deliveryItem = deliveryItem
        
        setupView()
        bindUI()
        subscribe()
        
        viewModel.setData(model: deliveryItem)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        stMain.translatesAutoresizingMaskIntoConstraints = false
        btnFavourite.translatesAutoresizingMaskIntoConstraints = false
        vwPaths.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stMain.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stMain.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            btnFavourite.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            btnFavourite.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            btnFavourite.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -16),
            btnFavourite.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    @objc
    func updateFavorite() {
        viewModel.favorite()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        stMain.axis = .vertical
        stMain.spacing = 16
        
        btnFavourite.addTarget(self,
                               action: #selector(updateFavorite),
                               for: .touchUpInside)
        
        btnFavourite.setImage(#imageLiteral(resourceName: "like"), for: .normal)

        // add views
        view.addSubview(stMain)
        stMain.addArrangedSubview(vwPaths)
        stMain.addArrangedSubview(vwGoodsImage)
        stMain.addArrangedSubview(vwDeliveryFee)
        
        view.addSubview(btnFavourite)
    }
}

extension DetailDeliveryVC {
    
    func bindUI() {
        viewModel.fromPath
            .bind(to: vwPaths.fromPath)
            .disposed(by: bag)
        
        viewModel.toPath
            .bind(to: vwPaths.toPath)
            .disposed(by: bag)
        
        viewModel.goodImage
            .bind(to: vwGoodsImage.goodImage)
            .disposed(by: bag)
        
        viewModel.feeItem
            .bind(to: vwDeliveryFee.feeItem)
            .disposed(by: bag)
        
        viewModel.titleFavoriteButton
            .bind(to: btnFavourite.rx.title(for: .normal))
            .disposed(by: bag)
    }
    
    func subscribe() {
        viewModel.onChangeState
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] (state) in
                switch state.element {
                case .favorite:
                    self?.favoriteAction.onNext(self?.index ?? 0)
                    self?.navigationController?.popViewController(animated: true)
                    
                default:
                    break
                }
            }
            .disposed(by: bag)
        
    }
}
