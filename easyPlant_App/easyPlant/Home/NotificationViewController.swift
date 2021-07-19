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
    
    var myPlant: UserPlant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        datePicker.date = myPlant?.alarmTime ?? Date()
        self.title = "알림"
        colorPickerView.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
    
        colorPickerView.tintColor = myPlant?.color.uiColor
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
        
    }
    
    @objc func changed () {
        
        for i in 0...(userPlants.count-1) {
            if(userPlants[i].name == myPlant?.name){
                userPlants[i].alarmTime = datePicker.date
                saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)

                break
            }
        }
    }

    @objc func colorWellChanged(_ sender: Any) {
        
        for i in 0...(userPlants.count-1) {
            if(userPlants[i].name == myPlant?.name){
                userPlants[i].color = Color(uiColor: colorPickerView.selectedColor ?? UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1)))
                saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)

                break
            }
        }
 
    }
}


extension NotificationViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        if var myPlant = myPlant {
            myPlant.color = Color(uiColor: viewController.selectedColor)
        }
    }
}
