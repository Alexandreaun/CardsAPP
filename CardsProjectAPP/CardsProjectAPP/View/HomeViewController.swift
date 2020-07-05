//
//  ViewController.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 02/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = InfoCardsViewModel(apiManager: ApiManager())
    var infoCards = [UnifyInfoCardModel]()
    var isApiError: Bool = false
    
    lazy var labelTitle: UILabel = {
        let v = UILabel(frame: CGRect(x: 0, y: 0, width: 225, height: 55))
        v.textColor = .colorMainTitle
        v.numberOfLines = 1
        v.font = UIFont().fontMainTitleBig()
        v.adjustsFontSizeToFitWidth = true
        v.minimumScaleFactor = 15
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutUI()
        instantiateUI()
        getResponseInfoListCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getResponseInfoListCards()
    }
    
    private func instantiateUI() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ListCardsTableViewCell.self, forCellReuseIdentifier: ListCardsTableViewCell.tableviewIdentifier)

    }
    
    private func getResponseInfoListCards() {
        
        viewModel.getInfoCards { [weak self] (error) in
            guard let self = self else {return}
            if error == nil {
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }else{
                //TODO: - Tratar em caso de erro de request
            }
        }
    }
    
    private func handlerErrorRequestInfo() {
        showError(buttonLabel: "Ok", titleError: "Desculpe!", messageError: "Tivemos um problema para atualizar a moeda escolhida. Tente novamente mais tarde!")
    }
    
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
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}

extension HomeViewController: CustomCellDelegate {
    func onClickCollectionViewCell(cell: UICollectionViewCell?, type: String, index: Int) {
       let vc = InsideViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.type = type
        present(vc, animated: true, completion: nil)
    }
}


