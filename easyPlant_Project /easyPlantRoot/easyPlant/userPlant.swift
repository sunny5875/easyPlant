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
    var waterPeriod : Int
    var wateringDay : Date
    var plantSpecies : String
    var sunLight : Int
    var temperature : Double
    var diarylist : [Diary]
    var color : UIColor
    var happeniess : [Double]
    var alarmTime : Date
    var plantImage : String
    var watered : Int
}
var listPlantsIndex: [Int] = []

var userPlants : [userPlant] = [userPlant(name: "초록콩", location: "책상 위", registedDate: "2010-10-30",        waterPeriod: 28, wateringDay: Date(), plantSpecies: "스투키", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(red: 1, green: 0, blue: 0, alpha: 1), happeniess: [86.4,65.3,67.4,98.2,87,68.8,76.8,77.8,89.0,76.7], alarmTime: Date() ,plantImage: "스투키", watered: 0),
                                userPlant(name: "쁘띠", location: "창가", registedDate: "2010-10-30", waterPeriod: 3, wateringDay: Date(), plantSpecies: "호야", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(red: 0, green: 1, blue: 0, alpha: 1), happeniess: [86.4,65.3,57.4,76.8], alarmTime: Date() ,plantImage: "호야", watered: 0),
                                userPlant(name: "요니", location: "베란다", registedDate: "2010-10-30", waterPeriod: 14, wateringDay: Date(), plantSpecies: "싱고니움", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(red: 0, green: 0, blue: 1, alpha: 1), happeniess:  [86.4,65.3,67.4,98.2,87,68.8,76.8,77.8,89.0,76.7], alarmTime: Date(), plantImage: "싱고니움", watered: 0),
                                userPlant(name: "꾹꾹이", location: "베란다", registedDate: "2010-10-30", waterPeriod: 14, wateringDay: Date(), plantSpecies: "테이블야자", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(red: 1, green: 1, blue: 0, alpha: 1), happeniess:  [86.4,65.3,67.4,98.2,87,68.8,76.8,77.8,89.0,76.7], alarmTime: Date() , plantImage: "테이블야자", watered: 0)]
