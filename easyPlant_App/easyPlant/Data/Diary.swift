//
//  Diary.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import Foundation
import FirebaseStorage


struct Diary : Codable {
    var title : String
    var date : String
    var story : String
    var picture : String
}    


var diarys : [Diary] = [Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "ParlourPalm"),
                        Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Moonshine"),
                        Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Monstrous"),
                        Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Violet"),
                        Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Hoya"),
                        Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Syngonium"),
                        Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "DwarfUmbrellaTree"),
                        Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Treean"),
                        Diary(title: "초록콩 데려온 날",date: "2020-10-31", story: "오늘은 초록콩이 온지 하루가 된날이다. 앞으로 건강하게 잘 키워보자!", picture: "Eucalyptus")]


func downloadDiaryImage(imgview:UIImageView, title : String){
    Storage.storage().reference(forURL: "gs://easyplant-8649d.appspot.com/diary/\(title)").downloadURL { (url, error) in
        print("download load diary image")
        print(title)
                       let data = NSData(contentsOf: url!)
                       let image = UIImage(data: data! as Data)
                        imgview.image = image
        }
   //print(imgview.image!)
}


func uploadDiaryImage(img :UIImage, title: String){
   
    
    var data = Data()
    data = img.jpegData(compressionQuality: 0.8)!
    let filePath = "/diary/\(title)"
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
    let desertRef = storageRef.child("/diary/\(title)")

    // Delete the file
    desertRef.delete { error in
      if let error = error {
            print("delete diary error + \(error)")
      } else {
        print("delete diary success")
      }
    }
}
