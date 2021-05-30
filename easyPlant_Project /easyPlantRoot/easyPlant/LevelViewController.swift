//
//  LevelViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/05/27.
//

import UIKit

class LevelViewController: UIViewController {

    @IBOutlet weak var levelStack: UIStackView!
    @IBOutlet weak var myStack: UIStackView!
    @IBOutlet var levelLables: [UILabel]!
    
    @IBOutlet weak var myLevelView: UITextView!
    
    @IBOutlet var levelsView: [UITextView]!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()

        let attributedString = NSMutableAttributedString(string: "\n당신은 현재 \(myUser.level.name). \n\(myUser.level.description) 당신은 이때까지 \(myUser.growingDays)일 동안 식물을 돌보고 있으며, \(myUser.numPlants)개의 식물을 키우고 있습니다. 전체 식물의 평균 행복도는 \(myUser.hapiness)입니다.")

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, attributedString.length))

        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: NSMakeRange(0, attributedString.length))

        myLevelView.attributedText = attributedString
        myLevelView.layer.cornerRadius = 30
        print(myLevelView.text!)
        myStack.layer.cornerRadius = 30
        myStack.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))

        myLevelView.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))


        levelStack.layer.borderWidth = 1
        levelStack.layer.borderColor = UIColor.white.cgColor
        levelStack.layer.cornerRadius = 15
        levelStack.backgroundColor = UIColor.white
    
        for (i, level) in levelLables.enumerated() {
            print(i)
            print(levels[i].name)
            level.text = levels[i].name
        }
        //myLevel.backgroundColor = UIColor.blue
        for (i, level) in levelsView.enumerated() {
            if i == 0 {
                level.text = "식물을 등록하세요!"
            } else {
                level.text = "평균  행복도: \(levels[i].hapiness) 키운 식물수: \(levels[i].numPlants) 키운 기간: \(levels[i].growingDays)"
            }
            //level.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
            level.backgroundColor =  UIColor.white
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
