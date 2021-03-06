//
//  level.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/05/30.
//

import Foundation
import UIKit


struct Level: Codable{
    let name : String
    let hapiness : Int
    let numPlants : Int
    let growingDays : Int
    let icon : String
    let description: String
}

let levels: [Level] = [Level(name: "일반인", hapiness: 0, numPlants: 0,growingDays: 0, icon: "person", description: "새롭게 식물을 등록해 보세요!"),
                       Level(name: "새내기 농부", hapiness: 0, numPlants: 1,
                             growingDays: 0, icon: "sprout", description: "새롭게 농부가 된 당신!\n앞으로 easyPlant와 함께 식물을 키워나가요. "),
                       Level(name: "초보 농부", hapiness: 70, numPlants: 3, growingDays: 60, icon: "leaf", description: "식물을 키우는 재미를 느끼셨나요?\n다음 레벨을 향해 더 노력해봐요!"),
                       Level(name: "주니어 농부", hapiness: 80, numPlants: 6, growingDays: 180, icon: "flower", description: "여기까지 오느라 수고하셨어요~\n한 단계 성장한 농부가 되셨네요!"),
                       Level(name: "숙련된 농부", hapiness: 90, numPlants: 10, growingDays: 360, icon: "apple", description: "1년동안 당신의 식물들과 행복한 시간 보내셨나요?\n이제 식물들을 돌보는 것에 익숙해졌을거라 생각해요."),
                       Level(name: "진정한 농부", hapiness: 95, numPlants: 15, growingDays: 720, icon: "tree", description: "축하드립니다. 이제 당신도 진정한 농부!\n1년동안 식물의 행복을 유지해서 Easy Planter에 도전하세요!"),
                       Level(name: "Easy Planter", hapiness: 95, numPlants: 15, growingDays: 1080, icon: "forest", description: "여기까지 오셨네요!\n앞으로는 쭉 Easy Planter로서 식물을 행복하게 해주세요\n(해당 단계 이후로는 단계가 떨어지지 않습니다.)")]

