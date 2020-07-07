//
//  UIImage+Extension.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 06/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadWebImage(imageView: UIImageView, string: String) {
        imageView.sd_setImage(with: URL(string: string), completed: nil)
    }
    
}
