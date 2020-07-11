//
//  ListCardsTableViewCell.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 02/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: class {
    func onClickCollectionViewCell(cell: UICollectionViewCell?, type: String, name: String)
}

class ListCardsTableViewCell: UITableViewCell {
    
    public static let tableviewIdentifier = "UITableViewCell"
    weak var delegate: CustomCellDelegate?
    var typeSelected: UnifyInfoCardModel?
    var infoNames: [String]? {
        didSet {
            collectionview.reloadData()
        }
    }
    
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
            collectionview.rightAnchor.constraint(equalTo: rightAnchor, constant: -1),
            collectionview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }}

extension ListCardsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoNames?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ListCardsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCardsCollectionViewCell.collectionIdentifier, for: indexPath) as? ListCardsCollectionViewCell else {return UICollectionViewCell()}
        guard let infonames = infoNames else {return UICollectionViewCell()}
        
        cell.contentView.layer.cornerRadius = 16
        cell.contentView.clipsToBounds = false
        cell.contentView.layer.borderColor = UIColor.gray.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.backgroundColor = .clear
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath

        if indexPath.item < infonames.count {
            cell.contentList = infonames[indexPath.item]
            cell.viewList.backgroundColor = RandomColors.randomColors(numberOfItems: infonames.count)[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ListCardsCollectionViewCell
        if let infonames = infoNames {
            if indexPath.item < infonames.count {
                let name = infonames[indexPath.item]
                let type = typeSelected?.typeName ?? ""
                delegate?.onClickCollectionViewCell(cell: cell, type: type, name: name)
            }
        }
    }
}









