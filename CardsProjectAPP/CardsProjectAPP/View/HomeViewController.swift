//
//  ViewController.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 02/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var viewModel = InfoCardsViewModel(infoApiManager: InfoApiManager())
    private let refreshControl = UIRefreshControl()

    //MARK: - UI
    lazy var labelTitle: UILabel = {
        let v = UILabel(frame: CGRect(x: 0, y: 0, width: 225, height: 55))
        v.textColor = .colorMainTitle
        v.numberOfLines = 1
        v.font = UIFont().fontMainTitleBig()
        v.adjustsFontSizeToFitWidth = true
        v.text = "Hearthstone"
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var dividerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var tableview: UITableView = {
        let v = UITableView()
        v.backgroundColor = .colorBkg
        v.allowsSelection = false
        v.tableFooterView = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutUI()
        instantiateUI()
        pullToRefresh()
        getResponseInfoListCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoadingAnimation()
        getResponseInfoListCards()
    }
    //MARK: - Methods
    private func instantiateUI() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ListCardsTableViewCell.self, forCellReuseIdentifier: ListCardsTableViewCell.tableviewIdentifier)
        tableview.refreshControl = refreshControl
    }
    
    private func getResponseInfoListCards() {
        viewModel.getInfoCards { [weak self] (error) in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                if error == nil {
                    self.tableview.reloadData()
                    self.hiddenLoadingAnimation()
                }else{
                    self.handlerErrorRequestInfo()
                    self.hiddenLoadingAnimation()
                }
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func pullToRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        getResponseInfoListCards()
        refreshControl.endRefreshing()
    }
    
    private func handlerErrorRequestInfo() {
        showError(buttonLabel: "OK", titleError: "ATENÇÃO!", messageError: "Tivemos um problema para atualizar as informações dos Cards. Pode ser a sua internet, verifique-a ou tente novamente mais tarde!")
    }
    
    //MARK: - Auto Layout
    private func setupLayoutUI() {
        view.backgroundColor = .colorBkg
        view.addSubview(labelTitle)
        view.addSubview(dividerView)
        view.addSubview(tableview)
        
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
            labelTitle.topAnchor.constraint(equalTo: topanchor, constant: 91),
            labelTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 37),
            labelTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -113)
        ])
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
            dividerView.leftAnchor.constraint(equalTo: labelTitle.leftAnchor, constant: 3),
            dividerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 33),
            tableview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableview.bottomAnchor.constraint(equalTo: bottomanchor, constant: 0)
        ])
    }
}
    //MARK: - Extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.listCards.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ListCardsTableViewCell = tableView.dequeueReusableCell(withIdentifier: ListCardsTableViewCell.tableviewIdentifier, for: indexPath) as? ListCardsTableViewCell else {return UITableViewCell()}
        cell.infoNames = viewModel.listCards[indexPath.section].cardsModel
        cell.typeSelected = viewModel.listCards[indexPath.section]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
    //MARK: - Delegate
extension HomeViewController: CustomCellDelegate  {
    
    func onClickCollectionViewCell(cell: UICollectionViewCell?, type: String, name: String) {
        let vc = InsideViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.name = name
        vc.type = type
        present(vc, animated: true, completion: nil)
    }
}
