//
//  NotificationViewController.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit

class NotificationViewController: UITableViewController {
    
    @IBOutlet weak var colorPickerView: UIColorWell!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var myPlant: userPlant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "알림"
        colorPickerView.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
    
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
    }
    
    @objc func changed () {
        // alarmTime 타입 Date로 바꾸기
        //myPlant?.alarmTime = datePicker.date
    }

    @objc func colorWellChanged(_ sender: Any) {
        myPlant?.color = colorPickerView.selectedColor ?? Color(uiColor:  Color(uiColor: UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1))))
    }
}


extension NotificationViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        if var myPlant = myPlant {
            myPlant.color = Color(uiColor: viewController.selectedColor)
        }
    }
}
