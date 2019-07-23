//
//  NetworkingTests.swift
//  KittyChallengeTests
//
//  Created by Jeff Tabios on 23/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import KittyChallenge

class NetworkingTests: XCTestCase {
    
    let api = API()
    
    func test_getRandomCatImage(){
        api.request(endPoint: KittyAPI.getRandomCat) { (kitties: Kitties?) in
            XCTAssertNotNil(kitties)
        }
    }
    
    func test_favourThenUnfavourCat(){
        api.request(endPoint: KittyAPI.setAsFavorite(id: "NKKsogN72")) { [weak self] (favoured: Favoured?) in
            XCTAssertNotNil(favoured)
            if let favoured = favoured {
                self?.api.request(endPoint: KittyAPI.unsetAsFavorite(id: favoured.id)) { (message: Message?) in
                    XCTAssertEqual(message?.message, "SUCCESS")
                }
            }
        }
    }
    
    func test_getFavorites(){
        api.request(endPoint: KittyAPI.getFavorites) { (favorites: Favorites?) in
            XCTAssertNotNil(favorites)
        }
    }
}
