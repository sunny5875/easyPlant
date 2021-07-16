//
//  PlantDetailViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit
import FirebaseAuth

class PlantDetailViewController: UIViewController {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var subTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var superstackView: UIStackView!
    @IBOutlet weak var stackElement: UIStackView!
    
    var detailPlantName: String?
    var detailPlantType: String?
    var index1 = 0
    var index2 = 0
    @IBOutlet weak var plantDetailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1")
        if let nameData = detailPlantName, let typeData = detailPlantType{

            print("2")
            for (i,typeString) in plantType.type.enumerated(){
                if typeString == typeData {
                    index1 = i
                    break
                }
            }
            print("3")
            for (i,plant) in plantType.plantAll[index1].enumerated(){
                if plant.dic["cntntsSj"] == nameData {
                    index2 = i
                    break
                }
            }
            print("4")
            //plantDetailImage.image = UIImage(named: plantType.plantAll[index1][index2].engName)
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
        print("5")
        // Do any additional setup after loading the view.
    }
  
    
    func contentLoad(_ plant :Plant){
        print("content load")
        for key in plant.dic.keys {
            if plant.dic[key] != "" {
                print("content exist")
                var stackView   = UIStackView()
                stackView = stackElement
                /*
                stackView.axis  = NSLayoutConstraint.Axis.vertical
                stackView.distribution  = UIStackView.Distribution.equalSpacing
                stackView.alignment = UIStackView.Alignment.center
                stackView.spacing   = 0
                
                let newlabel = UILabel()
                let newtext = UITextView()
                
                newlabel.text = "test"
                newtext.text = "test view"
                
                
                stackView.addArrangedSubview(newlabel)
                stackView.addArrangedSubview(newtext)
                stackView.translatesAutoresizingMaskIntoConstraints = false
 */
                superstackView.addSubview(stackView)
                //print(superstackView)
            }
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode =  .never
        print("will appear")
        
        
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
 
    @IBAction func addPlantBtnTapped(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            showAlert()
            return
        }
        
        performSegue(withIdentifier: "toEditPlant", sender: self)
    }
    
    func showAlert() {
        print("show alear - detail view")
        let alert = UIAlertController(title: "로그인이 필요한 서비스입니다", message: "로그인 후 이용바랍니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
}
