//
//  PlantDetailViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit

class PlantDetailViewController: UIViewController {

    @IBOutlet var subTitleLabels: [UILabel]!
    
    @IBOutlet var subContentText: [UITextView]!
    var detailPlantName: String?
    var detailPlantType: String?
    var index1 = 0
    var index2 = 0
    @IBOutlet weak var plantDetailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nameData = detailPlantName, let typeData = detailPlantType{
            
            plantDetailImage.image = UIImage(named: nameData)
            plantDetailImage.layer.cornerRadius = plantDetailImage.layer.frame.width/2
            plantDetailImage.layer.borderColor = UIColor.lightGray.cgColor
            plantDetailImage.layer.borderWidth = 0.5

            
            for (i,typeString) in plantType.type.enumerated(){
                if typeString == typeData {
                    index1 = i
                    break
                }
            }
         
            for (i,plant) in plantType.plantAll[index1].enumerated(){
                if plant.name == nameData {
                    index2 = i
                    break
                }
            }
            
     
            
            contentLoad(plantType.plantAll[index1][index2])
        }
        // Do any additional setup after loading the view.
    }
  
    
    func contentLoad(_ plant :Plant){
        for (index,label) in subTitleLabels.enumerated(){
            label.text = "원산지"
            subContentText[index].text = "테스트 텍스트"
            
        }
    }
        
        
    //let button = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle") , style: .plain, target: nil, action: nil)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
        
    }
    
    func searchData(_ name: String){
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
