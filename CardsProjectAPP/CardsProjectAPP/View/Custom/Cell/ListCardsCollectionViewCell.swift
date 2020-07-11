//
//  ListCardsCollectionViewCell.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 02/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class ListCardsCollectionViewCell: UICollectionViewCell {
    
    public static let collectionIdentifier = "UICollectionViewCell"
    
    lazy var viewList: UIView = {
        let v = UIView(frame: .zero)
        v.clipsToBounds = true
        v.layer.cornerRadius = 16
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var labelTitle: UILabel = {
        let v = UILabel()
        v.textAlignment = .left
        v.textColor = .white
        v.numberOfLines = 1
        v.adjustsFontSizeToFitWidth = true
        v.font = UIFont().fontTitleSmall(size: 18)
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
        addSubview(viewList)
        viewList.addSubview(labelTitle)
        
        NSLayoutConstraint.activate([
            viewList.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            viewList.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            viewList.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            viewList.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: topAnchor, constant: 65),
            labelTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 23),
            labelTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            labelTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17)
        ])
    }
    
    var contentList: String? {
        didSet {
            labelTitle.text = contentList
        }
    }
}
