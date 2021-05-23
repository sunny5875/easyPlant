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
    
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        guard let image = imageLabel.image else { return }
            let activityController = UIActivityViewController(activityItems: [image],applicationActivities: nil)
            
            //   아이패드에서만 실행되고 아이폰은 안나올 수도 있다
            activityController.popoverPresentationController?.sourceView = sender as! UIButton
            
            present(activityController, animated: true, completion: nil) //이게 handler, 코드조각을 선정할 수 있다. 팝오버 기준이 버튼이 될 것이다
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
