//
//  FindViewController.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/07/12.
//

import UIKit
import FirebaseAuth

class FindViewController: UIViewController {

    @IBOutlet weak var findBut: UIButton!
    @IBOutlet weak var IDField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        findBut.layer.cornerRadius = findBut.frame.height / 5
        // Do any additional setup after loading the view.
    }
    

    @IBAction func findBtnTapped(_ sender: Any) {
        if IDField.text! == "" {
            showAlert(title: "비밀번호 찾기에 실패하였습니다", message: "아이디를 입력해주세요")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: IDField.text!, completion: nil)
        showAlertAndBack(title: "비밀번호 재설정 메일이 발송되었습니다", message: "메일을 확인해주세요")
    }
    
    func showAlertAndBack(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)

            }))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
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
