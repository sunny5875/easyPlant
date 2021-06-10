//
//  myPlantViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit
import Charts
import FirebaseStorage
import Photos
private let reuseIdentifier = "diaryCell"


class MyPlantViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate, UICollectionViewDelegateFlowLayout {

    var myPlant : UserPlant?
    var numbers : [Int] = []
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    var ChartEntry : [ChartDataEntry] = []
    var selectedImage : UIImage?
    var isDeleteDiary : Bool = false
    var dateString: String = ""
   
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var diaryCollectionView: UICollectionView!
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var happeniessLabel: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var chartBackgroundView: UIView!
    
    @IBOutlet weak var labelStackView: UIStackView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("myplant will appear")
        self.navigationItem.title = myPlant?.name
        
        myPlantUpdate()
        updateUI()
      
        diaryCollectionView.reloadData()
       
    }
    
  
    
    func myPlantUpdate(){
        for plant in userPlants {
            if plant.name == myPlant?.name {
                myPlant = plant
            }
        }
    }
 
    //다이어리 생성 화면으로 이동
    @IBAction func plusButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "add new Diary", message: nil, preferredStyle: .actionSheet)//action sheet 이름을 choose imageSource로 스타일은 actionsheet
        
        requestCameraPermission()
        requestGalleryPermission()

        
        //다음 세개를 action sheet에 추가할 것
        //cancel로 정하면 맨 밑에 생기고 default면 그냥 위에 생김
        let cancelAction = UIAlertAction(title: "Cancel",style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self

        //카메라로 추가하기
        if UIImagePickerController.isSourceTypeAvailable(.camera) {

            let cameraAction = UIAlertAction(title: "Camera",style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker,animated: true,completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        
        //사진 앨범으로 추가하기
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
        let photoLibraryAction = UIAlertAction(title: "PhotoLibrary", style: .default, handler: { action in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker,animated: true,completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
       //팝오버 띄우기
        alertController.popoverPresentationController?.sourceView = sender as! UIButton
        
        present(alertController, animated: true, completion: nil)
        
        
        
    }
    
         func numberOfSections(in collectionView: UICollectionView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of items
            return (myPlant?.diarylist.count)!
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiaryCollectionViewCell
            if let userDiary = myPlant?.diarylist[indexPath.row]{
                cell.update(info: userDiary)
                    }
            return cell
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        
        if let detailVC = segue.destination as? MyDiaryViewController,let cell = sender as? UICollectionViewCell,
           let indexPath =  diaryCollectionView.indexPath(for: cell) {
            detailVC.diary = myPlant?.diarylist[indexPath.item]
            detailVC.myplant = myPlant
            detailVC.index = indexPath.item
        }
    
        
        if segue.identifier == "pickImageSegue"{
            if let detailVC = segue.destination as? WriteDiaryViewController{
                detailVC.image = selectedImage!
                detailVC.userplant = myPlant
                detailVC.isEdit = false
                detailVC.imageDate = dateString
                
            }
        }
        
        if segue.identifier == "editPlantSegue"{
            if let detailVC = segue.destination as? EditUserPlantTableViewController{
                
                detailVC.editPlant = myPlant
                
            }
        }
    }

    
    
    //이미지 피커 설정
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        //이미지를 선택했으면 imageView에 보여주는 함수
        guard let sImage = info[.originalImage] as? UIImage else { return }
        
        selectedImage = sImage
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString = formatter.string(from: Date())
        
        if let image = imageView.image, let title = myPlant?.name {
            uploadDiaryImage(img: image, title: "\(title)\(dateString)")
        }
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "pickImageSegue", sender: self)
    }
    
    //이 화면으로 돌아올 수있게 하는 길 만들어두기
    @IBAction func unwindToMyPlant(_ unwindSegue: UIStoryboardSegue) {
        print("unwind to my plant")
        //다이어리를 삭제했었던 경우
        if(isDeleteDiary == true){
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == myPlant!.name){
                    userPlants[i] = myPlant!
                }
            }
        }
        
        //이건 뭐지 - 식물 정보 수정하고 save하고 돌아온 경우인가
        else{
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == myPlant!.name){
                   myPlant = userPlants[i]
                }
            }
        }
        diaryCollectionView.reloadData()
      
    }
    
    
    @IBAction func unwindToSetting(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        if let sourceVC = sourceViewController as? EditUserPlantTableViewController {
            myPlant = sourceVC.editPlant
            updateUI()
        }
        // Use data from the view controller which initiated the unwind segue
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        //10으로하면 12 아이폰에서 다시 깨지길래 12로 바꿔뒀어
        let width  = (diaryCollectionView.frame.width-12)/3
    
        return CGSize(width: width, height: width)
        }

    
    
    func updateUI(){

        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        
       
        if let myPlant = myPlant {
          
            //등록일 위치 종류 데이터 불러오기
            dDayLabel.text = myPlant.registedDate
            locationLabel.text = myPlant.location
            speciesLabel.text = myPlant.plantSpecies
            
            //행복도 불러오기
            if(myPlant.happeniess.count != 0 ){
                happeniessLabel.text = "\(myPlant.happeniess[myPlant.happeniess.count-1])"
            }
            else{
                happeniessLabel.text = "0"
            }
            
            //이미지 불러오기
            //imageView.image = UIImage(named: myPlant.plantImage)
            print(myPlant.name)
            downloadUserPlantImage(imgview: imageView, title: myPlant.name)
            imageView.layer.cornerRadius = imageView.frame.width / 2.0
            imageView.layer.masksToBounds = true
            
            numbers = myPlant.happeniess
            //chartBackgroundView.layer.cornerRadius = 50
            
            //테두리 밖은 잘려서 표시됨
            dDayLabel?.layer.masksToBounds = true
            locationLabel?.layer.masksToBounds = true
            speciesLabel?.layer.masksToBounds = true
            happeniessLabel?.layer.masksToBounds = true
            
        }

                
        // chart data array 에 데이터 추가
        for i in 0..<months.count {
            let value : ChartDataEntry
            if(numbers.count > i){
                value = ChartDataEntry(x: Double(i), y: Double(numbers[i]))
            }
            else{
                value = ChartDataEntry(x: Double(i), y: 0.0)
            }
            ChartEntry.append(value)
        }
        
        
        //차트 설정
        let chartDataset = LineChartDataSet(entries: ChartEntry, label: "올해의 행복도 변화")
               let chartData = LineChartData(dataSet: chartDataset)
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.drawBordersEnabled = false
        chartView.xAxis.enabled = false
        
        
        
        var circleColors: [NSUIColor] = []           // arrays with circle color definitions
        let color = UIColor(red: CGFloat(174.0/255), green: CGFloat(213.0/255), blue: CGFloat(129.0/255), alpha: 1)
        circleColors.append(color)
        

        // set colors and enable value drawing
        chartDataset.colors = circleColors
        chartDataset.circleHoleColor = color
        chartDataset.circleColors = circleColors
        chartDataset.drawValuesEnabled = true
        

        chartView.data = chartData
        //chartView.layer.cornerRadius = 20
        chartView.layer.masksToBounds = true

        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        loadUserPlant()

    }
    
    
 
   //식물 정보 수정버튼이 눌리게 되면
    @IBAction func editButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Manage", message: "Manage your plant", preferredStyle: .actionSheet)
            
//            alert.addAction(UIAlertAction(title: "Approve", style: .default , handler:{ (UIAlertAction)in
//                print("User click Approve button")
//            }))
            
        
        //수정하기 버튼
            alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction) in
                self.performSegue(withIdentifier: "editPlantSegue", sender: MyPlantViewController.self)
            }))

        //삭제하기 버튼
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ [self] (UIAlertAction)in
                //해당 식물 삭제하기
                for i in 0...(userPlants.count-1) {
                    if(userPlants[i].name == self.myPlant!.name){
                        print("deleteplant success")
                        userPlants.remove(at: i)
                        deleteUserPlantImage(title: "\(self.myPlant!.name)")
                        break
                    }
                    
                }
                
                
                //삭제하고 저장하기
                saveUserInfo(user: myUser)
                saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                self.performSegue(withIdentifier: "unwindToUserPlants", sender: MyPlantViewController.self)
            }))
            
        
        //해제 버튼
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
