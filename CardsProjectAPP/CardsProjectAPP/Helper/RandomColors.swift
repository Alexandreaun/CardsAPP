//
//  RandomColors.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 06/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class RandomColors {
    
    public static func fillBackgroundCell(numberOfItems: Int) -> [UIColor] {
        var listColors = [UIColor]()
        for _ in 1...numberOfItems {
            let color: UIColor = .randomColorCell

            listColors.append(color)
        }
        return listColors
    }
}

