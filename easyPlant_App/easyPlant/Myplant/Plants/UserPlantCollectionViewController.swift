//
//  uerPlantsCollectionViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit
import FirebaseAuth

private let reuseIdentifier = "userPlantCell"

let documentsDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
let archiveURL = documentsDirectory.appendingPathComponent("savingUserPlants.json")


class UserPlantCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var userPlantCollectionView: UICollectionView!

    @IBOutlet weak var myProfile: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
   
   
        loadUserPlant()
        userPlantCollectionView.reloadData()
        print("user plant reload data finish")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear!!!! hihi")
        loadUserPlant()
        userPlantCollectionView.reloadData()

        var imagetmp : UIImageView = UIImageView()
        let image = UIImage(named: "profileDefault2")
        imagetmp.image = image
        //만약 로그인된 상태고 전에 한번 수정한적 있다면
        if Auth.auth().currentUser != nil && myUser.isChangeProfile == 1{
            downloadProfileImage(imgview: imagetmp)
        }
       
        
        myProfile.setImage(imagetmp.image, for: .normal)
        myProfile.layer.cornerRadius = myProfile.frame.size.width/2

    }

   
    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
       // #warning Incomplete implementation, return the number of sections

       return 1
   }


   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of items
    return userPlants.count
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserPlantCollectionViewCell

        let userplant = userPlants[indexPath.row]
        cell.update(info: userplant)
   

       return cell
   }
    


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        let width  = (userPlantCollectionView.frame.width-10)/2
        
    
        return CGSize(width: width, height: width*1.3)
        }

    


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? MyPlantViewController,let cell = sender as? UICollectionViewCell,
           let indexPath =  userPlantCollectionView.indexPath(for: cell) {
            detailVC.myPlant = userPlants[indexPath.item]
            print("user plant prepare1 finish")

        }
        
        
        if segue.identifier == "makeNewUserPlant"{
            if let detailVC = segue.destination as?  EditUserPlantTableViewController{
                detailVC.editPlant = UserPlant()
                detailVC.isEdit = false
                print("user plant prepare2 finish")

                
                
            }
        }
        
        if segue.identifier == "toMypage"{
            if let detailVC = segue.destination as?  MypageViewController{
                detailVC.navigationItem.title = myUser.userName + "님"
                detailVC.plantCollectionView = self
                print("to my page")
            }
            
        }
        
        if segue.identifier == "toLoginPage" {
            print("toLoginPage destination : \(segue.destination)")
            if let nav = segue.destination as? CustomNavigationController, let detailVC = nav.topViewController as? LoginViewController{
                detailVC.plantCollectionView = self
            }
        }
        


    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
        
   
    @IBAction func unwindToUserPlants(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        userPlantCollectionView.reloadData()
        
    }
    
    
    @IBAction func unwindToNewPlantsList(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        userPlantCollectionView.reloadData()
    }
    
    
    
    @IBAction func profileImageClicked(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            //만약 로그인이 안된 상태라면
            performSegue(withIdentifier: "toLoginPage", sender: nil)
        } else {
            //만약 로그인이 된 상태라면
            performSegue(withIdentifier: "toMypage", sender: nil)
        }
    }
    
    @IBAction func plusBtnClicked(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            //만약 로그인이 안된 상태라면
            performSegue(withIdentifier: "toLoginPage", sender: nil)
        } else {
            //만약 로그인이 된 상태라면
            performSegue(withIdentifier: "makeNewUserPlant", sender: nil)
        }
    }
    
}



