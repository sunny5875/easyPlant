//
//  uerPlantsCollectionViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit

private let reuseIdentifier = "userPlantCell"

let documentsDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
let archiveURL = documentsDirectory.appendingPathComponent("savingUserPlants.json")


class UserPlantCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var userPlantCollectionView: UICollectionView!

  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
   
        loadUserPlant()
        userPlantCollectionView.reloadData()
        print("user plant reload data finish")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userPlantCollectionView.reloadData()

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
    
    
    
    
    
}



