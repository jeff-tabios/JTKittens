//
//  Favourites.swift
//  KittyChallenge
//
//  Created by Jeff Tabios on 22/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

// MARK: - Favorite
struct Favorite: Codable {
    let id: Int
    let userID, imageID, subID, createdAt: String
    let image: CatImage
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case imageID = "image_id"
        case subID = "sub_id"
        case createdAt = "created_at"
        case image
    }
}

// MARK: - Image
struct CatImage: Codable {
    let id: String
    let url: String
}

typealias Favorites = [Favorite]

// MARK: - Favoured
struct Favoured: Codable {
    let message: String
    let id: Int
}

// MARK: - message
struct Message: Codable {
    let message: String
}
