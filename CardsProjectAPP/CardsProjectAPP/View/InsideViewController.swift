//
//  InsideViewController.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 02/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class InsideViewController: UIViewController {
    
    var type: String?
    
    lazy var viewBkButton: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .colorBackButton
        v.layer.cornerRadius = 33
        v.layer.masksToBounds = true
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFill
        let tgr = UITapGestureRecognizer(target: self, action: #selector(goToHome))
        tgr.numberOfTouchesRequired = 1
        tgr.numberOfTapsRequired = 1
        v.addGestureRecognizer(tgr)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var labelArrow: UILabel = {
        let v = UILabel(frame: CGRect(x: 0, y: 0, width: 8, height: 16))
        v.textColor = .white
        v.numberOfLines = 1
        v.font = UIFont().fontTitleSmall(size: 18)
        v.text = "<"
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var labelTitle: UILabel = {
        let v = UILabel(frame: CGRect(x: 0, y: 0, width: 225, height: 55))
        v.textColor = .colorMainTitle
        v.numberOfLines = 1
        v.textAlignment = .right
        v.font = UIFont().fontTitleSmall(size: 22)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.register(DetailCardsCollectionViewCell.self, forCellWithReuseIdentifier: DetailCardsCollectionViewCell.collectionDetailIdentifier)
        v.backgroundColor = .colorBkg
        v.showsVerticalScrollIndicator = false
        v.delegate = self
        v.dataSource = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutUI()
        labelTitle.text = type ?? ""
    }
    
    private func setupLayoutUI() {
        view.backgroundColor = .colorBkg
        view.addSubview(viewBkButton)
        viewBkButton.addSubview(labelArrow)
        view.addSubview(labelTitle)
        view.addSubview(collection)
        
        var topanchor: NSLayoutYAxisAnchor
        var bottomanchor: NSLayoutYAxisAnchor
        
        if #available(iOS 11.0, *){
            bottomanchor = view.safeAreaLayoutGuide.bottomAnchor
            topanchor = view.safeAreaLayoutGuide.topAnchor
        }else{
            bottomanchor = view.bottomAnchor
            topanchor = view.topAnchor
        }
        
        NSLayoutConstraint.activate([
            viewBkButton.topAnchor.constraint(equalTo: topanchor, constant: 91),
            viewBkButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            viewBkButton.widthAnchor.constraint(equalToConstant: 64),
            viewBkButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        NSLayoutConstraint.activate([
            labelArrow.topAnchor.constraint(equalTo: viewBkButton.topAnchor, constant: 24),
            labelArrow.leftAnchor.constraint(equalTo: viewBkButton.leftAnchor, constant: 25),
            labelArrow.rightAnchor.constraint(equalTo: viewBkButton.rightAnchor, constant: -24),
            labelArrow.bottomAnchor.constraint(equalTo: viewBkButton.bottomAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: topanchor, constant: 109),
            labelTitle.leftAnchor.constraint(equalTo: viewBkButton.leftAnchor, constant: 201),
            labelTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -31),
            labelTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: viewBkButton.bottomAnchor, constant: 34),
            collection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -29),
            collection.bottomAnchor.constraint(equalTo: bottomanchor, constant: -5)
        ])
    }
    
    @objc func goToHome() {
        dismiss(animated: true, completion: nil)
    }
}

extension InsideViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/2-5
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCardsCollectionViewCell.collectionDetailIdentifier, for: indexPath) as? DetailCardsCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
}

