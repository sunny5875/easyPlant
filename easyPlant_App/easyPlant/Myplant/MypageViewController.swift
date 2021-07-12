//
//  MypageViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/07/12.
//

import UIKit

class MypageViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var myInfo: UIView!
    
    @IBOutlet weak var guide: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        myInfo.layer.zPosition = 100
        guide.layer.zPosition = 100
        
        myInfo.layer.cornerRadius = 30
        guide.layer.cornerRadius = 30
        
        profileImage.layer.cornerRadius = profileImage.layer.frame.width/2
        
        myInfo.layer.shadowOpacity = 0.1
        myInfo.layer.shadowOffset = CGSize(width: 0, height: 3)
        myInfo.layer.shadowRadius = 30
        myInfo.layer.masksToBounds = false
        
        guide.layer.shadowOpacity = 0.1
        guide.layer.shadowOffset = CGSize(width: 0, height: 3)
        guide.layer.shadowRadius = 30
        guide.layer.masksToBounds = false
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
