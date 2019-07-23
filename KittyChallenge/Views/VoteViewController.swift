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
                if favoriteId != nil {
                    self?.showFavButon(false)
                }else{
                    self?.showWarning()
                }
            }
        }
    }
    
    @IBAction func UnfavoriteButton(_ sender: Any) {
        if let favId = vm.favoriteId {
            vm.unvoteAsFavorite(favoriteId: favId) { [weak self] (message) in
                if message != nil {
                    self?.showFavButon()
                }else{
                    self?.showWarning()
                }
            }
        }
    }
    
    func getImage(){
        FavoriteButton.isHidden = true
        UnfavoriteButton.isHidden = true
        NextButton.isHidden = true
        vm.getRandomImage {[weak self](kitty) in
            if let kitty = kitty {
                self?.showFavButon()
                self?.vm.kitty = kitty
                self?.vm.favoriteId = nil
                self?.NextButton.isHidden = false
                self?.CatImageView.kf.setImage(with: URL(string: kitty.url))
            } else {
                self?.showWarning()
            }
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
    
    func showWarning(){
        let dialogMessage = UIAlertController(title: "Connection Problem", message: "Cannot connect to server. Please check your connection and refresh.", preferredStyle: .alert)
        
        let refresh = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        })
        
        dialogMessage.addAction(refresh)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

