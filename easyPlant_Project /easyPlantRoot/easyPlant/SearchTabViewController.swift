//
//  SearchTabViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit

class SearchTabViewController: UIViewController {

    
    @IBOutlet var menuButtons: [UIButton]!
    var titleSend: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUI()
        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

    
    func setUI(){
        for but in menuButtons{
            but.layer.borderWidth = 0.5
            but.layer.borderColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1)).cgColor
            
            but.layer.cornerRadius = 20
            but.layer.backgroundColor = UIColor.white.cgColor
            but.setTitle(but.currentTitle, for: .normal)
        
        }
        
    }

    @IBAction func searchMenuTab(_ sender: Any) {
        let butSelect:UIButton = sender as! UIButton
        titleSend = butSelect.title(for: .normal)
        performSegue(withIdentifier: "selectMenu", sender: nil)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let sortTable = segue.destination as? SortTableViewController {
                if segue.identifier == "selectMenu" {
                sortTable.navigationItem.title = titleSend
            }
        }
      
    }
   

}
