//
//  userPlant.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import Foundation
import UIKit

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
    var alarmTime : Double
    var plantImage : String

}


var userPlants : [userPlant] = [userPlant(name: "초록콩", location: "책상 위", registedDate: "2010-10-30",        waterPeriod: 28, wateringDay: Date(), plantSpecies: "스투키", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(), happeniess: [86.4,65.3,67.4,98.2,87,68.8,76.8,77.8,89.0,76.7], alarmTime: 10.0,plantImage: "plant"),
                                userPlant(name: "쁘띠", location: "창가", registedDate: "2010-10-30", waterPeriod: 7, wateringDay: Date(), plantSpecies: "스투키", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(), happeniess: [86.4,65.3,57.4,76.8], alarmTime: 10.0,plantImage: "plant"),
                                userPlant(name: "요니", location: "베란다", registedDate: "2010-10-30", waterPeriod: 14, wateringDay: Date(), plantSpecies: "스투키", sunLight: 20, temperature: 22.3, diarylist: diarys, color: UIColor(), happeniess:  [86.4,65.3,67.4,98.2,87,68.8,76.8,77.8,89.0,76.7], alarmTime: 10.0, plantImage: "plant")]
