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
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.backgroundColor = .blue
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
            imageCard.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            imageCard.widthAnchor.constraint(equalToConstant: 147),
            imageCard.heightAnchor.constraint(equalToConstant: 223)
        ])
       
    }
    
    
}
