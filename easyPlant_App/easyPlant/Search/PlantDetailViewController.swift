//
//  PlantDetailViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit

class PlantDetailViewController: UIViewController {

    @IBOutlet var subTitleLabels: [UILabel]!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var subtext: [UITextView]!
    var detailPlantName: String?
    var detailPlantType: String?
    var index1 = 0
    var index2 = 0
    @IBOutlet weak var plantDetailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nameData = detailPlantName, let typeData = detailPlantType{

            
            for (i,typeString) in plantType.type.enumerated(){
                if typeString == typeData {
                    index1 = i
                    break
                }
            }
         
            for (i,plant) in plantType.plantAll[index1].enumerated(){
                if plant.korName == nameData {
                    index2 = i
                    break
                }
            }
            
            plantDetailImage.image = UIImage(named: plantType.plantAll[index1][index2].engName)
            plantDetailImage.layer.cornerRadius = 0
            plantDetailImage.layer.borderColor = UIColor.lightGray.cgColor
            plantDetailImage.layer.borderWidth = 0.5
            
     
            contentView.layer.cornerRadius = 30
            contentView.layer.borderColor = UIColor.systemGray5.cgColor
            contentView.layer.borderWidth = 1
            contentView.layer.zPosition = 2
            plantDetailImage.layer.zPosition = 1
            contentLoad(plantType.plantAll[index1][index2])
        }
      
        // Do any additional setup after loading the view.
    }
  
    
    func contentLoad(_ plant :Plant){
        for index in 0...6{
            switch index{
            case 0:
                if plant.korName != ""{
                    subtext[index].text = plant.korName
                }

                break
            case 1:
                if plant.from != ""{
                    subtext[index].text = plant.from
                }
                break
            case 2:
                if plant.sciName != ""{
                    subtext[index].text = plant.sciName
                }
                break
            case 3:
                if plant.light != ""{
                    subtext[index].text = plant.light
                }
                break
            case 4:
                if plant.temp != ""{
                    subtext[index].text = plant.temp
                }
                break
            case 5:
                if plant.water != ""{
                    subtext[index].text = plant.water
                    
                }
                break
            case 6:
                if plant.chara != ""{
                    subtext[index].text = plant.chara
                }
                break
            default:
                break
            }
            
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode =  .never

        
        
    }
    
    func searchData(_ name: String){
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? EditUserPlantTableViewController {
            vc.editPlant = UserPlant()
            vc.speciesTmp = self.detailPlantName
            vc.isEdit = false
            vc.isFromSearch = true
       
        }
        
        
    }
 

}
