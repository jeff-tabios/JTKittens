//
//  FavoritesViewModel.swift
//  KittyChallenge
//
//  Created by Jeff Tabios on 23/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

protocol FavoritesList{
    var favorites: Favorites? { get set }
}

class FavoritesViewModel: FavoritesList {
    let api = API()
    var favorites: Favorites?  = nil
    
    func getFavorites(completion: @escaping (Favorites?)->Void){
        api.request(endPoint: KittyAPI.getFavorites) {[weak self] (favorites: Favorites?) in
            if let favorites=favorites {
                self?.favorites = favorites
                completion(favorites)
            }else{
                completion(nil)
            }
            
        }
    }
}
