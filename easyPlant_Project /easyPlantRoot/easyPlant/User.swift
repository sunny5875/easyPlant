//
//  User.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/05/30.
//

import Foundation


struct User {
    var level: level
    var growingDays: Int
    var numPlants: Int
    var totalWaterNum: Int
    var didWaterNum: Int
    
    var hapiness: Int //int형으로 바꿨어
    let registeredDate: Date
    
    init(_ registeredDate: Date) {
        level = levels[1]
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
        
        hapiness = didWaterNum / totalWaterNum
        
        
        for standard in levels {
            if Int(standard.hapiness) <= hapiness && standard.numPlants <= numPlants && standard.growingDays <= growingDays {
                self.level = standard
            }
        }
    }
}

// 사용자가 처음 식물을 등록한 날로 바꿔야 함.
var myUser: User = User(Date())
