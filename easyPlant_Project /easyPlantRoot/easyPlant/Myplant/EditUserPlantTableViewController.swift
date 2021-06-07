//
//  EditUserPlantTableViewController.swift
//  easyPlant
//
//  Created by 현수빈 on 2021/05/23.
//

import UIKit
import FirebaseStorage


class EditUserPlantTableViewController: UITableViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var editPlant : UserPlant?
    var isChangePhoto : Bool = false
    var isEdit : Bool = true
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var registerationTextField: UITextField!
    @IBOutlet weak var speciesTextField: UITextField!
    
    @IBOutlet weak var recentlyWateringDayTextField: UITextField!
    
    @IBOutlet weak var wateringDayTextField: UITextField!
    
    
    //사진 변경 버튼을 눌렀을 경우 실행
    @IBAction func ChangeImageButtonTapped(_ sender: Any) {
        
        isChangePhoto = true
        
        let alertController = UIAlertController(title: "Change plant's image", message: nil, preferredStyle: .actionSheet)//action sheet 이름을 choose imageSource로 스타일은 actionsheet
        
        
        
        //다음 세개를 action sheet에 추가할 것
        //cancel로 정하면 맨 밑에 생기고 default면 그냥 위에 생김
        
        //취소버튼 만들기
        let cancelAction = UIAlertAction(title: "Cancel",style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        //이미지 피커 생성
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self

        
        //사용자가 카메라 버튼을 누른 경우
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction = UIAlertAction(title: "Camera",style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker,animated: true,completion: nil)//보여주고 나서 추가작언 없으니까 nil
            })
            alertController.addAction(cameraAction)
        }
        
        //사용자가 사진앨범 버튼을 누른 경우
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
        let photoLibraryAction = UIAlertAction(title: "PhotoLibrary", style: .default, handler: { action in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker,animated: true,completion: nil)
            })

            alertController.addAction(photoLibraryAction)
        }

       
        //팝오버로 보여준다
        alertController.popoverPresentationController?.sourceView = sender as! UIButton
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    //컬렉션뷰 셀 하나당의 크기를 결정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        let width  = (view.frame.width-10)/2
    
        return CGSize(width: width, height: width)
        }
    
    
    //처음 뷰가 로드 됐을 때 실행
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //수정하기 화면을 경우
        if isEdit == true {
            if let usrplant = editPlant {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
         
            
                //해당 식물의 이미지를 가져오기
                imageView.image = UIImage(named : usrplant.plantImage)
                
                //해당 식물의 정보를 불러오기
                nameTextField.text = usrplant.name
                locationTextField.text = usrplant.location
                speciesTextField.text = usrplant.plantSpecies
                wateringDayTextField.text = String(usrplant.waterPeriod)
                registerationTextField.text = usrplant.registedDate
                recentlyWateringDayTextField.text = usrplant.recentWater

            }
            saveBarButton.isEnabled = true
        }
        
        //새로 만들기 화면일 경우
        else{
            saveBarButton.isEnabled = false
        }
        
        
        //이미지 뷰의 바운더리 설정
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.layer.frame.width / 2
        

    }

    
    
    //저장 버튼을 눌렀을 경우
    @IBAction func saveButtonTapped(_ sender: Any) {
      
        //수정하기 였다면
        if(isEdit == true){
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == editPlant?.name){
                    //식물의 정보를 수정한다
                    editPlant = userPlants[i]
                    editPlant?.name = nameTextField.text!
                    editPlant?.location = locationTextField.text!
                    editPlant?.plantSpecies = speciesTextField.text!
                    editPlant?.recentWater = recentlyWateringDayTextField.text!
                    editPlant?.waterPeriod = Int(wateringDayTextField.text!) ?? 0
                    editPlant?.registedDate = registerationTextField.text!

                    //사진이 변경되었다면 그 이미지로 설정
                    if(isChangePhoto == true){
                        editPlant?.plantImage = imageView.image!.debugDescription
                    }
                    //아니라면 그 이미지 그대로
                    else{
                        editPlant?.plantImage = userPlants[i].plantImage
                    }
                    

                    //데이트 포멧 설정
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                    let date:Date = dateFormatter.date(from:  recentlyWateringDayTextField.text!)!
                    let day : Int = Int(editPlant!.waterPeriod)

                    editPlant?.wateringDay = Calendar.current.date(byAdding: .day, value: day, to: date)!
                    
                    if Calendar.current.compare(editPlant!.wateringDay, to: Date(), toGranularity: .day) == .orderedAscending {
                        editPlant?.wateringDay = Date()
                    }
                    

                    userPlants[i] = editPlant! // 변경된 사항들을 전부 적용시켜준다
     
                    //let imageData : Data = (imageView.image?.pngData())!
                   // let imagename = imageView.image?.description
     
                
                }
            }
            
            //수정하고 저장하기
            saveUserInfo(user: myUser)
            saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
            self.performSegue(withIdentifier: "edituesrPlant", sender: self)
        }
        else{
            //만들어진 정보를 임시 식물구조체에 저장
            editPlant?.name = nameTextField.text!
            editPlant?.location = locationTextField.text!
            editPlant?.plantSpecies = speciesTextField.text!
            editPlant?.waterPeriod = Int(wateringDayTextField.text!) ?? 0
            editPlant?.registedDate = registerationTextField.text!
            editPlant?.recentWater = recentlyWateringDayTextField.text!
            
            //기본값으로 알람과 색상을 설정
            editPlant?.alarmTime = Date()
            editPlant?.color = Color(uiColor: UIColor(red: 150/255, green: 220/255, blue: 200/255, alpha: 1))
            
//            editPlant?.plantImage = imageView.image!.debugDescription
          
            //데이터 포멧
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                let date:Date = dateFormatter.date(from:  recentlyWateringDayTextField.text!)!
            let day : Int = Int(editPlant!.waterPeriod)
            
            //물주기 계산
            editPlant?.wateringDay = Calendar.current.date(byAdding: .day, value: day, to: date)!
            if Calendar.current.compare(editPlant!.wateringDay, to: Date(), toGranularity: .day) == .orderedAscending {
                editPlant?.wateringDay = Date()
            }
            
            
            
            
            //새로 만들어진 식물을 배열에 저장
            userPlants.append(editPlant!)
            
            //수정하고 저장하기
            saveUserInfo(user: myUser)
            saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
           
            
            performSegue(withIdentifier: "makeNewPlant", sender: self)
        }
        
    
        
    }

    
    //모든 내용이 다 채워져야 저장하기 버튼을 활성화 한다
    @IBAction func checkTextComplete(_ sender: UITextField) {
        
        if(isEdit == false){
            if nameTextField.text! != "", speciesTextField.text != "", registerationTextField.text != "", recentlyWateringDayTextField.text != "", wateringDayTextField.text != "", locationTextField.text != ""{
                saveBarButton.isEnabled = true
            }
        }
    }
    
    //이미지 피커 컨트롤러
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        //이미지를 선택했으면 imageView에 보여주는 함수
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        imageView.image = selectedImage
        //uploadimage(img: selectedImage)
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let detailVC = segue.destination as? NotificationViewController{
                detailVC.myPlant = editPlant
            }
        }
    
    
    

    
}
