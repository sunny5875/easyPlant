//
//  plant.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import Foundation
struct Plant {
    var name: String
    var like: Int


}


var plantsClearAir: [Plant] = [
    Plant(name: "산세베리아", like: 0),
    Plant(name: "바나나", like: 0),
    Plant(name: "백도선", like: 0),
    Plant(name: "스킨답서스", like: 0),
    Plant(name: "행운목", like: 0),
    Plant(name: "만세선인장", like: 0)
  
]

var plantsAnimal: [Plant] = [
    Plant(name: "산세베리아", like: 0),
    Plant(name: "바나나", like: 0),
    Plant(name: "백도선", like: 0),
    Plant(name: "스킨답서스", like: 0),
    Plant(name: "행운목", like: 0),
    Plant(name: "만세선인장", like: 0)
  
]

var plantsLazy: [Plant] = [
    Plant(name: "산세베리아", like: 0),
    Plant(name: "바나나", like: 0),
    Plant(name: "백도선", like: 0),
    Plant(name: "스킨답서스", like: 0),
    Plant(name: "행운목", like: 0),
    Plant(name: "만세선인장", like: 0)
  
]

var plantsInterior: [Plant] = [
    Plant(name: "산세베리아", like: 0),
    Plant(name: "바나나", like: 0),
    Plant(name: "백도선", like: 0),
    Plant(name: "스킨답서스", like: 0),
    Plant(name: "행운목", like: 0),
    Plant(name: "만세선인장", like: 0)
  
]

var plantsEasy: [Plant] = [
    Plant(name: "산세베리아", like: 0),
    Plant(name: "바나나", like: 0),
    Plant(name: "백도선", like: 0),
    Plant(name: "스킨답서스", like: 0),
    Plant(name: "행운목", like: 0),
    Plant(name: "만세선인장", like: 0)
  
]

var plantsShade: [Plant] = [
    Plant(name: "산세베리아", like: 0),
    Plant(name: "바나나", like: 0),
    Plant(name: "백도선", like: 0),
    Plant(name: "스킨답서스", like: 0),
    Plant(name: "행운목", like: 0),
    Plant(name: "만세선인장", like: 0)
  
]

var plantsTemp: [Plant] = [
    Plant(name: "산세베리아", like: 0),
    Plant(name: "바나나", like: 0),
    Plant(name: "백도선", like: 0),
    Plant(name: "스킨답서스", like: 0),
    Plant(name: "행운목", like: 0),
    Plant(name: "만세선인장", like: 0)
  
]

var plantsDry: [Plant] = [
    Plant(name: "산세베리아", like: 0),
    Plant(name: "바나나", like: 0),
    Plant(name: "백도선", like: 0),
    Plant(name: "스킨답서스", like: 0),
    Plant(name: "행운목", like: 0),
    Plant(name: "만세선인장", like: 0)
  
]

var plantsLight: [Plant] = [
    Plant(name: "산세베리아", like: 0),
    Plant(name: "바나나", like: 0),
    Plant(name: "백도선", like: 0),
    Plant(name: "스킨답서스", like: 0),
    Plant(name: "행운목", like: 0),
    Plant(name: "만세선인장", like: 0)
  
]


struct PlantType {
    var type: [String]
    var plantAll: [[Plant]]
    
}



var plantType = PlantType(
    type : ["공기정화","반려동물","귀차니즘","인테리어","초보농부","그늘에서","온도무관","다육식물","햇빛듬뿍"],
    plantAll : [plantsClearAir,plantsAnimal,plantsLazy,plantsInterior,plantsEasy,plantsShade,plantsTemp,plantsDry,plantsLight]

)




