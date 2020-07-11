//
//  RandomColors.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 06/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class RandomColors {
    
    public static func randomColors(numberOfItems: Int) -> [UIColor]{
        
        var numberColor: CGFloat = 0
        var listOfColors = [UIColor]()
        var listFloat = [CGFloat]()
        
        for _ in 0...numberOfItems {
            numberColor = CGFloat.random(in: 0...0.58)
            listFloat.append(numberColor)
        }
        
        for cor in listFloat {
            let randomColorCell = UIColor(red: cor, green: .random(in: 0...0.58) , blue: cor, alpha: 1)
            listOfColors.append(randomColorCell)
        }
        return listOfColors
    }
}
