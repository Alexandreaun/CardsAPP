//
//  InsideViewController.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 02/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class InsideViewController: BaseViewController {
    
    var name: String?
    var type: String?
    var cards = [String]()
    let viewModel = InfoCardsViewModel(infoApiManager: InfoApiManager())
    private let refreshControl = UIRefreshControl()
    var isErrorApi: Bool = false
    
    //MARK: - UI
    lazy var viewBkButton: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .colorBackButton
        v.layer.cornerRadius = 33
        v.layer.masksToBounds = true
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFill
        let tgr = UITapGestureRecognizer(target: self, action: #selector(backToHome))
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
        v.font = UIFont().fontTitleSmall(size: 25).bold()
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
        v.alwaysBounceVertical = true
        v.showsVerticalScrollIndicator = false
        v.delegate = self
        v.dataSource = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutUI()
        configureUI()
        sendDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getResponseDetailsCards()
    }
    
    //MARK: - Methods
    private func sendDatas() {
        viewModel.name = name
        viewModel.type = type
        pullToRefresh()
    }
    
    private func getResponseDetailsCards() {
        showLoadingAnimation()
        viewModel.getDetailCards() { [weak self] (error) in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.hiddenLoadingAnimation()
                
                if error == nil {
                    self.isErrorApi = false
                    self.hiddenLoadingAnimation()
                    
                }else {
                    self.isErrorApi = true
                    self.hiddenLoadingAnimation()
                    self.handlerError()
                }
                self.bindUI()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func bindUI() {
        self.cards = isErrorApi ? viewModel.getDataImages() : viewModel.getImages()
        self.collection.reloadData()
    }
    
    private func pullToRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        getResponseDetailsCards()
        refreshControl.endRefreshing()
    }
    
    private func handlerError() {
        self.showError(buttonLabel: "OK", titleError: "ATENÇÃO!", messageError: "Tivemos um problema para atualizar as imagens. Pode ser a sua internet, verifique-a ou tente novamente mais tarde!")
    }
    
    private func configureUI() {
        labelTitle.text = type ?? ""
        collection.refreshControl = refreshControl
    }
    
    //MARK: - Auto Layout
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
            labelTitle.leftAnchor.constraint(equalTo: viewBkButton.rightAnchor, constant: 30),
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
    
    @objc func backToHome() {
        dismiss(animated: true, completion: nil)
    }
}

    //MARK: - Extension
extension InsideViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/2-5
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCardsCollectionViewCell.collectionDetailIdentifier, for: indexPath) as? DetailCardsCollectionViewCell else {return UICollectionViewCell()}
        
        if indexPath.item < cards.count {
            cell.imageCard.sd_setImage(with: URL(string: cards[indexPath.item])) { (image, error, imageCacheType, url) in
                if error != nil {
                    cell.imageCard.image = UIImage(named: "imagemindisponivel")
                }
            }
        }
        return cell
    }
}
