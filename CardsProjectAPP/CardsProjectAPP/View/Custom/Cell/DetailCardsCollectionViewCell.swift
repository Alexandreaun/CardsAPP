//
//  DetailCardsCollectionViewCell.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 03/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class DetailCardsCollectionViewCell: UICollectionViewCell {
    
    public static let collectionDetailIdentifier = "UICollectionViewCell"

    lazy var imageCard: UIImageView = {
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        setupLayoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutUI() {
        backgroundColor = .colorBkg
        addSubview(imageCard)
        
        NSLayoutConstraint.activate([
            imageCard.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            imageCard.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            imageCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
