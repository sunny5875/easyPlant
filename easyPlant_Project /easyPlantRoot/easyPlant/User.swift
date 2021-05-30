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
    
    var hapiness: Double
    let registeredDate: Date
    
    init(_ registeredDate: Date) {
        level = levels[3]
        growingDays = 0
        numPlants = 2
        hapiness = 40
        totalWaterNum = 0
        didWaterNum = 0
        self.registeredDate = registeredDate
    }
    
    mutating func updateUser() {
        numPlants = userPlants.count
        growingDays = Calendar.current.dateComponents([.day], from: registeredDate, to: Date()).day!
        
        hapiness = Double(didWaterNum / totalWaterNum)
        
        
        for standard in levels {
            if standard.hapiness <= hapiness && standard.numPlants <= numPlants && standard.growingDays <= growingDays {
                self.level = standard
            }
        }
    }
}

// 사용자가 처음 식물을 등록한 날로 바꿔야 함.
var myUser: User = User(Date())
