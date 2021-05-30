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
    var happeniess : [Int] // Float으로 하는거 보다 정수형이 깔끔해서 바꿨어
    var alarmTime : Date
    var plantImage : String
    var watered : Int
}
var listPlantsIndex: [Int] = []

var userPlants : [userPlant] = [userPlant(name: "초록콩", location: "책상 위", registedDate: "2010-10-30",        waterPeriod: 28, wateringDay: Date(), plantSpecies: "스투키", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(red: 1, green: 0, blue: 0, alpha: 1), happeniess: [86,65,67,98,87,68,76,77,89,76], alarmTime: Date() ,plantImage: "스투키", watered: 0),
                                userPlant(name: "쁘띠", location: "창가", registedDate: "2010-10-30", waterPeriod: 3, wateringDay: Date(), plantSpecies: "호야", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(red: 0, green: 1, blue: 0, alpha: 1), happeniess: [86,65,57,76], alarmTime: Date() ,plantImage: "호야", watered: 0),
                                userPlant(name: "요니", location: "베란다", registedDate: "2010-10-30", waterPeriod: 14, wateringDay: Date(), plantSpecies: "싱고니움", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(red: 0, green: 0, blue: 1, alpha: 1), happeniess:  [86,65,67,98,87,64,76,77,89,76], alarmTime: Date(), plantImage: "싱고니움", watered: 0),
                                userPlant(name: "꾹꾹이", location: "베란다", registedDate: "2010-10-30", waterPeriod: 14, wateringDay: Date(), plantSpecies: "테이블야자", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(red: 1, green: 1, blue: 0, alpha: 1), happeniess:  [86,65,67,98,87,68,76,77,89,74], alarmTime: Date() , plantImage: "테이블야자", watered: 0)]
