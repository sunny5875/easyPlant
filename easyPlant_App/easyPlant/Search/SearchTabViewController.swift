//
//  SearchTabViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit

class SearchTabViewController: UIViewController {
    @IBOutlet var menuButtons: [UIButton]!
    @IBOutlet weak var totalSearch: UIButton!
    var titleSend: String?

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setUI()
        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
        
        //모든 식물 사진을 받아온다.
        downloadAllData()

    }

    
    
    //각 버튼들의 UI 설정
    func setUI(){
        for but in menuButtons{
            but.layer.borderWidth = 0.5
            but.layer.borderColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1)).cgColor
            
            but.layer.cornerRadius = 20
            but.layer.backgroundColor = UIColor.white.cgColor
            but.setTitle(but.currentTitle, for: .normal)
        
        }
        
        totalSearch.layer.cornerRadius = 20
        totalSearch.layer.backgroundColor = UIColor.white.cgColor
        totalSearch.setTitle(totalSearch.currentTitle, for: .normal)
        
    }

    //아래 두함수는 모두 매뉴를 눌렀을때 이동 함수
    @IBAction func searchMenuTab(_ sender: Any) {
        let butSelect:UIButton = sender as! UIButton
        titleSend = butSelect.title(for: .normal)
        performSegue(withIdentifier: "selectMenu", sender: nil)
        
    }
    
    @IBAction func selectTotalSearch(_ sender: Any) {
        let butSelect:UIButton = sender as! UIButton
        titleSend = butSelect.title(for: .normal)
    performSegue(withIdentifier: "selectTotalSearch", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let sortTable = segue.destination as? SortTableViewController {
            if segue.identifier == "selectMenu" {
                sortTable.navigationItem.title = titleSend
            }
            else if segue.identifier == "selectTotalSearch" {
                //print(titleSend)
                sortTable.navigationItem.title = titleSend
                //print(sortTable.navigationItem.title)

            }
        }
    }

}
