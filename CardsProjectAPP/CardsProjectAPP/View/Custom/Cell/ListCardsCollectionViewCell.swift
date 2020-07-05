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
        v.layer.shadowColor = UIColor(red: 0.125, green: 0.125, blue: 0.196, alpha: 0.1).cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowRadius = 5
        v.layer.position = v.center
        v.layer.shadowPath = UIBezierPath(roundedRect: v.bounds, cornerRadius: 16).cgPath
        v.layer.shouldRasterize = true
        v.clipsToBounds = true
        v.layer.cornerRadius = 16
        v.layer.masksToBounds = false
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var labelTitle: UILabel = {
        let v = UILabel()
        v.textAlignment = .left
        v.textColor = .white
        v.numberOfLines = 0
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
