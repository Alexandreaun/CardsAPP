//
//  ValidationError.swift
//  CardsProjectAPP
//
//  Created by Alexandre Carlos Aun on 02/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import Foundation

class ValidationError: NSError{
    
    var titleError: String = ""
    var messageError: String = ""
    
    init(titleError: String, messageError: String){
        super.init(domain: titleError, code: 400, userInfo: [NSLocalizedDescriptionKey: messageError])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public struct Cards {
    let type: String
    let names: [Person]
}

public struct Person {
    let name: String
}
