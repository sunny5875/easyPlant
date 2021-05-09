//
//  UserPlant.swift
//  easyPlantHomeTap
//
//  Created by 차다윤 on 2021/04/30.
//

import Foundation

struct UserPlant {
    var name: String
    var location: String
    //let registDate: Calendar
    var cycle: String
    //var lastWaterTime: Calendar
    var plantImage: String
}

var userPlants: [UserPlant] = [UserPlant(name: "초록콩", location: "책상 옆", cycle: "1달", plantImage: "plant"), UserPlant(name: "사랑이", location: "옷서랍 위", cycle: "1주", plantImage: "plant"), UserPlant(name: "쁘니", location: "창가", cycle: "2주", plantImage: "plant"), UserPlant(name: "요미", location: "창가", cycle: "4일", plantImage: "plant"), UserPlant(name: "토끼", location: "책상 위", cycle: "2주", plantImage: "plant"), UserPlant(name: "hi", location: "hi", cycle: "hi", plantImage: "plant"), UserPlant(name: "hello", location: "hello", cycle: "hello", plantImage: "plant"), UserPlant(name: "bye", location: "bye", cycle: "bye", plantImage: "plant"), UserPlant(name: "hihi", location: "hihi", cycle: "hihi", plantImage: "plant")]
