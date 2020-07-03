//
//  ListCardsTableViewCell.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 02/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: class {
    func onClickCollectionView(cell: UICollectionViewCell?, type: String, index: Int, click: UITableViewCell)
}

class ListCardsTableViewCell: UITableViewCell {
    
    public static let tableviewIdentifier = "UITableViewCell"
    weak var delegate: CustomCellDelegate?
       
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 144, height: 104)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.register(ListCardsCollectionViewCell.self, forCellWithReuseIdentifier: ListCardsCollectionViewCell.collectionIdentifier)
        v.backgroundColor = .colorBkg
        v.delegate = self
        v.dataSource = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayoutUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutUI() {
        backgroundColor = .colorBkg
        addSubview(collectionview)
        
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            collectionview.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            collectionview.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            collectionview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }}

extension ListCardsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ListCardsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCardsCollectionViewCell.collectionIdentifier, for: indexPath) as? ListCardsCollectionViewCell else {return UICollectionViewCell()}
        
        cell.labelTitle.text = "teste"
        cell.viewList.backgroundColor = .randomColorCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ListCardsCollectionViewCell
        let value = "teste"
        delegate?.onClickCollectionView(cell: cell, type: value, index: indexPath.item, click: self)
        
    }
}

extension ListCardsTableViewCell {
    
//    func backgroundColorRandom() -> [UIColor] {
//        let color: UIColor = .randomColorCell
//        var cores = [UIColor]()
//
//        for color in color.cgColor {
//
//        }
//        return .randomColorCell
//
//    }
    
}








