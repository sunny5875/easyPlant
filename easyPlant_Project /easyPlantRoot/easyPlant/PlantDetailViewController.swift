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
            
            plantDetailImage.image = UIImage(named: nameData)
            plantDetailImage.layer.cornerRadius = 0
            plantDetailImage.layer.borderColor = UIColor.lightGray.cgColor
            plantDetailImage.layer.borderWidth = 0.5

            
            for (i,typeString) in plantType.type.enumerated(){
                if typeString == typeData {
                    index1 = i
                    break
                }
            }
         
            for (i,plant) in plantType.plantAll[index1].enumerated(){
                if plant.이름 == nameData {
                    index2 = i
                    break
                }
            }
            
     
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
                //subtext[index].text = plant.이름
                subtext[index].text = "테스트 설명 테스트 설명 테스트 설명"

                break
            case 1:
                //subtext[index].text = plant.원산지
                subtext[index].text = "테스트 설명 테스트 설명 테스트 설명"
                break
            case 2:
                //subtext[index].text = plant.과명
                subtext[index].text = "테스트 설명 테스트 설명 테스트 설명"
                break
            case 3:
                //subtext[index].text = plant.광요구도
                subtext[index].text = "테스트 설명 테스트 설명 테스트 설명"
                break
            case 4:
                //subtext[index].text = String(plant.생육온도)
                subtext[index].text = "테스트 설명 테스트 설명 테스트 설명"
                break
            case 5:
                //subtext[index].text = plant.물주기
                subtext[index].text = "테스트 설명 테스트 설명 테스트 설명"
                break
            case 6:
                //subtext[index].text = plant.특징
                subtext[index].text = "테스트 설명 테스트 설명 테스트 설명"
                break
            default:
                break
            }
            
        }
    }
        
        
    //let button = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle") , style: .plain, target: nil, action: nil)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode =  .never

        
        
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
