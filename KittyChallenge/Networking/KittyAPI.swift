//
//  KittyAPI.swift
//  KittyChallenge
//
//  Created by Jeff Tabios on 22/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

enum KittyAPI {
    case getRandomCat
    case setAsFavorite(id:String)
    case unsetAsFavorite(id:Int)
    case getFavorites
}

extension KittyAPI: EndPoint {
    
    var apiKey: String { return "c1f0fa1c-8b69-4279-8f28-8067f169e894"}
    var userid: String { return "8ee6v2"}
    var baseURL: String { return "https://api.thecatapi.com/v1"}
    
    var path: String {
        switch self {
        case .getRandomCat:
            return "/images/search"
        case .setAsFavorite:
            return "/favourites"
        case .unsetAsFavorite(let favorite_id):
            return "/favourites/\(favorite_id)"
        case .getFavorites:
            return "/favourites"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRandomCat:
            return .get
        case .setAsFavorite:
            return .post
        case .unsetAsFavorite:
            return .delete
        case .getFavorites:
            return .get
        }
        
    }
    
    var headers: HTTPHeaders {
        var items = HTTPHeaders()
        items["x-api-key"] = apiKey
        return items
    }
    
    var params: Parameters {
        var items = Parameters()
        switch self {
        case .getRandomCat:
            break
        case .setAsFavorite(let id):
            items["image_id"] = "\(id)"
            items["sub_id"] = userid
        case .unsetAsFavorite:
            break
        case .getFavorites:
            break
        }
        return items
    }
}
