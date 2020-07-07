//
//  InfoCardsInteractor.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 03/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import UIKit

class InfoCardsViewModel {
    
    let infoApiManager: InfoRequestDelegate
    var listCards = [UnifyInfoCardModel]()
    var listDetailCards = [DetailCardModel]()
    
    var name: String?
    var type: String?
    
    init(infoApiManager: InfoRequestDelegate) {
        self.infoApiManager = infoApiManager
    }
    
    func getInfoCards(completion: @escaping (ValidationError?) -> Void) {
        infoApiManager.getApiInfoCards { [weak self] (cards, error) in
            guard let self = self else {return}
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
        let unity = [UnifyInfoCardModel(typeName: "Classes", cardsModel: info?.classes ?? []),
                     UnifyInfoCardModel(typeName: "Sets", cardsModel: info?.sets ?? []),
                     UnifyInfoCardModel(typeName: "Standard", cardsModel: info?.standard ?? []),
                     UnifyInfoCardModel(typeName: "Wild", cardsModel: info?.wild ?? []),
                     UnifyInfoCardModel(typeName: "Types", cardsModel: info?.types ?? []),
                     UnifyInfoCardModel(typeName: "Factions", cardsModel: info?.factions ?? []),
                     UnifyInfoCardModel(typeName: "Qualities", cardsModel: info?.qualities ?? []),
                     UnifyInfoCardModel(typeName: "Races", cardsModel: info?.races ?? [])
        ]
        return unity
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
    
    func getDetailCards(completion: @escaping (ValidationError?) -> Void) {
        
        guard let typeDetail = type, let nameDetail = name else {return}
        
        infoApiManager.getApiCardsDetail(typeDetail, nameDetail) { [weak self] (detailCard, error) in
            guard let self = self, let detailCards = detailCard else {return}
            if error == nil {
                self.listDetailCards = detailCards
                completion(nil)
                return
            }
            completion(error)
            return
        }
    }
    
    func getImages() -> [String] {
        var listImags = [String]()
        
        for imgs in listDetailCards{
            if let img = imgs.img {
                listImags.append(img)
            }
        }
        return listImags
    }
}
