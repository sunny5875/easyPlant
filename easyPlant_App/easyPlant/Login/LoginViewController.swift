//
//  LoginViewController.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/07/10.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController ,UITextViewDelegate{
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var findBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    var plantCollectionView: UserPlantCollectionViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 15
        IDField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: IDField.frame.size.height-10, width: IDField.layer.frame.width, height: 1)
        //print(IDField.layer.frame.width)
        IDField.layer.addSublayer((border))
        border.backgroundColor = UIColor.lightGray.cgColor
        
        pwField.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: pwField.frame.size.height-10, width: pwField.frame.size.width, height: 1)
        border2.backgroundColor = UIColor.lightGray.cgColor
        pwField.layer.addSublayer((border2))
        
        if Auth.auth().currentUser != nil {
            IDField.placeholder = "이미 로그인 된 상태입니다."
            pwField.placeholder = "이미 로그인 된 상태입니다."
        }
        
        //findBtn.layer.borderColor = UIColor.systemGray4.cgColor
        //findBtn.layer.borderWidth = 1
        findBtn.layer.cornerRadius = 15
        
        //joinBtn.layer.borderColor = UIColor.systemGray4.cgColor
        //joinBtn.layer.borderWidth = 1
        joinBtn.layer.cornerRadius = 15

    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        if IDField.text! == "" {
            showAlert(message: "아이디를 입력해주세요")
            return
        }
        
        if pwField.text == "" {
            showAlert(message: "비밀번호를 입력해주세요")
            return
        }
        
        Auth.auth().signIn(withEmail: IDField.text!, password: pwField.text!) {
            (user, error) in
            if user != nil {
                if ((Auth.auth().currentUser?.isEmailVerified == true)) {
                    deleteLocalData()
                    
                    loadUserInfo()
                    loadUserPlant()
                    
                    if let view = self.plantCollectionView {
                        print("reload data!!!!!!@#!#@!$!$# \(userPlants)")
                        view.userPlantCollectionView.reloadData()
                    }
                    
                    print("로그인 성공 이름 : \(String(describing: Auth.auth().currentUser?.displayName))")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showAlert(message: "이메일 인증을 완료해주세요")
                    do {
                        try Auth.auth().signOut()
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                    return
                }
                
            } else {
                self.showAlert(message: "아이디와 비밀번호를 다시 입력해주세요")
                print("로그인 실패")
            }
        }
    }
    
    @IBAction func findBtnTapped(_ sender: Any) {
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "잘못된 로그인입니다.", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
