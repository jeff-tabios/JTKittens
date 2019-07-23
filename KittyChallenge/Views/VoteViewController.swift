//
//  ViewController.swift
//  KittyChallenge
//
//  Created by Jeff Tabios on 22/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import UIKit
import Kingfisher

class VoteViewController: UIViewController {

    @IBOutlet weak var CatImageView: UIImageView!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var UnfavoriteButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    
    let vm = VoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        getImage()
    }

    @IBAction func NextButton(_ sender: Any) {
        getImage()
    }
    
    @IBAction func FavoriteButton(_ sender: Any) {
        if let kitty = vm.kitty {
            vm.voteAsFavorite(imageId: kitty.id) { [weak self] (favoriteId) in
                if favoriteId != nil { self?.showFavButon(false)}
            }
        }
    }
    
    @IBAction func UnfavoriteButton(_ sender: Any) {
        if let favId = vm.favoriteId {
            vm.unvoteAsFavorite(favoriteId: favId) { [weak self] (message) in
                if message != nil { self?.showFavButon() }
            }
        }
    }
    
    func getImage(){
        vm.getRandomImage {[weak self](kitty) in
            guard let kitty = kitty else {return}
            self?.showFavButon()
            self?.vm.kitty = kitty
            self?.vm.favoriteId = nil
            self?.CatImageView.kf.setImage(with: URL(string: kitty.url))
        }
    }
    
    func showFavButon(_ bool:Bool=true){
        if bool == true {
            FavoriteButton.isHidden = false
            UnfavoriteButton.isHidden = true
        }else{
            FavoriteButton.isHidden = true
            UnfavoriteButton.isHidden = false
        }
    }
}

