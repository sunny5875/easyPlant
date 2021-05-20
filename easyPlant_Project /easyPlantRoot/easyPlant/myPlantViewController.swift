//
//  myPlantViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit
import Charts
private let reuseIdentifier = "diaryCell"


class myPlantViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var myPlant : userPlant?
    var numbers : [Double] = []
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    var ChartEntry : [ChartDataEntry] = []
    
    
    @IBOutlet weak var diaryCollectionView: UICollectionView!
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var happeniessLabel: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var chartBackgroundView: UIView!
    
    @IBOutlet weak var labelStackView: UIStackView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "add new Diary", message: nil, preferredStyle: .actionSheet)//action sheet 이름을 choose imageSource로 스타일은 actionsheet
        
        
        
        //다음 세개를 action sheet에 추가할 것
        //cancel로 정하면 맨 밑에 생기고 default면 그냥 위에 생김
        let cancelAction = UIAlertAction(title: "Cancel",style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
//        let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//
//            let cameraAction = UIAlertAction(title: "Camera",style: .default, handler: { action in
//                imagePicker.sourceType = .camera
//                self.present(imagePicker,animated: true,completion: nil)//보여주고 나서 추가작언 없으니까 nil
//            })
//            alertController.addAction(cameraAction)
//        }
//
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//        let photoLibraryAction = UIAlertAction(title: "PhotoLibrary", style: .default, handler: { action in
//            imagePicker.sourceType = .photoLibrary
//            self.present(imagePicker,animated: true,completion: nil)
//            })
//            alertController.addAction(photoLibraryAction)
//        }
//
       
//        alertController.popoverPresentationController?.sourceView = sender as! UIButton
        
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
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! diaryCollectionViewCell
           
       
            
            if let userDiary = myPlant?.diarylist[indexPath.row]{
                cell.update(info: userDiary)
        
            }
            return cell
        }
  /*
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

                
        return CGSize(width: 130, height: 130)
            
    }
*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        
        if let detailVC = segue.destination as? myDiaryViewController,let cell = sender as? UICollectionViewCell,
           let indexPath =  diaryCollectionView.indexPath(for: cell) {
            detailVC.diary = myPlant?.diarylist[indexPath.item]
        }
    
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let myPlant = myPlant {
            dDayLabel.text = "등록일\n"+myPlant.registedDate
            locationLabel.text = "위치\n"+myPlant.location
            speciesLabel.text = "종류\n"+myPlant.plantSpecies
            happeniessLabel.text = "행복도\n\(myPlant.happeniess[myPlant.happeniess.count-1])"
            
            imageView.image = UIImage(named: myPlant.plantImage)
            
            imageView.layer.cornerRadius = imageView.frame.width / 2
            
            numbers = myPlant.happeniess
            
            chartBackgroundView.layer.cornerRadius = 50
            
            dDayLabel?.layer.masksToBounds = true
            locationLabel?.layer.masksToBounds = true
            speciesLabel?.layer.masksToBounds = true
            happeniessLabel?.layer.masksToBounds = true
            
            dDayLabel.layer.cornerRadius = 84.0 / 2
            locationLabel.layer.cornerRadius = 84.0 / 2
            speciesLabel.layer.cornerRadius = 84.0 / 2
            happeniessLabel.layer.cornerRadius = 84.0 / 2
            
            labelStackView.layer.cornerRadius = 20
            
            
            
        }

                
        // chart data array 에 데이터 추가
        for i in 0..<months.count {
            let value : ChartDataEntry
            if(numbers.count > i){
                 value = ChartDataEntry(x: Double(i), y: Double(numbers[i]))
            }
            else{
                value = ChartDataEntry(x: Double(i), y: Double(0.0))
            }
            ChartEntry.append(value)
        }
        
        let chartDataset = LineChartDataSet(entries: ChartEntry, label: "올해의 행복도 변화")
       
        
        let chartData = LineChartData(dataSet: chartDataset)
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.drawBordersEnabled = false
        chartView.xAxis.enabled = false
        
        
        var circleColors: [NSUIColor] = []           // arrays with circle color definitions

       
        let color = UIColor(red: CGFloat(189.0/255), green: CGFloat(236.0/255), blue: CGFloat(182.0/255), alpha: 1)
        circleColors.append(color)
        

        // set colors and enable value drawing
        chartDataset.colors = circleColors
        chartDataset.circleColors = circleColors
        chartDataset.drawValuesEnabled = true
        

        chartView.data = chartData
//
        
//        let animation = CABasicAnimation(keyPath: "path")
        
        
        
    }
    
    
   
   

}
