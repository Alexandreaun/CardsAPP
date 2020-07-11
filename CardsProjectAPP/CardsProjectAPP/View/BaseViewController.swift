//
//  BaseViewController.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 06/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit
import FSnapChatLoading

class BaseViewController: UIViewController {

    let loadingView = FSnapChatLoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingAnimation() {
        loadingView.show(view: self.view, color: .red)
    }
    
    func hiddenLoadingAnimation() {
        loadingView.hide()
    }
}
