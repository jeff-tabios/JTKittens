//
//  CollectionCell.swift
//  KittyChallenge
//
//  Created by Jeff Tabios on 23/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

protocol CatCellDelegate: AnyObject {
    func unfavCat(_ favoriteId:Int, at indexPath: IndexPath)
}

class CollectionCell: UICollectionViewCell {
    
    weak var delegate:CatCellDelegate?
    var favoriteId: Int?
    var indexPath: IndexPath?
    @IBOutlet weak var catImage: UIImageView!
    
    @IBAction func unfavourButton(_ sender: Any) {
        guard let indexPath = indexPath, let favoriteId=favoriteId else { return }
        delegate?.unfavCat(favoriteId,at: indexPath)
    }
}

