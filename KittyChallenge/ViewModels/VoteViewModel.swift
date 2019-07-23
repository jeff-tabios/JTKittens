//
//  RandomCatViewModel.swift
//  KittyChallenge
//
//  Created by Jeff Tabios on 23/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

protocol Votable{
    var kitty: Kitty? { get set }
    var favoriteId: Int? { get set }
    func getRandomImage(completion: @escaping (Kitty?)->Void)
    func voteAsFavorite(imageId:String,completion: @escaping (Int?)->Void)
    func unvoteAsFavorite(favoriteId:Int,completion: @escaping (String?)->Void)
}

class VoteViewModel: Votable {
    let api = API()
    var kitty: Kitty? = nil
    var imageId: String? = nil
    var favoriteId: Int? = nil
    
    func getRandomImage(completion: @escaping (Kitty?)->Void){
        api.request(endPoint: KittyAPI.getRandomCat) { [weak self] (kitties: Kitties?) in
            if let kitties = kitties  {
                self?.kitty = kitties[0]
                completion(kitties[0])
            } else {
                completion(nil)
            }
        }
    }
    
    func voteAsFavorite(imageId: String, completion: @escaping (Int?) -> Void) {
        api.request(endPoint: KittyAPI.setAsFavorite(id: imageId)) {[weak self] (favoured: Favoured?) in
            if let favoured = favoured {
                self?.favoriteId = favoured.id
                 completion(favoured.id)
            }else{
                completion(nil)
            }
        }
    }
    
    func unvoteAsFavorite(favoriteId: Int, completion: @escaping(String?) -> Void) {
        api.request(endPoint: KittyAPI.unsetAsFavorite(id: favoriteId)) { [weak self] (message: Message?) in
            if let message = message {
                self?.favoriteId = nil
                completion(message.message)
            }else{
                completion(nil)
            }
        }
    }
    
    
}
