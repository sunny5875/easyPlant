//
//  NotificationViewController.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit

class NotificationViewController: UITableViewController {
    
    @IBOutlet weak var colorPickerView: UIColorWell!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var myPlant: userPlant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        self.title = "알림"
        
        if let myPlant = myPlant {
            titleLabel.text = "\(myPlant.name) 설정"
        } else {
            titleLabel.text = "잘못된 정보입니다."
        }

        colorPickerView.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        colorPickerView.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
        
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
    }
    
    @objc func changed () {
        // alarmTime 타입 Date로 바꾸기
        //myPlant?.alarmTime = datePicker.date
    }

    @objc func colorWellChanged(_ sender: Any) {
        myPlant?.color = colorPickerView.selectedColor ?? UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1))
    }
}


extension NotificationViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        if var myPlant = myPlant {
            myPlant.color = viewController.selectedColor
        }
    }
}
