//
//  RestAPI.swift
//  easyPlant
//
//  Created by 김유진 on 2021/07/15.
//

import Foundation
import Alamofire
let apiDecoder = JSONDecoder()

let param: Parameters = [
    "apiKey" : "20210714VEVXFVNHSKPNIVDN3EUQ",
    "sType" : "한명",
    "sText" : "야자",
    "pageNo": 1,
    "numOfRows" : 300
]

var dataSource : [plantData] = []

struct APIresponse: Codable{
    let plantList : [plantData]
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



