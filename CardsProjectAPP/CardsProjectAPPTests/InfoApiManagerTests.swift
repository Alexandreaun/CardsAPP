//
//  InfoApiManagerTests.swift
//  CardsProjectAPPTests
//
//  Created by Alexandre Carlos Aun on 11/07/20.
//  Copyright © 2020 Alexandre Carlos Aun. All rights reserved.
//

import XCTest
@testable import CardsProjectAPP

class InfoApiManagerTests: XCTestCase {
    
    func testCallEndPointInfoStatusCode() {
        
        let urlString: String = "https://omgvamp-hearthstone-v1.p.rapidapi.com/info?rapidapi-key=96a95fd7b6mshc4cf46eb9c7e4d7p1e2e40jsnb5be8b04e393"
        var statusCode: Int?
        var responseError: Error?
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            statusCode = httpResponse.statusCode
            responseError = error
            XCTAssertNil(responseError)
            XCTAssertEqual(statusCode, 200)
            
        }.resume()
    }
}
