//
//  DataManager.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 06/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import Foundation
import CoreData

class DataManager: NSObject {
    static let shared = DataManager()
    override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var listDataImages = [DataDetailCards]()
    
    var dataInfoCards = [DataInfoCards]()
    var dataListInfoCards = [DataListInfoCards]()
    
    func saveDataInfoCards(infoCard: [UnifyInfoCardModel]) {
        let context = persistentContainer.viewContext
        let infoList = DataInfoCards(context: context)
        let namesList = DataListInfoCards(context: context)
        
        for values in infoCard {
            infoList.typeName = values.typeName
            
            for val in values.cardsModel {
                namesList.nameList = val
            }
        }
        
            do {
                try context.save()
            } catch {
                let nserror = ValidationError(titleError: "Erro", messageError: "Não foi possível gravar os dados")
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        
    }
    
    func saveDataImages(images: [DetailCardModel]) {
        let context = persistentContainer.viewContext
        
        for values in images {
            let imageCards = DataDetailCards(context: context)
            imageCards.img = values.img
        }
        
            do {
                try context.save()
            } catch {
                let nserror = ValidationError(titleError: "Erro", messageError: "Não foi possível gravar os dados")
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        
    }
    
    func loadDataImages(completion: ([DataDetailCards]?) -> Void) {
        let context = persistentContainer.viewContext
        let request1 = NSFetchRequest<NSFetchRequestResult>(entityName: "DataDetailCards")
        
        do {
            let result1 = try context.fetch(request1)

            self.listDataImages = result1 as? [DataDetailCards] ?? []
            completion(listDataImages)
        }catch {
            print(error.localizedDescription)
            completion(nil)
        }
    }

    func loadDataInfoCards(completion: ([DataInfoCards]?, [DataListInfoCards]?) -> Void) {
        let context = persistentContainer.viewContext
        
        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName: "DataInfoCards")
        let request3 = NSFetchRequest<NSFetchRequestResult>(entityName: "DataListInfoCards")
        
        do {
            let result2 = try context.fetch(request2)
            let result3 = try context.fetch(request3)

            self.dataInfoCards = result2 as? [DataInfoCards] ?? []
            self.dataListInfoCards = result3 as? [DataListInfoCards] ?? []
            
//            for values in dataInfoCards {
//                let dataInfo = DataInfoCards()
//                dataInfo.names = values.names
//            }
            completion(dataInfoCards, dataListInfoCards)
            
        }catch {
            print(error.localizedDescription)
            completion(nil, nil)
        }
    }
    
    
    
    
    
    
    
    
}
