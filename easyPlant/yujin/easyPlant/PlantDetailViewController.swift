//
//  PlantDetailViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit

class PlantDetailViewController: UIViewController {

    var data: String?
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var plantDetailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let test = data{
            plantDetailImage.image = UIImage(named: test)
            plantDetailImage.layer.cornerRadius = 110
            plantDetailImage.layer.borderColor = UIColor.lightGray.cgColor
            plantDetailImage.layer.borderWidth = 0.5

            testLabel?.text? = test
            
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
