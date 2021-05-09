//
//  userPlantCollectionViewCell.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit

class userPlantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    
    
    
    func update(info: userPlant) {
        imageView.image = UIImage(named: info.plantImage)
        nameLabel.text = info.name
      
        
       }
    

    
    
   
}
