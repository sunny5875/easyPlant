//
//  diaryCollectionViewCell.swift
//  easyPlant_myPlant
//
//  Created by νμλΉ on 2021/04/30.
//

import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func update(info : Diary){
  
        downloadDiaryImage(imgview: imageView!, title: "\(info.picture)")
    }
}
