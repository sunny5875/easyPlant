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

class WriteDiaryViewController: UIViewController {
    
    var userplant: userPlant?
    var editDiary : Diary?
    
    var isEdit: Bool = false
    
    var image : UIImage?
    var dateString:String = ""
    var diarytitle : String = ""
    var diarycontent : String = ""


    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBAction func checkTextWrite(_ sender: UITextField) {
        
        sender.resignFirstResponder()
        if(isEdit == false){
            if titleTextField.text != "", contentTextField.text != "" {
                saveBarButton.isEnabled = true
            
                diarytitle = titleTextField.text!
                diarycontent = contentTextField.text!
           
            
                for i in 0...(userPlants.count-1) {
                    if(userPlants[i].name == userplant?.name){
                    //add
                        userPlants[i].diarylist.append(Diary(title: diarytitle, date: dateString, story: diarycontent, picture: image!.description))
                        
                        performSegue(withIdentifier: "backToMyPlant", sender: self)
                    
                    //uploadimage(img: imageView.image!)
                    }
                    
                }
            }
            
            
            
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        for i in 0...(userPlants.count-1) {
            if(userPlants[i].name == userplant?.name){
                for j in 0...userPlants[i].diarylist.count-1 {
                    if(userPlants[i].diarylist[j].date == editDiary?.date){
                        editDiary?.title = titleTextField.text!
                        editDiary?.story = contentTextField.text!
                        
                        userPlants[i].diarylist[j] = editDiary!
                   
                        performSegue(withIdentifier: "unwindToEditDiarySegue", sender: self)
                        return
                        
                    }
                }
    }
        
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
   
        
        if let image = image, let _ = userplant{
            imageView.image = image
            
            
        }
    
        
        saveBarButton.isEnabled = false
        
        let date:Date = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

       //dateString = dateFormatter.string(from: date)
        //dateLabel.text = dateString
        
       // uploadimage(img: image)
        
        if let editDairy = editDiary {
            titleTextField.text =  editDiary?.title
            contentTextField.text = editDiary?.story
            imageView.image = UIImage(named: editDiary!.picture)
        }

        // Do any additional setup after loading the view.
        
        if(isEdit == true){
            saveBarButton.isEnabled = true
        }
        
        
        contentView.layer.zPosition = 100
        imageView.layer.zPosition = 99
        
        stackView.layer.cornerRadius = 20
        
        contentView.layer.cornerRadius = 30
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func uploadimage(img :UIImage){
       
        let storageRef =  Storage.storage().reference()
        
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let filePath = "diaryImage"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.child(filePath).putData(data,metadata: nil){
            (metaData,error) in if let error = error{
            print(error.localizedDescription)
            return
                
        }
        else{
            print("성공")
        }
                  }
    }


}
