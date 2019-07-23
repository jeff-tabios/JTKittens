//
//  FavoritesViewCOntroller.swift
//  KittyChallenge
//
//  Created by Jeff Tabios on 23/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {
    
    let vm = FavoritesViewModel()
    let voteVm = VoteViewModel()
    let reuseIdentifier = "catThumb"
    @IBOutlet weak var FavoritesCollectionView: UICollectionView!
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getFavorites()
    }
    
    func getFavorites(){
        vm.getFavorites { [weak self] (favorites) in
            if favorites != nil {
                self?.FavoritesCollectionView.reloadData()
            }else{
                self?.showWarning()
            }
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

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let favs = vm.favorites else { return 0 }
        return favs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.backgroundColor = .white
        if let favs = vm.favorites
        {
            cell.favoriteId = favs[indexPath.row].id
            let url = favs[indexPath.row].image.url
            cell.catImage.kf.setImage(with: URL(string: url))
        }
        return cell
    }
}

extension FavoritesViewController: CatCellDelegate{
    func unfavCat(_ favoriteId: Int, at indexPath: IndexPath) {
        voteVm.unvoteAsFavorite(favoriteId: favoriteId) { [weak self](message) in
            if message != nil {
                self?.getFavorites()
            }else{
                self?.showWarning()
            }
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension FavoritesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
