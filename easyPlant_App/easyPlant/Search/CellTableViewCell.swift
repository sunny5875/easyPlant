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
    
    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var rightCellView: UIView!
    @IBOutlet weak var leftCellView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    
    
    //셀의 디자인 설정
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        //self.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        self.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        rightCellView.backgroundColor =  UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        rightCellView.layer.cornerRadius = 30
        leftCellView.backgroundColor =  UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        leftCellView.layer.cornerRadius = 30
        
        rightImageButton.layer.cornerRadius = 30
        leftImageButton.layer.cornerRadius = 30
        
        rightButton.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        
        leftButton.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))


        leftImageButton.contentMode = .scaleAspectFit
        rightImageButton.contentMode = .scaleAspectFit
        
     
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
