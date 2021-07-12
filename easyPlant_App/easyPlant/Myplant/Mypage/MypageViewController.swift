//
//  MypageViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/07/12.
//

import UIKit

class MypageViewController: UIViewController {

    @IBOutlet var infoLabels: [UILabel]!
    
    @IBOutlet weak var myInfo: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var guide: UIView!
    @IBOutlet weak var camerabut: UIButton!
    
    @IBOutlet weak var cameraBackground: UIImageView!
    @IBOutlet weak var guideImage: UIButton!
    @IBOutlet weak var guideButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        
    }
    
    func updateUI(){
        myInfo.layer.zPosition = 100
        guide.layer.zPosition = 100
        guideButton.layer.zPosition = 102
        guideImage.layer.zPosition = 101
        camerabut.layer.zPosition = 100

        
        myInfo.layer.cornerRadius = 30
        guide.layer.cornerRadius = 30
        guideButton.layer.cornerRadius = 30
        cameraBackground.layer.cornerRadius =
            cameraBackground.layer.frame.width/2
        cameraBackground.backgroundColor = .white
      
        myInfo.layer.shadowOpacity = 0.2
        myInfo.layer.shadowOffset = CGSize(width: 0, height: 10)
        myInfo.layer.shadowRadius = 30
        myInfo.layer.masksToBounds = false
        
        guide.layer.shadowOpacity = 0.2
        guide.layer.shadowOffset = CGSize(width: 0, height: 10)
        guide.layer.shadowRadius = 30
        guide.layer.masksToBounds = false
        
        
        infoLabels[0].text = String(myUser.numPlants)
        infoLabels[1].text = String(myUser.hapiness)
        infoLabels[2].text = String(myUser.growingDays)

        
    }
  
    
    @IBAction func cameraClicked(_ sender: Any) {
        print("camera click")
    }
    
    
    @IBAction func guidebut(_ sender: Any) {
        print("guide cliked")
        //가이드 화면으로 가는 코드 필요
    }
    
 
}
