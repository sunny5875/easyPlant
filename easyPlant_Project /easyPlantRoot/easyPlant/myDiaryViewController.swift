//
//  myDiaryViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit

class myDiaryViewController: UIViewController {
    var myplant : userPlant?
    var diary : Diary?

    @IBOutlet weak var viewClear: UIView!
    @IBOutlet weak var imageLabel: UIImageView!
 
   
    @IBOutlet weak var contentVie: UIView!
    @IBOutlet weak var stackVIew: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var diaryLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if let diary = diary, let plant = myplant {
            imageLabel.image = UIImage(named: diary.picture)
            titleLabel.text = "  " + diary.title
            diaryLabel.text = "  " + diary.story
            myplant = plant
            dateLabel.text = "  " + diary.date
            
         
        }
        navigationController?.title = myplant?.name
        
        view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        
        diaryLabel.layer.cornerRadius = 20
        
        titleLabel.layer.cornerRadius = titleLabel.frame.height / 3
       
        
        contentVie.layer.cornerRadius = 30
        contentVie.layer.zPosition = 100
        imageLabel.layer.zPosition = 99
    
        
    }
    
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        guard let image = imageLabel.image else { return }
            let activityController = UIActivityViewController(activityItems: [image],applicationActivities: nil)
            
            //   아이패드에서만 실행되고 아이폰은 안나올 수도 있다
            activityController.popoverPresentationController?.sourceView = sender as! UIButton
            
            present(activityController, animated: true, completion: nil) //이게 handler, 코드조각을 선정할 수 있다. 팝오버 기준이 버튼이 될 것이다
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "editDiarySegue"{
            if let detailVC = segue.destination as? WriteDiaryViewController{
                detailVC.editDiary = diary
                detailVC.userplant = myplant
                detailVC.isEdit = true
            }
        }
        
        
    }
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Manage", message: "Manage your plant", preferredStyle: .actionSheet)
            
//            alert.addAction(UIAlertAction(title: "Approve", style: .default , handler:{ (UIAlertAction)in
//                print("User click Approve button")
//            }))
            
            alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction) in
                self.performSegue(withIdentifier: "editDiarySegue", sender: myPlantViewController.self)
            }))

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
                for i in 0...(self.myplant?.diarylist.count)!-1 {
                    if(self.diary?.date == self.myplant?.diarylist[i].date){
                        self.myplant?.diarylist.remove(at: i)
                    }
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            
            //uncomment for iPad Support
            //alert.popoverPresentationController?.sourceView = self.view

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    
    }
        
    
    
}
