//
//  DecodingTests.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 20.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import XCTest
@testable import Weather_App

class DecodingTests: XCTestCase {

    var decoder: JSONDecoder!
    var data: Data!
    
    override func setUpWithError() throws {
        self.decoder = JSONDecoder()
    }
    
    func testOpenWeatherResponseDecoding() {
        let json = Bundle.main.path(forResource: "mockJsonResponse", ofType: "json")
        let url = URL(fileURLWithPath: json!)
        let data = try! Data(contentsOf: url)
        
        let decoded = try? decoder.decode(OpenWeatherResponse.self, from: data)
        
        XCTAssertNotNil(decoded)
    }
    
    func testPlacesDecoding() {
        let json = Bundle.main.path(forResource: "mockPlaces", ofType: "json")
        let url = URL(fileURLWithPath: json!)
        let data = try! Data(contentsOf: url)
        
        let decoded = try? decoder.decode(PlacesList.self, from: data)
        
        XCTAssertNotNil(decoded)
    }

    override func tearDownWithError() throws {
        self.decoder = nil
    }
}
