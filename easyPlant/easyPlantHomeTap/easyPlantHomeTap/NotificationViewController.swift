//
//  NotificationViewController.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var colorLabel: UILabel!
    var myPlant: UserPlant?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cycleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "알림"
        colorLabel.text = 
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let myPlant = myPlant {
            titleLabel.text = "\(myPlant.name) 물주기"
            cycleLabel.text = myPlant.cycle
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
