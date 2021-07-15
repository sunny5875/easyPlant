//
//  RestAPI.swift
//  easyPlant
//
//  Created by 김유진 on 2021/07/15.
//

import Foundation
import Alamofire
var metaParam = [String:Any]()
var plantParam = [String:Any]()

let apiDecoder = JSONDecoder()
let nongsaroApiKey:String = "20210714VEVXFVNHSKPNIVDN3EUQ"


func initMetaPara(_ search : String){
    metaParam = [
        "apiKey" : nongsaroApiKey,
        "sText" : search,
        "pageNo": 1,
        "numOfRows" : 300

    ]
    
}

func initPlantParam(_ cntntsNo : Int){
    plantParam = [
        
        "apiKey" : nongsaroApiKey,
        "cntntsNo" : cntntsNo
    ]

}

var plantSource : [plantData] = []
var metaSource : [metaData] = []

struct plantAPIresponse: Codable{
    let plantList : [plantData]
}

struct metaAPIresponse: Codable{
    let metaList : [metaData]
}

struct metaData: Codable{
    let cntntsNo : Int
    let cntntsSj : String
    let rtnFileSeCode : Int
    let rtnFileSn : Int
    let rtnOrginlFileNm : String
    let rtnStreFileNm : String
    let rtnFileCours : String
    let rtnImageDc : String
    let rtnThumbFileNm : String
    let rtnImgSeCode : Int

}

struct plantData: Codable{
    var plntbneNm : String
    var plntzrNm :  String
    /*
    distbNm: String
    fmlNm: String
    fmlCodeNm: String
    orgplceInfo: String
    adviseInfo: String
    imageEvlLinkCours: String
    growthHgInfo
    growthAraInfo
    lefStleInfo
    smellCode
    smellCodeNm
    toxctyInfo
    prpgtEraInfo
    etcEraInfo
    managelevelCode
    managelevelCodeNm
    grwtveCode
    grwtveCodeNm
    grwhTpCode
    grwhTpCodeNm
    winterLwetTpCode
    winterLwetTpCodeNm
    hdCode
    hdCodeNm
    frtlzrInfo
    soilInfo
    watercycleSprngCode
    watercycleSprngCodeNm
    watercycleSummerCode
    watercycleSummerCodeNm
    watercycleAutumnCode
    watercycleAutumnCodeNm
    watercycleWinterCode
    watercycleWinterCodeNm
    dlthtsManageInfo
    speclmanageInfo
    fncltyInfo
    flpodmtBigInfo
    flpodmtMddlInfo
    flpodmtSmallInfo
    WIDTH_BIG_INFO
    widthMddlInfo
    widthSmallInfo
    vrticlBigInfo
    vrticlMddlInfo
    vrticlSmallInfo
    hgBigInfo
    hgMddlInfo
    hgSmallInfo
    volmeBigInfo
    volmeMddlInfo
    volmeSmallInfo
    pcBigInfo
    pcMddlInfo
    pcSmallInfo
    managedemanddoCode
    managedemanddoCodeNm
    clCode
    clCodeNm
    grwhstleCode
    grwhstleCodeNm
    indoorpsncpacompositionCode
    indoorpsncpacompositionCodeNm
    eclgyCode
    eclgyCodeNm
    lefmrkCode
    lefmrkCodeNm
    lefcolrCode
    lefcolrCodeNm
    ignSeasonCode
    ignSeasonCodeNm
    flclrCode
    flclrCodeNm
    fmldeSeasonCode
    fmldeSeasonCodeNm
    fmldecolrCode
    fmldecolrCodeNm
    prpgtmthCode
    prpgtmthCodeNm
    lighttdemanddoCode
    lighttdemanddoCodeNm
    postngplaceCode
    postngplaceCodeNm
    dlthtsCode
    dlthtsCodeNm

*/
    

}



