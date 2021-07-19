//
//  WriteDiaryViewController.swift
//  easyPlant
//
//  Created by 현수빈 on 2021/05/23.
//

import UIKit
import FirebaseStorage
import Firebase

//var storage : Storage = FirebaseStorage.Storage.storage()

class WriteDiaryViewController: UIViewController,UITextViewDelegate {
    
    var userplant: UserPlant?
    var editDiary : Diary?
    
    var isEdit: Bool = false
    var imageDate : String = ""
    var image : UIImage?
    var dateString:String = ""
    var diarytitle : String = ""
    var diarycontent : String = ""


    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var contentTextField: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    
    //저장가능한지 확인해주는 함수중 하나
    @IBAction func checkTextWrite(_ sender: UITextField) {
        
        if titleTextField.text != "", contentTextField.text != "", contentTextField.text != "내용을 입력하세요"{
            saveBarButton.isEnabled = true
                
        }
        else {
            saveBarButton.isEnabled = false
        }
        
    }
    
    
    //텍스트뷰의 placeholder 설정
    func placeholderSetting() {
        contentTextField.delegate = self // txtvReview가 유저가 선언한 outlet
        contentTextField.text = "내용을 입력하세요"
        contentTextField.textColor = UIColor.lightGray
            
    }
        
    //텍스트뷰가 수정을 시작할 때 저장가능한지 검사&UI 설정
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        if titleTextField.text != "", contentTextField.text != "" {
            saveBarButton.isEnabled = true
                
        }
        else {
            saveBarButton.isEnabled = false
        }
        
    }

    //텍스트 뷰가 수정을 마쳤을 때 저장 가능한지 검사& UI 설정
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력하세요"
            textView.textColor = UIColor.lightGray
        }
        
        if titleTextField.text != "", contentTextField.text != "" {
            saveBarButton.isEnabled = true
                
        }
        else {
            saveBarButton.isEnabled = false
        }
    }



    //저장 버튼이 눌렸을 때 불리는 함수
    @IBAction func saveButtonTapped(_ sender: Any) {
        //편집중이었다면
        if (isEdit == true){
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == userplant?.name){
                    for j in 0...userPlants[i].diarylist.count-1 {
                        if(userPlants[i].diarylist[j].picture == editDiary?.picture){
                            
                            if let image = imageView.image, let title = userplant?.name {
                                deleteDiaryImage(title: "\(title)-\((editDiary!.title))-\(editDiary!.date)")
                                editDiary?.title = titleTextField.text!
                                uploadDiaryImage(img: image, title: "\(title)-\(editDiary!.title)-\(editDiary!.date)")
                                
                                let tmpDate = editDiary!.date
                                let tmpTitle = editDiary!.title
                                editDiary?.picture =  "\(title)-\(tmpTitle)-\(tmpDate)"
                                
                            }
                         
                            editDiary?.story = contentTextField.text!
                            userPlants[i].diarylist[j] = editDiary!
                            
                            
                            //수정하고 저장하기
                            saveUserInfo(user: myUser)
                            saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                            performSegue(withIdentifier: "unwindToEditDiarySegue", sender: self)
                            return
                            
                        }
                    }
                    
                    
                }
            
            }
        }
        
        //새로 만들기 였다면
        else{
            
            diarytitle = titleTextField.text!
            diarycontent = contentTextField.text!
          
           
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == userplant?.name){
                //add
                    userPlants[i].diarylist.append(Diary(title: diarytitle, date: imageDate, story: diarycontent, picture: "\(userplant!.name)-\(diarytitle)-\(imageDate)"))
                    
                    if let image = imageView.image, let title = userplant?.name {
                        uploadDiaryImage(img: image, title: "\(title)-\(diarytitle)-\(imageDate)")
                    }
                    
                    //수정하고 저장하기
                    saveUserInfo(user: myUser)
                    saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                    performSegue(withIdentifier: "backToMyPlant", sender: self)
                
                
                }
            }
                
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToEditDiarySegue"{
            if let detailVC = segue.destination as? MyDiaryViewController{
                detailVC.myplant = userplant
                detailVC.diary = editDiary
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //텍스트뷰 클릭시 뷰를 키보드 만큼 들어올리기 위함
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       
        
        //이미지 설정
        if let image = image, let _ = userplant{
            imageView.image = image
   
        }
   

        saveBarButton.isEnabled = false
        
        let _:Date = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if editDiary != nil {
            titleTextField.text =  editDiary?.title
            contentTextField.text = editDiary?.story
            imageView.image = UIImage(named: editDiary!.picture)
        }
        
        if(isEdit == true){
            saveBarButton.isEnabled = true
            imageView.image = image

        }
        
        
        //각종 UI 설정
        contentView.layer.zPosition = 100
        imageView.layer.zPosition = 99
        stackView.layer.cornerRadius = 20
        contentView.layer.cornerRadius = 30
        
        contentTextField.layer.borderWidth = 1
        contentTextField.layer.borderColor = UIColor.systemGray5.cgColor
        contentTextField.layer.cornerRadius =  10
        contentTextField.delegate = self
        
        if contentTextField.text.isEmpty {
            contentTextField.text = "내용을 입력하세요"
            contentTextField.textColor = UIColor.lightGray
        }
        
        
    }
    
    //다른곳을 터지하면 키보드가 내려가게 하는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    //아래 두함수는 키보드에 따라 뷰를 올리고 내리는 함수들
    @objc func keyboardShow(notification: NSNotification, sender: Any?) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= (keyboardSize.height / 2 + 10)

            }
        }

    }

    @objc func keyboardHide(notification: NSNotification,sender: Any?) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += (keyboardSize.height / 2 + 10)

            }
        }
    }


}
