//
//  myDiaryViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit

class myDiaryViewController: UIViewController {
    var diary : Diary?

    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var diaryLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let diary = diary {
            imageLabel.image = UIImage(named: diary.picture)
            titleLabel.text = diary.title
            diaryLabel.text = diary.story
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
