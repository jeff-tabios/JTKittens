//
//  VoteVMTests.swift
//  KittyChallengeTests
//
//  Created by Jeff Tabios on 23/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import KittyChallenge

class VoteVMTests: XCTestCase {
    let vm = VoteViewModel()

    func test_getRandomCat(){
        vm.getRandomImage { kitty in
            XCTAssertNotNil(kitty)
        }
    }
    
    func test_voteThenUnvoteAsFavorite(){
        vm.voteAsFavorite(imageId: "NKKsogN72") { [weak self] (favoriteId) in
            XCTAssertNotNil(favoriteId)
            if favoriteId != nil {
                guard let favId = self?.vm.favoriteId else {
                    XCTAssert(false)
                    return
                }
                self?.vm.unvoteAsFavorite(favoriteId: favId, completion: { (message) in
                    XCTAssertEqual(message, "SUCCESS")
                })
            }
        }
    }
    
}
