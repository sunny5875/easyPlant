//
//  myPlantViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit
private let reuseIdentifier = "diaryCell"


class myPlantViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var myPlant : userPlant?
    
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var happeniessLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
  
         func numberOfSections(in collectionView: UICollectionView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of items
            return diarys.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
            // Configure the cell
        
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
  
        if segue.identifier == "diarySegue" {
//          if let cell = sender as? UICollectionViewCell,
//             let indexPath = self.collectionView.indexPath(for: cell){
//            let controller = segue.destination as! myDiaryViewController
//            controller.diary = diarys[indexPath.item]
//          }
        }
    
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let myPlant = myPlant {
            dDayLabel.text = "등록일 " + myPlant.registedDate
            locationLabel.text = "위치 : " + myPlant.location
            speciesLabel.text = "종류 : " + myPlant.plantSpecies
            happeniessLabel.text = "행복도 : \(myPlant.happeniess)"
            
            imageView.image = UIImage(named: myPlant.plantImage)
            
            imageView.layer.cornerRadius = imageView.frame.width / 2
            //imageView.clipsToBounds = true
            
        }
        
        
        
    }
    
    
   
   

}
