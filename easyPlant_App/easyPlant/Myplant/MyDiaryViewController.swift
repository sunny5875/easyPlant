//
//  myDiaryViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit

class MyDiaryViewController: UIViewController {
    var myplant : UserPlant?
    var diary : Diary?
    var index : Int?

    @IBOutlet weak var viewClear: UIView!
    @IBOutlet weak var imageLabel: UIImageView!
 
   
    @IBOutlet weak var contentVie: UIView!
    @IBOutlet weak var stackVIew: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var diaryLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        
       
        
    }
    
    func updateUI(){
        
        if let diary = diary, let plant = myplant {
            //imageLabel.image = UIImage(named: diary.picture)
            downloadDiaryImage(imgview: imageLabel, title: diary.picture)
            titleLabel.text = "  " + diary.title
            diaryLabel.text = "  " + diary.story
            myplant = plant
            dateLabel.text = "  " + diary.date
            
         
        }
        self.navigationItem.title = myplant?.name
        
        view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        
        diaryLabel.layer.cornerRadius = 20
        
        titleLabel.layer.cornerRadius = titleLabel.frame.height / 3
       
        
        contentVie.layer.cornerRadius = 30
        contentVie.layer.zPosition = 100
        imageLabel.layer.zPosition = 99
    
    }
    
    
    //공유 버튼이 눌렸다면
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        guard let image = imageLabel.image else { return }
            let activityController = UIActivityViewController(activityItems: [image],applicationActivities: nil)
            
            //   아이패드에서만 실행되고 아이폰은 안나올 수도 있다
            activityController.popoverPresentationController?.sourceView = sender as! UIButton
            
            present(activityController, animated: true, completion: nil) //이게 handler, 코드조각을 선정할 수 있다. 팝오버 기준이 버튼이 될 것이다
    }
    

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "editDiarySegue"{
            if let detailVC = segue.destination as? WriteDiaryViewController{
                detailVC.editDiary = diary
                detailVC.userplant = myplant
                detailVC.isEdit = true
            }
        }
        
        
        if segue.identifier == "deleteDiary"{
            if let detailVC = segue.destination as? MyPlantViewController{
                detailVC.myPlant = myplant
                detailVC.isDeleteDiary = true
            }
        }
    }
    
    
    //다이어리 수정하기 버튼이 눌렸다면
    @IBAction func editButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Manage", message: "Manage your plant", preferredStyle: .actionSheet)
            
//            alert.addAction(UIAlertAction(title: "Approve", style: .default , handler:{ (UIAlertAction)in
//                print("User click Approve button")
//            }))
            
        
        //수정하기
            alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction) in
                
                //수정하고 저장하기
                saveUserInfo(user: myUser)
                saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                self.performSegue(withIdentifier: "editDiarySegue", sender: MyPlantViewController.self)
            }))

        //삭제하기
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
                if let picture = self.diary?.picture{
                    deleteDiaryImage(title: picture)
                    self.myplant?.diarylist.remove(at: self.index!)
                    
                    for i in 0...(userPlants.count-1) {
                        if(userPlants[i].name == self.myplant?.name){
                            print("delete diary success")
                            userPlants[i].diarylist.remove(at: self.index!)
                            break
                        }
                        
                    }
                }
            
        //수정하고 저장하기
                saveUserInfo(user: myUser)
                saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                self.performSegue(withIdentifier: "deleteDiary", sender: MyDiaryViewController.self)
                
            }))
            
        //해제하기 버튼
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            
            //uncomment for iPad Support
            //alert.popoverPresentationController?.sourceView = self.view

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    
    }
        
    
    
    @IBAction func unwindToEditDiary(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        print("unwindToEditDiary")
        updateUI()
    }
    
    

    
    
}
