//
//  InfoCardsViewModelTests.swift
//  CardsProjectAPPTests
//
//  Created by Alexandre Carlos Aun on 10/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import XCTest
@testable import CardsProjectAPP

class InfoCardsViewModelTests: XCTestCase {

    let viewModel = InfoCardsViewModel(infoApiManager: InfoApiManager())

    var listCardsTest = [UnifyInfoCardModel(typeName: "Types", cardsModel: ["Hero", "Spell"]),
                         UnifyInfoCardModel(typeName: "Classes", cardsModel: ["Druid", "Rogue", "Dream"])]
    
    var listDetailCardsTest = [DetailCardModel(img: "http://", imgGold: "https://")]
    
    
    func testIfArrayListCardsHasCorrectAmount() {
        viewModel.listCards = listCardsTest
        XCTAssertEqual(viewModel.listCards.count, listCardsTest.count)
    }
    
    func testNameOfTitleForSections() {
        let nameTitle = viewModel.titleForSections
        let nameTitleTest = "Test"
        
        for name in nameTitle {
            XCTAssertEqual(name, nameTitleTest)
        }
    }
    
    func testIfArrayListDetailHasCorrectAmount () {
        viewModel.listDetailCards = listDetailCardsTest
        XCTAssertEqual(viewModel.listDetailCards.count, listDetailCardsTest.count)
    }
}
