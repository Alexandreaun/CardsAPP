//
//  InfoCardModel.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 03/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import Foundation

struct InfoCardModel: Codable {
    let patch: String?
    let classes, sets, standard, wild: [String]?
    let types, factions, qualities, races: [String]?
    let locales: [String]?
}

class UnifyInfoCardModel {
    var typeName: String = ""
    var cardsModel: [String] = []
    init(typeName: String, cardsModel: [String]) {
        self.typeName = typeName
        self.cardsModel = cardsModel
    }
}

