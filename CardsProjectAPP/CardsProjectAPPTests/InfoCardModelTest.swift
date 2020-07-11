//
//  InfoCardModelTest.swift
//  CardsProjectAPPTests
//
//  Created by Alexandre Carlos Aun on 11/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import XCTest
@testable import CardsProjectAPP

class InfoCardModelTest: XCTestCase {

 func testInitializeInfoCardModel(){
    
         let decode = JSONDecoder()
         decode.keyDecodingStrategy = .convertFromSnakeCase
         do {
             let model = try decode.decode(InfoCardModel.self, from: json)
            XCTAssertEqual(model.patch, "17.4.1.51510")
            XCTAssertEqual(model.classes?[0], "Death Knight")
            XCTAssertEqual(model.sets?[3], "Hall of Fame")
            XCTAssertEqual(model.standard?[0], "Basic")
            XCTAssertEqual(model.wild?[0], "Basic")
            XCTAssertEqual(model.types?[0], "Hero")
            XCTAssertEqual(model.factions?[0], "Horde")

         } catch {
             XCTFail()
         }
     }
     
 let json = Data("""
 {
     "patch": "17.4.1.51510",
     "classes": [
         "Death Knight"
     ],
     "sets": [
         "Basic",
         "Classic",
         "Promo",
         "Hall of Fame"
     ],
     "standard": [
         "Basic",
         "Classic",
         "Rise of Shadows",
         "Saviors of Uldum",
         "Descent of Dragons",
         "Galakrond's Awakening",
         "Ashes of Outland",
         "Demon Hunter Initiate"
     ],
     "wild": [
         "Basic",
         "Classic",
         "Hall of Fame",
         "Promo",
         "Naxxramas"
     ],
     "types": [
         "Hero"
     ],
     "factions": [
         "Horde",
         "Alliance",
         "Neutral"
     ],
     "qualities": [
         "Free"
     ],
     "races": [
         "Demon",
         "Dragon"
     ],
     "locales": [
         "deDE"
     ]
 }
 """.utf8)
}
