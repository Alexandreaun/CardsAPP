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
    
    func saveDataImages(images: [DetailCardModel]) {
        let context = persistentContainer.viewContext
        
        for values in images {
            let imageCards = DataDetailCards(context: context)
            guard let val = values.img else {
                imageCards.img = ""
                return
            }
            imageCards.img = val
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
}
