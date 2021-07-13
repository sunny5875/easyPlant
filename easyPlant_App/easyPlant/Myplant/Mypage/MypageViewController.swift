//
//  MypageViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/07/12.
//

import UIKit
import FirebaseStorage
import Photos
import FirebaseAuth

class MypageViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet var infoLabels: [UILabel]!
    
    @IBOutlet weak var myInfo: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var guide: UIView!
    @IBOutlet weak var camerabut: UIButton!
    
    @IBOutlet weak var cameraBackground: UIImageView!
    @IBOutlet weak var guideImage: UIButton!
    @IBOutlet weak var guideButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        var addButton: UIBarButtonItem = UIBarButtonItem(title: "로그아웃", style: .done, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addButton
         
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillLayoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        
        
        
    }
    
    func updateUI(){
        myInfo.layer.zPosition = 100
        guide.layer.zPosition = 100
        guideButton.layer.zPosition = 102
        guideImage.layer.zPosition = 101
        camerabut.layer.zPosition = 100

        
        myInfo.layer.cornerRadius = 30
        guide.layer.cornerRadius = 30
        guideButton.layer.cornerRadius = 30
        cameraBackground.layer.cornerRadius =
            cameraBackground.layer.frame.width/2
        cameraBackground.backgroundColor = .white
      
        myInfo.layer.shadowOpacity = 0.2
        myInfo.layer.shadowOffset = CGSize(width: 0, height: 10)
        myInfo.layer.shadowRadius = 30
        myInfo.layer.masksToBounds = false
        
        guide.layer.shadowOpacity = 0.2
        guide.layer.shadowOffset = CGSize(width: 0, height: 10)
        guide.layer.shadowRadius = 30
        guide.layer.masksToBounds = false
        
        
        infoLabels[0].text = String(myUser.numPlants)
        infoLabels[1].text = String(myUser.hapiness)
        infoLabels[2].text = String(myUser.growingDays)

        let image = UIImage(named: "profileDefault2")
        profileImage.image = image
        //만약 로그인된 상태고 전에 한번 수정한적 있다면
        if myUser.isChangeProfile == 1
        {
            downloadProfileImage(imgview: profileImage)
        }
        
        
    }
  
    //사진 변경 버튼을 눌렀을 경우 실행
    @IBAction func cameraClicked(_ sender: Any) {
     
        let alertController = UIAlertController(title: "Change profile", message: nil, preferredStyle: .actionSheet)//action sheet 이름을 choose imageSource로 스타일은 actionsheet
        
        requestCameraPermission()
        requestGalleryPermission()

        
        //다음 세개를 action sheet에 추가할 것
        //cancel로 정하면 맨 밑에 생기고 default면 그냥 위에 생김
        let cancelAction = UIAlertAction(title: "Cancel",style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self

        //카메라로 추가하기
        if UIImagePickerController.isSourceTypeAvailable(.camera) {

            let cameraAction = UIAlertAction(title: "Camera",style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker,animated: true,completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        
        //사진 앨범으로 추가하기
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            
            switch photoAuthorizationStatus {
            case .authorized: print("접근 허가")
                let photoLibraryAction = UIAlertAction(title: "사진 선택하기", style: .default, handler: { action in
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker,animated: true,completion: nil)
                    })
                    alertController.addAction(photoLibraryAction)
                
                //팝오버로 보여준다
                
                alertController.popoverPresentationController?.sourceView = sender as! UIButton
                present(alertController, animated: true, completion: nil)
 
            case .denied: print("접근 거부")
                setAuthAlertAction()
            case .notDetermined: requestGalleryPermission()
            default: break
            }
            
        }
   
        
 
    }
    

    
    //이미지 피커 컨트롤러
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        //이미지를 선택했으면 imageView에 보여주는 함수
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        profileImage.image = selectedImage
        if let img = profileImage.image{
            deleteProfileImage()
            uploadProfileImage(img: img)
            myUser.isChangeProfile = 1
            print("profile image save -0")
        }
        dismiss(animated: true, completion: nil)
    }

    func setAuthAlertAction() {
        let authAlertController: UIAlertController
        authAlertController = UIAlertController(title: "갤러리 권한 요청", message: "갤러리 권한을 허용해야 앱을 정상적으로 이용할 수 있습니다.", preferredStyle: UIAlertController.Style.alert)
        let getAuthAction: UIAlertAction
        getAuthAction = UIAlertAction(title: "권한 허용", style: UIAlertAction.Style.default, handler: {_ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
            
        })
        
        authAlertController.addAction(getAuthAction)
        self.present(authAlertController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
 
    
    
    //가이드 함수
    
    @IBAction func guidebut(_ sender: Any) {
        print("guide cliked")
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "OnboardingViewController")
        
        present(secondVC, animated: true, completion: nil)
    }
    
    //로그아웃 함수
    @objc func addTapped(sender: AnyObject) {
        print("addbut tap")
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        // local에 데이터 다 지우기..
        
        
        loadUserPlant()
        loadUserInfo()
        self.navigationController?.popViewController(animated: true)
    }
    
}
