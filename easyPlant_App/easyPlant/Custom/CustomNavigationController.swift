//
//  CustomNavigationController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/05/16.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationBar.shadowImage = UIImage()
     
    }


}
