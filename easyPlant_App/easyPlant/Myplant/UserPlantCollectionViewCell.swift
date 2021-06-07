//
//  userPlantCollectionViewCell.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit

class UserPlantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    
    
    
    func update(info: UserPlant) {
        print("cell info")
        //imageView.image = UIImage(named: info.plantImage)
        downloadUserPlantImage(imgview: imageView, title: "\(info.plantImage)")
        nameLabel.text = ""+info.name
      
        
       }
    

    
    
   
}
