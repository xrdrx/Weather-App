//
//  Place Struct Tests.swift
//  Weather AppTests
//
//  Created by Aleksandr Svetilov on 20.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import XCTest
@testable import Weather_App

class Place_Struct_Tests: XCTestCase {
    
    let viewModel = HomeViewModel()

    var placeWithStateWithCountry: Place!
    var placeWithStateWithoutCountry: Place!
    var placeWithoutStateWithCountry: Place!
    var placeWithoutStateWithoutCountry: Place!
    
    let mockCoords = Coord(lon: 13, lat: 37)
    
    override func setUpWithError() throws {
        self.placeWithStateWithCountry = Place(id: 0, name: "PlaceStateCountry", state: .ak, country: .ru, coord: mockCoords)
        self.placeWithStateWithoutCountry = Place(id: 0, name: "PlaceStateNoCountry", state: .az, country: .empty, coord: mockCoords)
        self.placeWithoutStateWithCountry = Place(id: 0, name: "PlaceNoStateWithCountry", state: .empty, country: .am, coord: mockCoords)
        self.placeWithoutStateWithoutCountry = Place(id: 0, name: "PlaceNoStateNoCountry", state: .empty, country: .empty, coord: mockCoords)
    }
    
    func testPlaceDescription() {
        let placeStateCountry = viewModel.getPlaceDescription(placeWithStateWithCountry)
        let placeStateNoCountry = viewModel.getPlaceDescription(placeWithStateWithoutCountry)
        let placeNoStateCountry = viewModel.getPlaceDescription(placeWithoutStateWithCountry)
        let placeNoStateNoCountry = viewModel.getPlaceDescription(placeWithoutStateWithoutCountry)
        
        XCTAssertEqual(placeStateCountry, "PlaceStateCountry, AK, RU")
        XCTAssertEqual(placeStateNoCountry, "PlaceStateNoCountry, AZ")
        XCTAssertEqual(placeNoStateCountry, "PlaceNoStateWithCountry, AM")
        XCTAssertEqual(placeNoStateNoCountry, "PlaceNoStateNoCountry")
    }

    override func tearDownWithError() throws {
        
    }
}
