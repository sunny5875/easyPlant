//
//  NotificationViewController.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var colorPickerView: UIColorWell!
    
    var myPlant: userPlant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "알림"
        if let myPlant = myPlant {
            titleLabel.text = "\(myPlant.name) 물 주기"
        } else {
            titleLabel.text = "잘못된 정보입니다."
        }
        colorPickerView.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
        
    }
    
    

    @objc func colorWellChanged(_ sender: Any) {
        myPlant?.color = colorPickerView.selectedColor ?? UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1))
        
        
        
    }
    
    
}
