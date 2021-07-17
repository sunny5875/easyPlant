//
//  EditUserPlantTableViewController.swift
//  easyPlant
//
//  Created by 현수빈 on 2021/05/23.
//

import UIKit
import FirebaseStorage
import Photos


class EditUserPlantTableViewController: UITableViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var editPlant : UserPlant?
    var isChangePhoto : Bool = false
    var isEdit : Bool = true
    var speciesTmp : String?

    var isFromSearch : Bool?

    let monthPerDay: [Int] = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var formatLabels: [UILabel]!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var registerationTextField: UITextField!
    @IBOutlet weak var speciesTextField: UITextField!
    
    @IBOutlet weak var recentlyWateringDayTextField: UITextField!
    
    @IBOutlet weak var wateringDayTextField: UITextField!
    
    
    //사진 변경 버튼을 눌렀을 경우 실행
    @IBAction func ChangeImageButtonTapped(_ sender: Any) {
        
        isChangePhoto = true
        
        let alertController = UIAlertController(title: "사진 변경하기", message: nil, preferredStyle: .actionSheet)//action sheet 이름을 choose imageSource로 스타일은 actionsheet
        
        requestCameraPermission()
        requestGalleryPermission()

        
        //다음 세개를 action sheet에 추가할 것
        //cancel로 정하면 맨 밑에 생기고 default면 그냥 위에 생김
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self

        //카메라로 추가하기
        if UIImagePickerController.isSourceTypeAvailable(.camera) {

            let cameraAction = UIAlertAction(title: "카메라 선택하기",style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker,animated: true,completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        
        //사진 앨범으로 추가하기
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            
            switch photoAuthorizationStatus {
            case .authorized: print("접근 허가")
                let photoLibraryAction = UIAlertAction(title: "사진 선택하기", style: .default, handler: { action in
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker,animated: true,completion: nil)
                    })
                    alertController.addAction(photoLibraryAction)
                
                //팝오버로 보여준다
                
                alertController.popoverPresentationController?.sourceView = sender as! UIButton
                present(alertController, animated: true, completion: nil)
 
            case .denied: print("접근 거부")
                setAuthAlertAction()
            case .notDetermined: requestGalleryPermission()
            default: break
            }
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }

    
    func setAuthAlertAction() {
        let authAlertController: UIAlertController
        authAlertController = UIAlertController(title: "갤러리 권한 요청", message: "갤러리 권한을 허용해야 앱을 정상적으로 이용할 수 있습니다.", preferredStyle: UIAlertController.Style.alert)
        let getAuthAction: UIAlertAction
        getAuthAction = UIAlertAction(title: "권한 허용", style: UIAlertAction.Style.default, handler: {_ in 
            if let appSettings = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
            
        })
        
        authAlertController.addAction(getAuthAction)
        self.present(authAlertController, animated: true, completion: nil)
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
                formatter.dateFormat = "yyyy-MM-dd"
         
            
                //해당 식물의 이미지를 가져오기
                //imageView.image = UIImage(named : usrplant.plantImage)
                downloadUserPlantImage(imgview: imageView!, title: "\(editPlant!.plantImage)")
                
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
            if let spe = speciesTmp{
                speciesTextField.text = spe
            }
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
                    //식물의 정보를 수정한다 & 입력 형식 검사
                    editPlant = userPlants[i]
                    editPlant?.location = locationTextField.text!
                    editPlant?.plantSpecies = speciesTextField.text!
                    editPlant?.recentWater = recentlyWateringDayTextField.text!
                    
                    editPlant?.waterPeriod = Int(wateringDayTextField.text!) ?? 0
                    
                    editPlant?.registedDate = registerationTextField.text!
                    
                    

                    //사진이 변경되었다면 그 이미지로 설정
                    if(isChangePhoto == true){
                        editPlant?.plantImage = imageView.image!.debugDescription
                        if let name = editPlant?.name , let img = imageView.image{
                            deleteUserPlantImage(title: name)
                            editPlant?.name = nameTextField.text!
                            uploadUserPlantImage(img: img, title: editPlant!.name)
                            print("image save -1")
                        }
                        editPlant?.plantImage = nameTextField.text!
                        print("image change")

                    }
                    //아니라면
                    else{
                        if let name = editPlant?.name , let img = imageView.image{
                            deleteUserPlantImage(title: name)
                            editPlant?.name = nameTextField.text!
                            uploadUserPlantImage(img: img, title: editPlant!.name)
                            print("image save -2")
                        }
                        editPlant?.plantImage = nameTextField.text!
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
            //만들어진 정보를 임시 식물구조체에 저장 & 입력 형식 검사
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
            
            if let name = editPlant?.name , let img = imageView.image{
                deleteUserPlantImage(title: name)
                uploadUserPlantImage(img: img, title: name)
                print("image save -2")
            }
            editPlant?.plantImage = nameTextField.text!

            //새로 만들어진 식물을 배열에 저장
            userPlants.append(editPlant!)
            
            //수정하고 저장하기
            myUser.updateUser()
            saveUserInfo(user: myUser)
            saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
           
          
            
            if let isfrom = isFromSearch, isfrom == true{
                performSegue(withIdentifier: "fromSearchMake", sender: nil)
                //self.navigationController?.popViewController(animated: false)
                

            }
            else{
                performSegue(withIdentifier: "makeNewPlant", sender: self)

            }
        }
        
    
        
    }

    
    //모든 내용이 다 채워져야 저장하기 버튼을 활성화 한다
    @IBAction func checkTextComplete(_ sender: UITextField) {
       print("complete check start")
        if checkTextFormat(sender)==1 && checkTextEmpty()==1  {
            saveBarButton.isEnabled = true
        }
        else {
            saveBarButton.isEnabled = false

        }
        
        //새로 만드는 중이었다면
        if isEdit == false{
            if imageView.image == nil {
                print("image null")
                saveBarButton.isEnabled = false

            }
        }
        
    }
    
    func checkTextEmpty() -> Int {
        if nameTextField.text! != "", speciesTextField.text != "",
               registerationTextField.text != "",
               recentlyWateringDayTextField.text != "",
               wateringDayTextField.text != "",
               locationTextField.text != ""{
            return 1
        }
        return 0
    }
    
    func checkTextFormat(_ sender: UITextField) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        
        //등록일 형식 검사
        var checking1 = 1
        var textSplit = registerationTextField.text?.split(separator: "-")
        print(textSplit)
        if textSplit==nil || textSplit!.count != 3{
            checking1 = 0
        }
        
        if checking1 == 1 {
            if let yearText = textSplit?[0],let yearInt = Int(yearText),let monthText = textSplit?[1],let monthInt = Int(monthText),let dayText = textSplit?[2],let dayInt = Int(dayText){
                if yearText.count != 4 || monthText.count != 2 || dayText.count != 2 {
                    checking1 = 0
                }
                else if yearInt<1900 {
                    checking1 = 0
                }
                else if monthInt<1 || monthInt>12 {
                    checking1 = 0
                }
                else if dayInt>monthPerDay[monthInt] || dayInt<1 {
                    checking1 = 0
                }
                else {
                    let dateRegister:Date = dateFormatter.date(from:  registerationTextField.text!)!
                    if dateRegister > Date() {
                        print("미래야그건")
                        checking1 = 0
                    }
                }
            }
            else {
                checking1 = 0
            }
        }
     
        
        if checking1 == 0 && sender == registerationTextField{
            formatLabels[0].textColor = .red
            if sender.text == "" {
                formatLabels[0].textColor = .white

            }
            
        }
        else if checking1 == 1 && sender == registerationTextField{
            formatLabels[0].textColor = .white

        }
       
       
        //최근 물준 날짜 형식 검사
        var checking2 = 1
        textSplit = recentlyWateringDayTextField.text?.split(separator: "-")
        print(textSplit)
        if textSplit==nil || textSplit!.count != 3{
            checking2 = 0
        }
        
        if checking2 == 1 {
            if let yearText = textSplit?[0],let yearInt = Int(yearText),let monthText = textSplit?[1],let monthInt = Int(monthText),let dayText = textSplit?[2],let dayInt = Int(dayText){
                if yearText.count != 4 || monthText.count != 2 || dayText.count != 2 {
                    checking2 = 0
                }
                else if yearInt<1900 {
                    checking2 = 0
                }
                else if monthInt<1 || monthInt>12 {
                    checking2 = 0
                }
                else if dayInt>31 || dayInt<1 {
                    checking2 = 0
                }
                else{
                    let dateRecent:Date = dateFormatter.date(from:  recentlyWateringDayTextField.text!)!
                    if dateRecent > Date() {
                        print("미래야그건")
                        checking2 = 0
                    }
                }
            }
            else {
                checking2 = 0
            }
        }
        
        if checking2 == 0 && sender == recentlyWateringDayTextField{
            formatLabels[1].textColor = .red
            if sender.text == "" {
                formatLabels[1].textColor = .white

            }
        }
        else if checking2 == 1 && sender == recentlyWateringDayTextField{
            formatLabels[1].textColor = .white

        }
      
            
        //물주기 형식 검사
        var checking3 = 1
        let perToInt = Int(wateringDayTextField.text!)
        print(perToInt)
        if perToInt == nil || perToInt! <= 0 {
            print("checking 3 = 0")
            checking3 = 0
        }

        if checking3 == 0 && sender == wateringDayTextField{
            formatLabels[2].textColor = .red
            if sender.text == "" {
                formatLabels[2].textColor = .white

            }
           
        }
        else if checking3 == 1 && sender == wateringDayTextField{
            formatLabels[2].textColor = .white

        }
     
        
        if checking1 == 1 && checking2 == 1 && checking3 == 1 {
            return 1
        }
        else {
            return 0
        }
    }
    
 
    
    //이미지 피커 컨트롤러
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        //이미지를 선택했으면 imageView에 보여주는 함수
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageView.image = selectedImage
        if let name = editPlant?.name , let img = imageView.image{
            deleteUserPlantImage(title: name)
            uploadUserPlantImage(img: img, title: name)
            print("image save -0")
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let detailVC = segue.destination as? NotificationViewController{
                detailVC.myPlant = editPlant
            }
        }
    
    
    

    
}
