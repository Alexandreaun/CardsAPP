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
    
    //MARK: - Request endPoint Info
    func getInfoCards(completion: @escaping (ValidationError?) -> Void) {
        infoApiManager.getApiInfoCards { [weak self] (cards, error) in
            guard let self = self, let card = cards else {
                completion(error)
                return
            }
            if error == nil {
                self.listCards = self.loadNewListInfoCards(info: card)
                completion(nil)
                return
            }
            completion(error)
            return
        }
    }
    //MARK: - Load info cards
    func loadNewListInfoCards(info: InfoCardModel) -> [UnifyInfoCardModel] {
        let unity = [UnifyInfoCardModel(typeName: "Classes", cardsModel: info.classes ?? []),
                     UnifyInfoCardModel(typeName: "Sets", cardsModel: info.sets ?? []),
                     UnifyInfoCardModel(typeName: "Standard", cardsModel: info.standard ?? []),
                     UnifyInfoCardModel(typeName: "Wild", cardsModel: info.wild ?? []),
                     UnifyInfoCardModel(typeName: "Types", cardsModel: info.types ?? []),
                     UnifyInfoCardModel(typeName: "Factions", cardsModel: info.factions ?? []),
                     UnifyInfoCardModel(typeName: "Qualities", cardsModel: info.qualities ?? []),
                     UnifyInfoCardModel(typeName: "Races", cardsModel: info.races ?? [])
        ]
        return unity
    }
    
    //MARK: - Load titleForSections
    var titleForSections: [String] {
        get {
            var titleList = [String]()
            for title in listCards {
                titleList.append(title.typeName)
            }
            return titleList
        }
    }
    
    //MARK: - Request endPoint to Images
    func getDetailCards(completion: @escaping (ValidationError?) -> Void) {
        
        guard let typeDetail = type?.lowercased(), let nameDetail = name else {return}
        
        infoApiManager.getApiCardsDetail(typeDetail, nameDetail) { [weak self] (images, error) in
            guard let self = self, let detailCards = images else {
                completion(error)
                return}
            if error == nil {
                self.listDetailCards = detailCards
                completion(nil)
                return
            }
            DataManager.shared.saveDataImages(images: self.listDetailCards)
            completion(error)
            return
        }
    }
    
    func getImages() -> [String] {
        var listImages = [String]()
        for imgs in listDetailCards{
            if let img = imgs.img {
                listImages.append(img)
            }
        }
        return listImages
    }
    
    //MARK: - Fetch CoreData
    func loadDataImages() {
        DataManager.shared.loadDataImages { (imageCards) in
            if let images = imageCards {
                DataManager.shared.listDataImages = images
            }
        }
    }
    
    func getDataImages() -> [String] {
        loadDataImages()
        let dataImages = DataManager.shared.listDataImages
        var listImagesStrings = [String]()
        for items in dataImages {
            if let item = items.img {
                listImagesStrings.append(item)
            }
        }
        return listImagesStrings
    }
}
