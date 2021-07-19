//
//  myDiaryViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit
import FirebaseAuth
class MyDiaryViewController: UIViewController {
    var myplant : UserPlant?
    var diary : Diary?
    var index : Int?

    @IBOutlet weak var viewClear: UIView!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var lineView: UIView!
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
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: stackVIew.frame.width, y: 0))

            // Create a `CAShapeLayer` that uses that `UIBezierPath`:
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.systemGray3.cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineWidth = 2

            lineView.layer.addSublayer(shapeLayer)
            
            downloadDiaryImage(imgview: imageLabel, title: diary.picture)
            titleLabel.text = "  " + diary.title
            
            let attributedString = NSMutableAttributedString(string: "  " + diary.story)

            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyle = NSMutableParagraphStyle()

            // *** set LineSpacing property in points ***
            paragraphStyle.alignment = .justified
            paragraphStyle.lineSpacing = 10 // Whatever line spacing you want in points
            
            
            // *** Apply attribute to string ***
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, attributedString.length))
            
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, attributedString.length))

            diaryLabel.attributedText =  attributedString
            myplant = plant
            dateLabel.text = "  " + diary.date
            
         
        }
        
        //기타 UI 설정
        self.navigationItem.title = myplant?.name
        diaryLabel.layer.cornerRadius = 20
        titleLabel.layer.cornerRadius = titleLabel.frame.height / 3
        contentVie.layer.cornerRadius = 30
        contentVie.layer.zPosition = 100
        imageLabel.layer.zPosition = 99
    
    }
    
    
    //공유 버튼이 눌렸다면
    @IBAction func shareButtonTapped(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            showAlert()
            return
        }
        
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
                detailVC.image = imageLabel.image
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
        if Auth.auth().currentUser == nil {
            showAlert()
            return
        }
        let alert = UIAlertController(title: "다이어리 관리", message: "", preferredStyle: .actionSheet)
        
        //수정하기
            alert.addAction(UIAlertAction(title: "다이어리 수정하기", style: .default , handler:{ (UIAlertAction) in
                
                //수정하고 저장하기
                saveUserInfo(user: myUser)
                saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                self.performSegue(withIdentifier: "editDiarySegue", sender: MyPlantViewController.self)
            }))

        //삭제하기
            alert.addAction(UIAlertAction(title: "다이어리 지우기", style: .destructive , handler:{ (UIAlertAction)in
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
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    
    }
        
    
    
    @IBAction func unwindToEditDiary(_ unwindSegue: UIStoryboardSegue) {
        updateUI()
    }
    
    

    func showAlert() {
        let alert = UIAlertController(title: "로그인이 필요한 서비스입니다", message: "로그인 후 이용바랍니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
    



}

