//
//  User.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/05/30.
//

import Foundation


let userInfoURL = documentsDirectory.appendingPathComponent("savingUserInfo.json")

struct User : Codable{
    var level: Level
    var growingDays: Int
    var numPlants: Int
    var totalWaterNum: Int
    var didWaterNum: Int
    
    var hapiness: Int //int형으로 바꿨어
    let registeredDate: Date
    
    private enum CodingKeys : String, CodingKey{
        case level, growingDays, numPlants, totalWaterNum, didWaterNum, hapiness, registeredDate}
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        level = try container.decode(Level.self, forKey: .level)
        growingDays = try container.decode(Int.self, forKey: .growingDays)
        numPlants = try container.decode(Int.self, forKey: .numPlants)
        totalWaterNum = try container.decode(Int.self, forKey: .totalWaterNum)
        didWaterNum = try container.decode(Int.self, forKey: .didWaterNum)
        hapiness = try container.decode(Int.self, forKey: .hapiness)
        registeredDate = try container.decode(Date.self, forKey: .registeredDate)
        
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var valueContatiner = encoder.container(keyedBy: CodingKeys.self)
        
        try valueContatiner.encode(self.level,forKey: CodingKeys.level)
        try valueContatiner.encode(self.growingDays,forKey: CodingKeys.growingDays)
        try valueContatiner.encode(self.numPlants,forKey: CodingKeys.numPlants)
        try valueContatiner.encode(self.totalWaterNum,forKey: CodingKeys.totalWaterNum)
        try valueContatiner.encode(self.didWaterNum,forKey: CodingKeys.didWaterNum)
        try valueContatiner.encode(self.hapiness,forKey: CodingKeys.hapiness)
        try valueContatiner.encode(self.registeredDate,forKey: CodingKeys.registeredDate)
        
        
    }
    
    
    init(_ registeredDate: Date) {
        level = levels[0]
        growingDays = 10
        numPlants = 2
        hapiness = 80
        totalWaterNum = 10
        didWaterNum = 8
        self.registeredDate = registeredDate
    }
    
    mutating func updateUser() {
        numPlants = userPlants.count
        growingDays = Calendar.current.dateComponents([.day], from: registeredDate, to: Date()).day!
        
        hapiness = (didWaterNum * 100) / totalWaterNum
        
        
        for standard in levels {
            if Int(standard.hapiness) <= hapiness && standard.numPlants <= numPlants && standard.growingDays <= growingDays {
                self.level = standard
            }
        }
    }
}

// 사용자가 처음 식물을 등록한 날로 바꿔야 함.



func loadUserInfo(){
    let jsonDecoder = JSONDecoder()
    print("load start")
        
        do{
           
            
            let jsonData  = try Data(contentsOf: userInfoURL, options: .mappedIfSafe)
            let decoded = try jsonDecoder.decode(User.self, from: jsonData)

           myUser = decoded
            
            
            
        }
        catch {
            print("에러")
            print(error)
           
        }

    print("load finish")
}


func  saveUserInfo(user : User) {

    
    let jsonEncoder = JSONEncoder()

      do{
          let encodeData = try jsonEncoder.encode(user)
     
         print("user save")
          print(userInfoURL)
        
          do{
              try encodeData.write(to: userInfoURL, options: .noFileProtection)
               
          }
          catch let error as NSError {
              print(error)
          }
          
          
      }
      catch {
          print(error)
      }
    

    print("user save complete")
}
var myUser: User!
