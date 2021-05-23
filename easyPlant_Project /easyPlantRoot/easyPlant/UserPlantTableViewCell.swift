//
//  UserPlantTableViewCell.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit

class UserPlantTableViewCell: UITableViewCell {

    @IBOutlet weak var plantCellView: UIView!
    @IBOutlet weak var lastWater: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var wateringButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with plant: userPlant) {
        
    }
    
    @IBAction func watering(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date_string = formatter.string(from: Date())
        
        lastWater.text = current_date_string
        wateringButton.isSelected = true
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
      if highlighted {
        self.plantCellView.backgroundColor = UIColor.lightGray
      } else {
        self.plantCellView.backgroundColor = UIColor(cgColor: CGColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1))
      }
    }
     
    override func setSelected(_ selected: Bool, animated: Bool) {
      if selected {
        self.plantCellView.backgroundColor = UIColor(cgColor: CGColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1))
      } else {
        self.plantCellView.backgroundColor = UIColor(cgColor: CGColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1))
      }
    }
 
}
