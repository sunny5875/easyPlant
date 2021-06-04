//
//  level.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/05/30.
//

import Foundation
import UIKit


struct level {
    let name : String
    let hapiness : Double
    let numPlants : Int
    let growingDays : Int
    let icon : String
    let description: String
}

let levels: [level] = [level(name: "일반인", hapiness: 0, numPlants: 0,
                             growingDays: 0, icon: "person", description: "새롭게 식물을 등록해 보세요!"),
                       level(name: "새내기 농부", hapiness: 75, numPlants: 1,
                             growingDays: 0, icon: "sprout", description: "새롭게 농부가 된 당신! 앞으로 easyPlant와 함께 식물을 키워나가요"),
                       level(name: "초보 농부", hapiness: 80, numPlants: 3, growingDays: 60, icon: "leaf", description: "식물을 키우는 재미를 느끼셨나요? 다음 레벨을 향해 더 노력해봐요!"),
                       level(name: "주니어 농부", hapiness: 85, numPlants: 6, growingDays: 180, icon: "flower", description: "여기까지 오느라 수고하셨어요~ 한 단계 성장한 농부가 되셨네요!"),
                       level(name: "숙련된 농부", hapiness: 90, numPlants: 10, growingDays: 360, icon: "apple", description: ""),
                       level(name: "진정한 농부", hapiness: 95, numPlants: 15, growingDays: 720, icon: "tree", description: "축하드립니다. 이제 당신도 진정한 농부! 1년동안 식물의 행복을 유지해서 Easy Planter에 도전하세요!"),
                       level(name: "Easy Planter", hapiness: 95, numPlants: 15, growingDays: 1080, icon: "forest", description: "여기까지 오셨네요! 앞으로는 쭉 Easy Planter로서 식물을 행복하게 해주세요 (해당 단계 이후로는 단계가 떨어지지 않습니다.)")]
