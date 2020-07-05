//
//  InfoCardsInteractor.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 03/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class InfoCardsViewModel {
    
    let apiManager: CardsRequestDelegate
    var listCards = [UnifyInfoCardModel]()
    
    init(apiManager: CardsRequestDelegate) {
        self.apiManager = apiManager
    }
    
    func getInfoCards(completion: @escaping (ValidationError?) -> Void) {
        apiManager.getApiInfoCards { (cards, error) in
            if error == nil {
                self.listCards = self.loadNewListInfoCards(info: cards)
                completion(nil)
                return
            }
            completion(error)
            return
        }
    }
    
    //TODO: - Tratar excessão em caso de dados nulos
    func loadNewListInfoCards(info: InfoCardModel?) -> [UnifyInfoCardModel] {
        var unifyInfo = [UnifyInfoCardModel]()
        let unity = [UnifyInfoCardModel(typeName: "Classes", cardsModel: info?.classes ?? []),
                     UnifyInfoCardModel(typeName: "Sets", cardsModel: info?.sets ?? []),
                     UnifyInfoCardModel(typeName: "Standard", cardsModel: info?.standard ?? []),
                     UnifyInfoCardModel(typeName: "Wild", cardsModel: info?.wild ?? []),
                     UnifyInfoCardModel(typeName: "Types", cardsModel: info?.types ?? []),
                     UnifyInfoCardModel(typeName: "Factions", cardsModel: info?.factions ?? []),
                     UnifyInfoCardModel(typeName: "Qualities", cardsModel: info?.qualities ?? []),
                     UnifyInfoCardModel(typeName: "Races", cardsModel: info?.races ?? [])
        ]
        unifyInfo = unity

        return unifyInfo
    }
    
    var titleForSections: [String] {
        get {
            var titleList = [String]()
            for title in listCards {
                titleList.append(title.typeName)
            }
            return titleList
        }
    }
    

    
  
    

    
    
    
}
