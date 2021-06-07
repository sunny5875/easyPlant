//
//  EditUserPlantTableViewController.swift
//  easyPlant
//
//  Created by 현수빈 on 2021/05/23.
//

import UIKit




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
                _ = formatter.string(from: usrplant.wateringDay)
            
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
      
        if(isEdit == true){
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == editPlant?.name){
                    editPlant = userPlants[i]
                    
                    editPlant?.name = nameTextField.text!
                    editPlant?.location = locationTextField.text!
                    editPlant?.plantSpecies = speciesTextField.text!
                    editPlant?.recentWater = recentlyWateringDayTextField.text!
                    print("recent watering")
                    print(recentlyWateringDayTextField.text!)
                    editPlant?.waterPeriod = Int(wateringDayTextField.text!) ?? 0
                    if(isChangePhoto == true){
                        editPlant?.plantImage = imageView.image!.debugDescription
                    }
                    else{
                        editPlant?.plantImage = userPlants[i].plantImage
                    }
                    
//                    editPlant?.recentlyWateringDay = recentlyWateringDayTextField.text!
                    let dateFormatter = DateFormatter()

                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

                    let date:Date = dateFormatter.date(from:  recentlyWateringDayTextField.text!)!
                    let day : Int = Int(editPlant!.waterPeriod)

                    
                    print(editPlant!.waterPeriod)
                    editPlant?.wateringDay = Calendar.current.date(byAdding: .day, value: day, to: date)!
                    print("new plant wateringDay")
                    print(editPlant!.wateringDay)
                    editPlant?.registedDate = registerationTextField.text!
                 
                    userPlants[i] = editPlant!
                    
                
                    
                    //uploadimage(img: imageView.image!)
                   
                }
            }
            saveUserInfo(user: myUser)
            saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
            self.performSegue(withIdentifier: "edituesrPlant", sender: self)
        }
        else{
            editPlant?.name = nameTextField.text!
            editPlant?.location = locationTextField.text!
            editPlant?.plantSpecies = speciesTextField.text!
            editPlant?.waterPeriod = Int(wateringDayTextField.text!) ?? 0
            editPlant?.registedDate = registerationTextField.text!
            editPlant?.recentWater = recentlyWateringDayTextField.text!

//            editPlant?.plantImage = imageView.image!.debugDescription
          
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            print("recent watering")
            print(recentlyWateringDayTextField.text!)
            
            let date:Date = dateFormatter.date(from:  recentlyWateringDayTextField.text!)!
            
            let day : Int = Int(editPlant!.waterPeriod)
            
            editPlant?.wateringDay = Calendar.current.date(byAdding: .day, value: day, to: date)!
            print("new plant wateringDay")
            print(editPlant!.wateringDay)
            editPlant?.alarmTime = Date()
            editPlant?.color = Color(uiColor: UIColor.green)
            
            userPlants.append(editPlant!)
            
            
            saveUserInfo(user: myUser)
            saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
           
            
            performSegue(withIdentifier: "makeNewPlant", sender: self)
        }
        
    
        
    }

    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    @IBAction func checkTextComplete(_ sender: UITextField) {
        
        if(isEdit == false){
            if nameTextField.text! != "", speciesTextField.text != "", registerationTextField.text != "", recentlyWateringDayTextField.text != "", wateringDayTextField.text != "", locationTextField.text != ""{
                saveBarButton.isEnabled = true
                
            }
        }
        
        
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        //이미지를 선택했으면 imageView에 보여주는 함수
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        imageView.image = selectedImage
        uploadimage(img: selectedImage)
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let detailVC = segue.destination as? NotificationViewController{
                detailVC.myPlant = editPlant
            }
        }
    
}
