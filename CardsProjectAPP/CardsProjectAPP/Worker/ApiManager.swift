//
//  ApiManager.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 03/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import Foundation

protocol CardsRequestDelegate: class {
    func getApiInfoCards(completion: @escaping (InfoCardModel?, ValidationError?) -> Void)
}

class ApiManager: CardsRequestDelegate {
    
    func getApiInfoCards(completion: @escaping (InfoCardModel?, ValidationError?) -> Void) {
        
        let urlString = "https://omgvamp-hearthstone-v1.p.rapidapi.com/info?rapidapi-key=96a95fd7b6mshc4cf46eb9c7e4d7p1e2e40jsnb5be8b04e393"
        let error = ValidationError(titleError: "", messageError: "Não foi possível carregar os dados")
        
        guard let url = URL(string: urlString) else {
            completion(nil, error)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            let error = ValidationError(titleError: "", messageError: "Não foi possível carregar os dados")

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            
            if httpResponse.statusCode == 200{
                guard let datas = data else{
                    completion(nil, error)
                    return
                }
                
                do {
                    let decode = JSONDecoder()
                    decode.keyDecodingStrategy = .convertFromSnakeCase
                    let json = try decode.decode(InfoCardModel.self, from: datas)
                    completion(json, nil)
                }catch{
                    let error = ValidationError(titleError: "", messageError: "Não foi possível carregar os dados")
                    completion(nil, error)
                }
            }else{
                let error = ValidationError(titleError: "", messageError: "Erro \(httpResponse.statusCode)")
                completion(nil, error)
            }
        }.resume()
    }
    
}
