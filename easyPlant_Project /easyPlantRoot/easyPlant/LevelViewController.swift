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
    @IBOutlet weak var myLevel: UITextView!
    @IBOutlet var levels: [UITextView]!
    override func viewDidLoad() {
    
        super.viewDidLoad()

        myLevel.text = "당신은 현재 초보농부. \n\n새롭게 농부가 되신 당신! 당신은 이때까지 ~~~일 동안 식물을 돌보고 있으며, ~~~개의 식물을 키우고 있습니다. 전체 식물의 평균 행복도는 ~~~~입니다."
        print(myLevel.text!)
        myStack.layer.borderWidth = 1
        myStack.layer.borderWidth = 1
        myStack.layer.borderColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1)).cgColor
        myStack.layer.cornerRadius = 15
        myStack.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        myLevel.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))

        levelStack.layer.borderWidth = 1
        levelStack.layer.borderColor = UIColor.systemGray5.cgColor
        levelStack.layer.cornerRadius = 15
        levelStack.backgroundColor = UIColor.systemGray5
    
        //myLevel.backgroundColor = UIColor.blue
        for level in levels{
            level.text = "평균  행복도: 키운 식물수: 키운 기간: "
            level.backgroundColor =  UIColor.systemGray5
        }
        // Do any additional setup after loading the view.
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
