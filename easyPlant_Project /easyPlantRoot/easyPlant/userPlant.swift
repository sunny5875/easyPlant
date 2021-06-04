//
//  userPlant.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import Foundation
import UIKit


var clickedDay: Date = Date()

struct userPlant{
    var name: String
    var location: String
    let registedDate : String
    var recentlyWateringDay : String
    var waterPeriod : Int
    var wateringDay : Date
    var plantSpecies : String
    var diarylist : [Diary]
    var color : UIColor
    var happeniess : [Int]
    var alarmTime : Date
    var plantImage : String
    var watered : Int
    
    
    
    init() {
        name = ""
        location = ""
        registedDate = ""
        recentlyWateringDay = ""
        waterPeriod = 0
        wateringDay = Date()
        plantSpecies = ""
        diarylist = []
        color = UIColor()
        happeniess = []
        alarmTime = Date()
        plantImage = "plant"
        watered = Int()
        
    }
    
    init(name : String, location : String, registedDate : String, recentlyWateringDay : String, waterPeriod : Int, wateringDay : Date, plantSpecies : String, diarylist : [Diary], color : UIColor, happeniess : [Int], alarmTime : Date, plantImage : String, watered : Int) {
        self.name = name
        self.location = location
        self.registedDate = registedDate
        self.recentlyWateringDay = recentlyWateringDay
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
}
var listPlantsIndex: [Int] = []

var userPlants : [userPlant] = [userPlant(name: "초록콩", location: "책상 위", registedDate: "2010-10-30", recentlyWateringDay: "2020-10-31",        waterPeriod: 28, wateringDay: Date(), plantSpecies: "스투키", diarylist: diarys, color: UIColor(red: 1, green: 0, blue: 0, alpha: 1), happeniess: [86,65,67,98,87,68,76,77,89,76], alarmTime: Date() ,plantImage: "스투키", watered: 0),
                                userPlant(name: "쁘띠", location: "창가", registedDate: "2010-10-30", recentlyWateringDay: "2020-10-31", waterPeriod: 3, wateringDay: Date(), plantSpecies: "호야",  diarylist: diarys, color: UIColor(red: 0, green: 1, blue: 0, alpha: 1), happeniess: [86,65,57,76], alarmTime: Date() ,plantImage: "호야", watered: 0),
                                userPlant(name: "요니", location: "베란다", registedDate: "2010-10-30", recentlyWateringDay: "2020-12-31", waterPeriod: 14, wateringDay: Date(), plantSpecies: "싱고니움", diarylist: diarys, color: UIColor(red: 0, green: 0, blue: 1, alpha: 1), happeniess:  [86,65,67,98,87,64,76,77,89,76], alarmTime: Date(), plantImage: "싱고니움", watered: 0),
                                userPlant(name: "꾹꾹이", location: "베란다", registedDate: "2010-10-30", recentlyWateringDay: "2020-11-31", waterPeriod: 14, wateringDay: Date(), plantSpecies: "테이블야자", diarylist: diarys, color: UIColor(red: 1, green: 1, blue: 0, alpha: 1), happeniess:  [86,65,67,98,87,68,76,77,89,74], alarmTime: Date() , plantImage: "테이블야자", watered: 0)]
