//
//  LevelViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/05/27.
//

import UIKit

class LevelViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var levelStack: UIStackView!
    @IBOutlet weak var myStack: UIStackView!
    @IBOutlet var levelLables: [UILabel]!
    @IBOutlet var levelImages: [UIImageView]!
    @IBOutlet weak var myLevelView: UITextView!
    @IBOutlet var levelsView: [UITextView]!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()

        myStack.layer.zPosition = 102
        levelStack.layer.zPosition = 101
        bgView.layer.zPosition = 100
        
        let string = "\(myUser.userName)님은 현재 \(myUser.level.name)입니다 \n\(myUser.level.description)"
        let attributedString = NSMutableAttributedString(string: string)

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 7 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: (string as NSString).range(of: string))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSMakeRange(0, attributedString.length))

       
        myLevelView.attributedText = attributedString
        myLevelView.layer.cornerRadius = 30
        
        myStack.layer.cornerRadius = 30
        myStack.layer.shadowOpacity = 0.2
        myStack.layer.shadowOffset = CGSize(width: 0, height: 10)
        myStack.layer.shadowRadius = 30
        myStack.layer.masksToBounds = false

        levelStack.layer.cornerRadius = 15
        levelStack.backgroundColor = UIColor.clear
    
        for (i, level) in levelLables.enumerated() {
            level.text = levels[i].name
        }
        for (i, level) in levelsView.enumerated() {
            if i == 0 {
                level.text = "식물을 등록하세요!"
            } else {
                level.text = "평균  행복도: \(levels[i].hapiness)%  키운 식물수: \(levels[i].numPlants)개  키운 기간: \(levels[i].growingDays)일"
            }
            level.backgroundColor =  UIColor.clear
        }
        
        for (i, level) in levelImages.enumerated() {
            level.image = UIImage(named: levels[i].icon)
        }
    }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
