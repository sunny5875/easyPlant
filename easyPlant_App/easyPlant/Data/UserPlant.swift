//
//  userPlant.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import Foundation
import UIKit
import FirebaseStorage
let storage = Storage.storage()
let storageRef =  Storage.storage().reference()



var clickedDay: Date = Date()

struct Color : Codable {
    
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0

    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
    
}

struct UserPlant : Codable {
    var name: String
    var location: String
    var recentWater : String
    var registedDate : String
    var waterPeriod : Int
    var wateringDay : Date
    var plantSpecies : String
    var diarylist : [Diary]
    var color : Color
    var happeniess : [Int]
    var alarmTime : Date
    var plantImage : String
    var watered : Int
    
    private enum CodingKeys : String, CodingKey{
        case name,location,recentWater,registedDate,waterPeriod, wateringDay,plantSpecies, diarylist,color,happeniess,alarmTime,plantImage,watered }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        location = try container.decode(String.self, forKey: .location)
        registedDate = try container.decode(String.self, forKey: .registedDate)
        waterPeriod = try container.decode(Int.self, forKey: .waterPeriod)
        wateringDay = try container.decode(Date.self, forKey: .wateringDay)
        plantSpecies = try container.decode(String.self, forKey: .plantSpecies)
        diarylist = try container.decode([Diary].self, forKey: .diarylist)
        color = try container.decode(Color.self, forKey: .color)
        happeniess = try container.decode([Int].self, forKey: .happeniess)
        alarmTime = try container.decode(Date.self, forKey: .alarmTime)
        plantImage = try container.decode(String.self, forKey: .plantImage)
        watered = try container.decode(Int.self, forKey: .watered)
        recentWater = try container.decode(String.self, forKey: .recentWater)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var valueContatiner = encoder.container(keyedBy: CodingKeys.self)
        
        try valueContatiner.encode(self.name,forKey: CodingKeys.name)
        try valueContatiner.encode(self.location,forKey: CodingKeys.location)
        try valueContatiner.encode(self.registedDate,forKey: CodingKeys.registedDate)
        try valueContatiner.encode(self.waterPeriod,forKey: CodingKeys.waterPeriod)
        try valueContatiner.encode(self.wateringDay,forKey: CodingKeys.wateringDay)
        try valueContatiner.encode(self.plantSpecies,forKey: CodingKeys.plantSpecies)
        try valueContatiner.encode(self.diarylist,forKey: CodingKeys.diarylist)
        try valueContatiner.encode(self.color,forKey: CodingKeys.color)
        try valueContatiner.encode(self.happeniess,forKey: CodingKeys.happeniess)
        try valueContatiner.encode(self.alarmTime,forKey: CodingKeys.alarmTime)
        try valueContatiner.encode(self.plantImage,forKey: CodingKeys.plantImage)
        try valueContatiner.encode(self.watered,forKey: CodingKeys.watered)
        try valueContatiner.encode(self.recentWater, forKey: CodingKeys.recentWater)
    
        
            
        
        
    }
    
    
    
    init() {
        name = ""
        location = ""
        registedDate = ""
        waterPeriod = 0
        wateringDay = Date()
        plantSpecies = ""
        diarylist = []
        color = Color(uiColor: UIColor())
        happeniess = []
        alarmTime = Date()
        plantImage = "plant"
        watered = Int()
        recentWater = ""
        
    }
    
    init(name : String, location : String, recentWater : String, registedDate : String, waterPeriod : Int, wateringDay : Date, plantSpecies : String, diarylist : [Diary], color : Color, happeniess : [Int], alarmTime : Date, plantImage : String, watered : Int) {
        self.name = name
        self.location = location
        self.registedDate = registedDate
        self.waterPeriod = waterPeriod
        self.wateringDay = wateringDay
        self.plantSpecies = plantSpecies
        self.diarylist = diarylist
        self.color = color
        self.happeniess = happeniess
        self.alarmTime = alarmTime
        self.plantImage = plantImage
        self.watered = watered
        self.recentWater = recentWater
    }
    
    
}
    
    
    
    
  
var listPlantsIndex: [Int] = []

var userPlants : [UserPlant] = [UserPlant(name: "Stuckyi", location: "샘플 위", recentWater : "2021-06-02", registedDate: "2010-10-30",  waterPeriod: 5, wateringDay: Date(), plantSpecies: "샘플", diarylist: diarys, color: Color(uiColor: UIColor(red: 200/255, green: 200/255, blue: 1/255, alpha: 1)), happeniess: [86,65,67,98,87,68,76,77,89,76], alarmTime: Date(timeIntervalSinceNow: 66) ,plantImage: "Stuckyi", watered: 0),
                                UserPlant(name: "Hoya", location: "샘플", recentWater : "2021-06-04", registedDate: "2010-10-30", waterPeriod: 3, wateringDay: Date(), plantSpecies: "샘플",  diarylist: diarys, color: Color(uiColor: UIColor(red: 70/255, green: 100/255, blue: 180/255, alpha: 1)), happeniess: [86,65,57,76], alarmTime: Date(timeIntervalSinceNow: 66) ,plantImage: "Hoya", watered: 0),
                                UserPlant(name: "Syngonium", location: "샘플", recentWater : "2021-06-06",registedDate: "2010-10-30", waterPeriod: 1, wateringDay: Date(), plantSpecies: "샘플", diarylist: diarys, color: Color(uiColor: UIColor(red: 20/255, green: 180/255, blue: 30/255, alpha: 1)), happeniess:  [86,65,67,98,87,64,76,77,89,76], alarmTime: Date(timeIntervalSinceNow: 15), plantImage: "Syngonium", watered: 0),
                                UserPlant(name: "ParlourPalm", location: "샘플", recentWater : "2021-06-05",registedDate: "2010-10-30", waterPeriod: 2, wateringDay: Date(), plantSpecies: "샘플", diarylist: diarys, color: Color(uiColor: UIColor(red: 150/255, green: 220/255, blue: 200/255, alpha: 1)), happeniess:  [86,65,67,98,87,68,76,77,89,74], alarmTime: Date(timeIntervalSinceNow: 66) , plantImage: "ParlourPalm", watered: 0)]


func  saveNewUserPlant(plantsList : [UserPlant], archiveURL : URL) {

    print("save user plant")
    let jsonEncoder = JSONEncoder()

      do{
          let encodeData = try jsonEncoder.encode(plantsList)
          do{
              try encodeData.write(to: archiveURL, options: .noFileProtection)
               
          }
          catch let error as NSError {
              print(error)
          }
          
          
      }
      catch {
          print(error)
      }
    

    print("save user plant complete")
}


func loadUserPlant(){
    print("load user plant start")

    let jsonDecoder = JSONDecoder()
        
        do{
           
            
            let jsonData  = try Data(contentsOf: archiveURL, options: .mappedIfSafe)
            let decoded = try jsonDecoder.decode([UserPlant].self, from: jsonData)

           userPlants = decoded
            
            
            
        }
        catch {
            print("에러")
            print(error)
           
        }

    print("load user plant complete")

}




func downloadUserPlantImage(imgview:UIImageView, title : String){
    print("down load user plant image")
    print(title)
    /*
     Storage.storage().reference(forURL: "gs://easyplant-8649d.appspot.com/userPlant/\(title)").downloadURL { (url, error) in
            print("download error")
        let data = NSData(contentsOf: url!)
        let image = UIImage(data: data! as Data)
         imgview.image = image
         }
    
    
    */
    print("gs://easyplant-8649d.appspot.com/userPlant/\(title)")
    storage.reference(forURL: "gs://easyplant-8649d.appspot.com/userPlant/\(title)").downloadURL{ (url, error) in
            if let error = error{
             
                print("download error + \(error)")
            }else{
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                 imgview.image = image
        }
                        
           }
    //print(imgview.image!)
 }
 
 
func uploadUserPlantImage(img :UIImage, title: String){
    
     
     var data = Data()
     data = img.jpegData(compressionQuality: 0.8)!
     let filePath = "/userPlant/\(title)"
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

func deleteUserPlantImage(title : String){
    // Create a reference to the file to delete
    let desertRef = storageRef.child("\(title)")

    // Delete the file
    desertRef.delete { error in
      if let error = error {
            print("delete user plant error + \(error)")
      } else {
        print("delete user plant success")
      }
    }
}
 
