//
//  userPlant.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import Foundation
import UIKit


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

struct userPlant : Codable {
    var name: String
    var location: String
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
        case name,location,registedDate,waterPeriod, wateringDay,plantSpecies, diarylist,color,happeniess,alarmTime,plantImage,watered }
    
    
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
    }
    public func encode(to encoder: Encoder) throws {
        var valueContatiner = encoder.container(keyedBy: CodingKeys.self)
        
        try valueContatiner.encode(true,forKey: CodingKeys.name)
        try valueContatiner.encode(true,forKey: CodingKeys.location)
        try valueContatiner.encode(true,forKey: CodingKeys.registedDate)
        try valueContatiner.encode(true,forKey: CodingKeys.waterPeriod)
        try valueContatiner.encode(true,forKey: CodingKeys.wateringDay)
        try valueContatiner.encode(true,forKey: CodingKeys.plantSpecies)
        try valueContatiner.encode(true,forKey: CodingKeys.diarylist)
        try valueContatiner.encode(true,forKey: CodingKeys.color)
        try valueContatiner.encode(true,forKey: CodingKeys.happeniess)
        try valueContatiner.encode(true,forKey: CodingKeys.alarmTime)
        try valueContatiner.encode(true,forKey: CodingKeys.plantImage)
        try valueContatiner.encode(true,forKey: CodingKeys.watered)
        
    
        
            
        
        
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
        
    }
    
    init(name : String, location : String, registedDate : String, waterPeriod : Int, wateringDay : Date, plantSpecies : String, diarylist : [Diary], color : Color, happeniess : [Int], alarmTime : Date, plantImage : String, watered : Int) {
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
    }
    
    public func  saveNewUserPlant(archiveURL : URL) {

        let encoder: JSONEncoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        
        let propertyListEncoder = PropertyListEncoder()
        let propertyListDecoder = PropertyListDecoder()
        
        print("저장 시작")
        
        if let retrievedNotesData = try? Data(contentsOf: archiveURL){
            if var saved = try? propertyListDecoder.decode(Array<userPlant>.self, from: retrievedNotesData) {
                
               // let temp = try? propertyListEncoder.encode(self)
                saved.append(self)
                
                let encodedNote = try? propertyListEncoder.encode(saved)
           
                
                try? encodedNote?.write(to: archiveURL,options: .noFileProtection)
                
                print(archiveURL)
    
            }
        }
   


    }

}
var listPlantsIndex: [Int] = []

var userPlants : [userPlant] = [userPlant(name: "초록콩", location: "책상 위", registedDate: "2010-10-30",  waterPeriod: 28, wateringDay: Date(), plantSpecies: "스투키", diarylist: diarys, color: Color(uiColor: UIColor(red: 1, green: 0, blue: 0, alpha: 1)), happeniess: [86,65,67,98,87,68,76,77,89,76], alarmTime: Date(timeIntervalSinceNow: 120) ,plantImage: "Stuckyi", watered: 0),
                                userPlant(name: "쁘띠", location: "창가", registedDate: "2010-10-30", waterPeriod: 3, wateringDay: Date(), plantSpecies: "호야",  diarylist: diarys, color: Color(uiColor: UIColor(red: 0, green: 1, blue: 0, alpha: 1)), happeniess: [86,65,57,76], alarmTime: Date() ,plantImage: "Hoya", watered: 0),
                                userPlant(name: "요니", location: "베란다", registedDate: "2010-10-30", waterPeriod: 14, wateringDay: Date(), plantSpecies: "싱고니움", diarylist: diarys, color: Color(uiColor: UIColor(red: 0, green: 0, blue: 1, alpha: 1)), happeniess:  [86,65,67,98,87,64,76,77,89,76], alarmTime: Date(), plantImage: "Syngonium", watered: 0),
                                userPlant(name: "꾹꾹이", location: "베란다", registedDate: "2010-10-30", waterPeriod: 14, wateringDay: Date(), plantSpecies: "테이블야자", diarylist: diarys, color: Color(uiColor: UIColor(red: 1, green: 1, blue: 0, alpha: 1)), happeniess:  [86,65,67,98,87,68,76,77,89,74], alarmTime: Date(timeIntervalSinceNow: 66) , plantImage: "ParlourPalm", watered: 0)]
