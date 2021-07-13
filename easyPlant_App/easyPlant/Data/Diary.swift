//
//  Diary.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import Foundation
import FirebaseStorage
import FirebaseAuth


struct Diary : Codable {
    var title : String
    var date : String
    var story : String
    var picture : String
}    


var diarys : [Diary] = [Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "ParlourPalm"),
                        Diary(title: "초록콩 데려온 날1",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Moonshine"),
                        Diary(title: "초록콩 데려온 날2",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Monstrous"),
                        Diary(title: "초록콩 데려온 날3",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Violet"),
                        Diary(title: "초록콩 데려온 날4",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Hoya"),
                        Diary(title: "초록콩 데려온 날5",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Syngonium"),
                        Diary(title: "초록콩 데려온 날6",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "DwarfUmbrellaTree"),
                        Diary(title: "초록콩 데려온 날7",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Treean"),
                        Diary(title: "초록콩 데려온 날8",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Eucalyptus")]


func downloadDiaryImage(imgview:UIImageView, title : String){
    print("download diary image")
    print(title)
    let urlString:String = documentsDirectory.absoluteString + "localDiary/\(title)"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let localURL = URL(string: encodedString)!
    
    //로컬에 없다면 원격 저장소에서 받아온다
    if let data = NSData(contentsOf: localURL){
        //로컬에 이미지가 존재할 경우 로컬 저장소에서 사용
        print("exist and download fast")
        let image = UIImage(data: data as Data)
        imgview.image = image
        
    }
    else {
        let localURL = documentsDirectory.appendingPathComponent("localDiary/\(title)")
        print("download to local diary start")
        // Create a reference to the file you want to download
        var filePath = ""
        if let user = Auth.auth().currentUser {
            filePath = "/\(user.uid)/diary/\(title)"
        } else {
            filePath = "/sampleUser/diary/\(title)"
        }
        let imgRef = storageRef.child(filePath)
        

        // print local filesystem URL
        print(localURL)

        // Download to the local filesystem
        imgRef.write(toFile: localURL) { url, error in
          if let error = error {
            print("download to local diary error : \(error)")
          } else {
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            imgview.image = image
          }
          
        }
    }
    
    /*
     원래코드
    Storage.storage().reference(forURL: "gs://easyplant-8649d.appspot.com/diary/\(title)").downloadURL { (url, error) in
        print("download load diary image")
        print(title)
                       let data = NSData(contentsOf: url!)
                       let image = UIImage(data: data! as Data)
                        imgview.image = image
        }
   */
}


func uploadDiaryImage(img :UIImage, title: String){
   
    
    var data = Data()
    data = img.jpegData(compressionQuality: 0.7)!
    var filePath = ""
    if let user = Auth.auth().currentUser {
        filePath = "/\(user.uid)/diary/\(title)"
    } else {
        filePath = "/sampleUser/diary/\(title)"
    }
    let metaData = StorageMetadata()
    metaData.contentType = "image/png"
    storageRef.child(filePath).putData(data,metadata: metaData){
            (metaData,error) in if let error = error{
            print(error.localizedDescription)
            return
                
        }
        else{
            print("성공")
        }
    }

}

func deleteDiaryImage(title : String){
    // Create a reference to the file to delete
    var desertRef = storageRef.child("")
    if let user = Auth.auth().currentUser {
        desertRef = storageRef.child("/\(user.uid)/diary/\(title)")
    } else {
        desertRef = storageRef.child("/sampleUser/diary/\(title)")
    }

    // Delete the file
    desertRef.delete { error in
      if let error = error {
            print("delete diary error + \(error)")
      } else {
        print("delete diary success")
      }
    }
    
    // 1. 인스턴스 생성 - 동일
    let fileManager = FileManager.default
    let urlString:String = documentsDirectory.absoluteString + "localDiary/\(title)"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let localURL = URL(string: encodedString)!
   
    // Try Catch
    do {
        // 5-1. 삭제하기
        try fileManager.removeItem(at: localURL)
    } catch let e {
        // 5-2. 에러처리
        print(e.localizedDescription)
    }
}
