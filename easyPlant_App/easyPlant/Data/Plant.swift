//
//  plant.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import Foundation
import UIKit

import FirebaseStorage
import FirebaseAuth

struct Plant: Codable {
    var dic : [String: String] = [:]
    mutating func initDic(){
        for key in plantKey.keys{
            self.dic.updateValue("", forKey: key)
        }
    }
}

var plantTotal: [Plant] = []
var plantsClearAir: [Plant] = []
var plantsShade: [Plant] = []
var plantsFast: [Plant] = []
var plantsLazy: [Plant] = []
var plantsInterior: [Plant] = []
var plantsFlower: [Plant] = []

struct PlantType:Codable{
    var type: [String]
    var plantAll: [[Plant]]
    
}
var plantType = PlantType(
    type : ["전체검색","공기정화","그늘에서","성장속도","귀차니즘","인테리어","꽃과열매"],
    plantAll : [plantTotal,plantsClearAir,plantsShade,plantsFast,plantsLazy,plantsInterior,plantsFlower]

)


let plantDataURL = documentsDirectory.appendingPathComponent("plantData.json")
func loadPlantData(){
    let jsonDecoder = JSONDecoder()
   

    //로컬에 없다면 원격 저장소에서 받아온다
    if let data = NSData(contentsOf: plantDataURL){
        //로컬에 정보가 존재할 경우 로컬 저장소에서 사용
        do {
            let decoded = try jsonDecoder.decode(PlantType.self, from: data as Data)
            plantType = decoded
        } catch {
            print(error)
        }
    }
    else {
        // Create a reference to the file you want to download
        var filePath = ""
       
        filePath = "/PlantData/plantData.json"
        
        let infoRef = storageRef.child(filePath)
        
        // Download to the local filesystem
        infoRef.write(toFile: plantDataURL) { url, error in
          if let error = error {
            print("download to local plant data error : \(error)")

          } else {
            let data = NSData(contentsOf: url!)
            do {
                let decoded = try jsonDecoder.decode(PlantType.self, from: data! as Data)
                plantType = decoded
            } catch {
                print(error)
            }
          }
        }
   }

}


func  savePlantData(plantData : PlantType) {
    
    let jsonEncoder = JSONEncoder()
    
    do{
        let encodeData = try jsonEncoder.encode(plantData)
        // 원격에 저장
        var filePath = ""
        
            filePath = "/PlantData/plantData.json"

            let metaData = StorageMetadata()
            metaData.contentType = "application/json"
            storageRef.child(filePath).putData(encodeData ,metadata: metaData){
                (metaData,error) in if let error = error{
                    print(error.localizedDescription)
                    return
                }
                else{
                    //print("성공")
                }
            }
            
            // 로컬에 저장
            try encodeData.write(to: plantDataURL, options: .noFileProtection)
        print(plantDataURL)
      }
      catch {
          print(error)
      }

}




func downloadPlantDataImage(imgview:UIImageView, title : String){
    //print(title)
    let urlString:String = documentsDirectory.absoluteString + "localData/\(title)"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let localURL = URL(string: encodedString)!
    
    
    //로컬에 없다면 원격 저장소에서 받아온다
    if let data = NSData(contentsOf: localURL){
        //로컬에 이미지가 존재할 경우 로컬 저장소에서 사용
        let image = UIImage(data: data as Data)
        imgview.image = image
        
    }
    else {
        let localURL = documentsDirectory.appendingPathComponent("localData/\(title)")
        // Create a reference to the file you want to download
        var filePath = ""
       
        filePath = "/PlantData/\(title)"
     
        
        let imgRef = storageRef.child(filePath)
    
        // Download to the local filesystem
        imgRef.write(toFile: localURL) { url, error in
          if let error = error {
            print("download to local error : \(error)")

          } else {
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            imgview.image = image
          }
          
        }

        
    }
    
    
   
    
 }

func downloadAllData(){
    //json 파일 만들고 덮어씌운 후 진행
    for plant in plantType.plantAll[0]{
        downloadPlantDataImage(imgview: UIImageView(), title: plant.dic["cntntsSj"]!)
    }
}


func uploadPlantDataImage(img : UIImage, title: String){
    
     
     var data = Data()
    data = img.jpegData(compressionQuality: 0.8)!
    var filePath = ""
    
    filePath = "/PlantData/\(title)"
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    storageRef.child(filePath).putData(data,metadata: metaData){
             (metaData,error) in if let error = error{
             print(error.localizedDescription)
             return
                 
         }
     }

 }
