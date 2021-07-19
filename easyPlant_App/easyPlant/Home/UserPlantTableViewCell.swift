//
//  UserPlantTableViewCell.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit

class UserPlantTableViewCell: UITableViewCell {

    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var plantColor: UIButton!
    @IBOutlet weak var noPlantLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(with plant: UserPlant) {
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
      if highlighted {
        self.contentView.backgroundColor = UIColor.white
      } else {
        self.contentView.backgroundColor = UIColor.white
      }
    }
     
    override func setSelected(_ selected: Bool, animated: Bool) {
      if selected {
        self.contentView.backgroundColor = UIColor.white
      } else {
        self.contentView.backgroundColor = UIColor.white
      }
    }
 
}
