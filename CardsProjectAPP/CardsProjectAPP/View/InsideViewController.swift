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
    
    lazy var labelTitle: UILabel = {
        let v = UILabel(frame: CGRect(x: 0, y: 0, width: 225, height: 55))
        v.textColor = .colorMainTitle
        v.numberOfLines = 1
        v.font = UIFont().fontTitleSmall(size: 18)
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
        view.addSubview(labelTitle)
        
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
        
        
        
    }
    


}

