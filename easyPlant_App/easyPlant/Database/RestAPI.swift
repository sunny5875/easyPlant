//
//  RestAPI.swift
//  easyPlant
//
//  Created by 김유진 on 2021/07/15.
//

import Foundation
import Alamofire
import SwiftyJSON
import SWXMLHash

//var detailDic : [String : String] = [:]

let nongsaroApiKey:String = "20210714VEVXFVNHSKPNIVDN3EUQ"
let metaURL = "http://api.nongsaro.go.kr/service/garden/gardenList"
let plantURL = "http://api.nongsaro.go.kr/service/garden/gardenDtl"
let imageURL = "https://www.nongsaro.go.kr/cms_contents/301/"


let plantKey :[String:String] = [
    //디테일뷰에 표시 - 40개
    "plntbneNm" : "식물 학명",
    "plntzrNm" : "식물 영명",
    "distbNm" :  "유통명",
    "fmlCodeNm" : "과명",
    "orgplceInfo" : "원산지",
    
    "adviseInfo" : "조언",
    "growthHgInfo" : "성장 높이",
    "growthAraInfo" : "성장 넓이",
    "lefStleInfo": "잎 형태",
    "smellCodeNm": "냄새", //10
    
    "toxctyInfo": "독성",
    "prpgtEraInfo": "번식 시기",
    "managelevelCodeNm": "관리 수준",
    "managedemanddoCodeNm" : "관리요구도",
    "grwtveCodeNm": "생장 속도",
    
    "grwhTpCodeNm" :"생육 온도",
    "winterLwetTpCodeNm" : "겨울 최저 온도",
    "hdCodeNm" : "습도",
    "frtlzrInfo" : "비료",
    "soilInfo" : "토양", // 20
    
    "watercycleSpringCodeNm": "봄 물주기",
    "watercycleSummerCodeNm": "여름 물주기",
    "watercycleAutumnCodeNm" : "가을 물주기",
    "watercycleWinterCodeNm": "겨울 물주기",
    "speclmanageInfo" : "특별관리",
    
    "fncltyInfo" : "기능" ,
    "clCodeNm" : "분류",
    "grwhstleCodeNm" : "생육형태",
    "postngplaceCodeNm" : "배치 장소",
    "eclgyCodeNm": "생태", //30
    
    "lefmrkCodeNm" : "잎 무늬",
    "lefcolrCodeNm" : "잎색",
    "ignSeasonCodeNm": "발화 계절",
    "flclrCodeNm": "꽃색",
    "fmldeSeasonCodeNm" : "과일 계절",
    
    "fmldecolrCodeNm" : "과일 색",
    "prpgtmthCodeNm" : "번식 방법",
    "lighttdemanddoCodeNm": "광요구도",
    "dlthtsCodeNm" : "병충해",
    "dlthtsManageInfo" : "병충해 관리", //40
    
    
    //디테일 뷰 표시 x
    "rtnStreFileNm" : "이미지",
    "cntntsSj" : "식물명"


]

let keyArray = ["plntbneNm" ,
                "plntzrNm" ,
                "distbNm" ,
                "fmlCodeNm" ,
                "orgplceInfo" ,
                
                "adviseInfo" ,
                "growthHgInfo" ,
                "growthAraInfo",
                "lefStleInfo",
                "smellCodeNm",
                
                "toxctyInfo",
                "prpgtEraInfo",
                "managelevelCodeNm",
                "managedemanddoCodeNm" ,
                "grwtveCodeNm",
                
                "grwhTpCodeNm",
                "winterLwetTpCodeNm",
                "hdCodeNm" ,
                "frtlzrInfo" ,
                "soilInfo" ,
                
                "watercycleSpringCodeNm",
                "watercycleSummerCodeNm",
                "watercycleAutumnCodeNm" ,
                "watercycleWinterCodeNm",
                "speclmanageInfo" ,
                
                "fncltyInfo"  ,
                "clCodeNm" ,
                "grwhstleCodeNm" ,
                "postngplaceCodeNm" ,
                "eclgyCodeNm",
                
                "lefmrkCodeNm" ,
                "lefcolrCodeNm" ,
                "ignSeasonCodeNm",
                "flclrCodeNm",
                "fmldeSeasonCodeNm" ,
                
                "fmldecolrCodeNm",
                "prpgtmthCodeNm",
                "lighttdemanddoCodeNm",
                "dlthtsCodeNm",
                "dlthtsManageInfo" ]


func initDetailDic()-> [String:String]{
    var detailDic : [String : String] = [:]
    for key in plantKey.keys{
        detailDic.updateValue("", forKey: key)
    }
    return detailDic
}


func loadPlantSearchList(){
    for i in 0...6{
    plantType.plantAll[i] = []
    }
    
    //["전체검색","공기정화","그늘에서","다육식물","귀차니즘","인테리어","반려동물"]
    fetchData(metaURL, plantURL, "" , 0)

    fetchData(metaURL, plantURL, "야자" , 1)
    
    fetchData(metaURL, plantURL, "나한송", 4)
    
    fetchData(metaURL, plantURL, "네마탄투스" , 5)
    
    fetchData(metaURL, plantURL, "네오레겔리아" , 5)
    
    fetchData(metaURL, plantURL, "뉴기니아봉선화" , 5)
    
    fetchData(metaURL, plantURL, "더피고사리" , 5)
    
    fetchData(metaURL, plantURL, "녹영" , 5)
    
    fetchData(metaURL, plantURL, "데코라고무나무" , 2)
    
    fetchData(metaURL, plantURL, "동백" , 5)
    
    fetchData(metaURL, plantURL, "드라세나 '와네끼'" , 1)
    fetchData(metaURL, plantURL, "드라세나 '송오브인디아'" , 5)
    
    fetchData(metaURL, plantURL, "드라세나 '자바'" , 1)
    
    fetchData(metaURL, plantURL, "드라세나 '콤팩타'" , 1)
    
    fetchData(metaURL, plantURL, "드라세나 드라코" , 1)
    
    fetchData(metaURL, plantURL, "드라세나 마지나타" , 1)
    
    fetchData(metaURL, plantURL, "드라세나 맛상게아나" , 5)
    
    fetchData(metaURL, plantURL, "드라세나 산다레아나" , 1)
    
    fetchData(metaURL, plantURL, "떡갈잎 고무나무" , 2)
    
    fetchData(metaURL, plantURL, "러브체인" , 5)
    
    fetchData(metaURL, plantURL, "렉스베고니아" , 5)
    
    fetchData(metaURL, plantURL, "루스커스" , 2)
    
    fetchData(metaURL, plantURL, "만데빌라" , 5)
    
    fetchData(metaURL, plantURL, "몬스테라" , 2)
    
    fetchData(metaURL, plantURL, "무늬관음죽" , 1)
    
    fetchData(metaURL, plantURL, "무늬벤자민고무나무" , 1)
    
    fetchData(metaURL, plantURL, "무늬쉐플레라'홍콩'" , 1)
    
    fetchData(metaURL, plantURL, "뮤렌베키아" , 4)
    fetchData(metaURL, plantURL, "보스톤고사리" , 5)
    fetchData(metaURL, plantURL, "산세베리아" , 1)
    fetchData(metaURL, plantURL, "산호수" , 4)
    fetchData(metaURL, plantURL, "삼색데코라고무나무" , 5)
    fetchData(metaURL, plantURL, "세네시오 라디칸스" , 5)
    fetchData(metaURL, plantURL, "세이프릿지 야자" , 1)
    fetchData(metaURL, plantURL, "수박필레아" , 2)
    fetchData(metaURL, plantURL, "쉐플레라 '홍콩'" , 1)
    fetchData(metaURL, plantURL, "스킨답서스" , 4)
    fetchData(metaURL, plantURL, "심비디움" , 5)
    fetchData(metaURL, plantURL, "싱고니움" , 2)
    fetchData(metaURL, plantURL, "아라우카리아" , 1)
    fetchData(metaURL, plantURL, "아레카야자" , 1)
    fetchData(metaURL, plantURL, "아이비" , 2)
    fetchData(metaURL, plantURL, "안수리움" , 1)
    
    
    
    
    //fetchData(metaURL, plantURL, "야자" , 5)
    
    //fetchData(metaURL, plantURL, "야자" , 6)
    
    //saveUserInfo(user: myUser)
    //saveNewUserPlant(plantsList: uearPlants, archiveURL: <#T##URL#>)

    
}


func fetchData(_ urlMeta:String, _ urlPlant: String, _ text :String, _ indexArray : Int){
    //필요한 변수 선언
    var cntntsNoExtract : [Int] = []
    var imageCodeExtract : [String] = []
    var nameExtract : [String] = []
    var metaParam = [String:Any] ()
    var plantParam = [String:Any] ()
    
    //메타 매개 변수 초기화
    
    
    if text == "" {
        metaParam = [
            "apiKey" : nongsaroApiKey,
            "sText" : text,
            "pageNo": 1,
            "numOfRows" : 300

        ]
    }
    else{
        metaParam = [
            "apiKey" : nongsaroApiKey,

            "sType" : "sCntntsSj",
            "sText" : text,

            
            "pageNo": 1,
            "numOfRows" : 300

        ]
    }
    
    print("fetch start")
     
    //cntntsNo 뽑아내기
    AF.request(urlMeta, parameters: metaParam)
            .responseData { response in
                let xml = SWXMLHash.parse(response.value!)
                let head = xml["response"]["header"]
               // print(head)
                let body = xml["response"]["body"]["items"]["item"]
                
                for item in body.all{
                    //print(item)
                    if let itemNo = item["cntntsNo"].element?.text, let toInt = Int(itemNo), let imagecode = item["rtnStreFileNm"].element?.text,let name = item["cntntsSj"].element?.text{
                        cntntsNoExtract.append(toInt)
                        imageCodeExtract.append(imagecode)
                        nameExtract.append(name)
                        
                        downloadPlantDataImage(imgview: UIImageView(), title: "\(name)")

                        
                    }
                }
                
                //print(cntntsNoExtract)
                //print(imageCodeExtract)
                //print(nameExtract)
                
                for (index,num) in cntntsNoExtract.enumerated(){
                    
                    //매개변수 초기화
                    plantParam = [
                        
                        "apiKey" : nongsaroApiKey,
                        "cntntsNo" : num
                    ]
                        //식물 상세정보 가져오기
                        AF.request(urlPlant, parameters: plantParam)
                            .responseData { response in
                                var tmpDic = initDetailDic()

                                    let xml = SWXMLHash.parse(response.value!)
                                    //print(xml)
                                    let body = xml["response"]["body"]["item"]
                                    
                                for key in plantKey.keys{
                                        if let element = body[key].element{
                                            
                                            tmpDic.updateValue(element.text, forKey: key)
                                        }
                                    }
                               
                                let count = imageCodeExtract[index].split(separator: "|").count
                                let split = String( imageCodeExtract[index].split(separator: "|")[count-1])
                                
                                //print(split)
                                
                                tmpDic["rtnStreFileNm"] = split
                                tmpDic["cntntsSj"] = nameExtract[index]
                                
                                    
                                addPlantElement(tmpDic, indexArray)
                                        
                                  
                                    

                            }
                        
                    
                }
               // print("adding process all clear")
              

        }


}

func addPlantElement(_ detail: [String: String], _ index : Int){
   // print("add print element")
    var newPlant = Plant()
    newPlant.initDic()
    
    for key in detail.keys{
        if detail[key] != "" {
            newPlant.dic[key] = detail[key]
            //print(newPlant.dic[key]!)
        }
    }
    
    plantType.plantAll[index].append(newPlant)
   // print( plantType.plantAll[index])

    //print("add finish")
}






