//
//  CellTableViewCell.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageButton: UIButton!
    
    @IBOutlet weak var rightImageButton: UIButton!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
