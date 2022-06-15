//
//  ItemModel.swift
//  iosRadio
//
//  Created by inforexIOS2 on 2019/12/09.
//  Copyright © 2019 inforexIOS2. All rights reserved.
//

import Foundation
import UIKit


class DefaultConfigDataModel : NetworkModel {
    var data : ConfigDataModels?
    
    enum CodingKeysImpl : String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeysImpl.self)
        self.data = try? container.decode(ConfigDataModels.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class ConfigDataModels: Codable {
    var memGubun : [ConfigDataModel]?
    var osGubun : [ConfigDataModel]?
    var roomType : [ConfigDataModel]?
    var roomState : [ConfigDataModel]?
    var roomRight : [ConfigDataModel]?
    var declarReason : [ConfigDataModel]?
    var items : [ItemModel]?
    var itemCategories : [ItemCategoryData]?
    var particles : [ItemModel]?
    var story : [ItemModel]? // 사연 플러스 아이템
    var version : String
    var isForce : Bool
    var isPayment : Bool
    var isExtend : Bool
    var storeUrl : String
    var boost : [ItemModel]?
    var itemComboCout : [Int]?
    var giftComboCount : [Int]?
    var levelUp: [ItemModel]?
    var itemRepeat : Bool
    var clipType: [ClipTypeData]
    var downloadList : [String]?
    var useMailBox: Bool?
    var loveGood: [ItemModel]?
    
    private enum CodingKeys : String, CodingKey {
        case memGubun
        case osGubun
        case roomType
        case roomState
        case roomRight
        case declarReason
        case particles
        case story
        case items
        case version
        case isForce
        case isPayment
        case storeUrl
        case boost
        case isExtend
        case itemComboCout
        case giftComboCount
        case itemCategories
        case levelUp
        case itemRepeat
        case clipType
        case downloadList
        case useMailBox
        case loveGood
    }
    
    required init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memGubun = (try? container.decode([ConfigDataModel].self, forKey: .memGubun)) ?? [ConfigDataModel]()
        self.osGubun = (try? container.decode([ConfigDataModel].self, forKey: .osGubun)) ?? [ConfigDataModel]()
        self.roomType = (try? container.decode([ConfigDataModel].self, forKey: .roomType)) ?? [ConfigDataModel]()
        self.roomState = (try? container.decode([ConfigDataModel].self, forKey: .roomState)) ?? [ConfigDataModel]()
        self.roomRight = (try? container.decode([ConfigDataModel].self, forKey: .roomRight)) ?? [ConfigDataModel]()
        self.declarReason =  (try? container.decode([ConfigDataModel].self, forKey: .declarReason)) ?? [ConfigDataModel]()
        self.particles =  (try? container.decode([ItemModel].self, forKey: .particles)) ?? [ItemModel]()
        self.story =  (try? container.decode([ItemModel].self, forKey: .story)) ?? [ItemModel]()
        self.items =  (try? container.decode([ItemModel].self, forKey: .items)) ?? [ItemModel]()
        self.version =  (try? container.decode(String.self, forKey: .version)) ?? ""
        self.isForce =  (try? container.decode(Bool.self, forKey: .isForce)) ?? false
        self.isPayment =  (try? container.decode(Bool.self, forKey: .isPayment)) ?? false
        self.storeUrl =  (try? container.decode(String.self, forKey: .storeUrl)) ?? ""
        self.boost =  (try? container.decode([ItemModel].self, forKey: .boost)) ?? [ItemModel]()
        self.isExtend =  (try? container.decode(Bool.self, forKey: .isExtend)) ?? false
        self.itemComboCout =  (try? container.decode([Int].self, forKey: .itemComboCout)) ?? [Int]()
        self.giftComboCount =  (try? container.decode([Int].self, forKey: .giftComboCount)) ?? [Int]()
        self.itemCategories =  (try? container.decode([ItemCategoryData].self, forKey: .itemCategories)) ?? [ItemCategoryData]()
        self.levelUp = (try? container.decode([ItemModel].self, forKey: .levelUp)) ?? [ItemModel]()
        self.itemRepeat = (try? container.decode(Bool.self, forKey: .itemRepeat)) ?? false
        self.clipType = try container.decode([ClipTypeData].self, forKey: .clipType)
        self.downloadList = try container.decode([String].self, forKey: .downloadList)
        self.useMailBox = try? container.decode(Bool.self, forKey: .useMailBox)
        self.loveGood =  (try? container.decode([ItemModel].self, forKey: .loveGood)) ?? [ItemModel]()
    }
}

class ConfigDataModel: Codable {
    var cd : String
    var cdNm : String
    var sortNo : Int
    
    private enum CodingKeys : String, CodingKey {
        case cd
        case cdNm
        case sortNo
    }
    
    required init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cd = try container.decode(String.self, forKey: .cd)
        self.cdNm = try container.decode(String.self, forKey: .cdNm)
        self.sortNo = try container.decode(Int.self, forKey: .sortNo)
    }
}

class ItemCategoryModel: NetworkModel {
    
    var data : [ItemCategoryData]?
    
    enum CodingKeysImple : String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeysImple.self)
        self.data = try? container.decode([ItemCategoryData].self, forKey: .data)
        try super.init(from: decoder)
    }
}

struct ItemCategoryData : Codable {
    
    var code : String
    var value : String
    var isNew : Bool
    
    enum CodingKeys : String, CodingKey {
        case code
        case value
        case isNew
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.value = try container.decode(String.self, forKey: .value)
        self.isNew = (try? container.decode(Bool.self, forKey: .isNew)) ?? true
    }
}

enum EffectType : String {
    case ani
    case sticker
    case enterRoom
    case direct
}


class ItemListModel: NetworkModel {
    
    var data : ItemModelData?
    
    enum CodingKeysImple : String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeysImple.self)
        self.data = try? container.decode(ItemModelData.self, forKey: .data)
        try super.init(from: decoder)
    }
}

struct ItemModelData : Codable {
    // Item, emotion, Level
    var itemCategories : [ItemCategoryData]?
    var boost : [ItemModel]?
    var items : [ItemModel]?
    var levelUp : [ItemModel]?
    var particles : [ItemModel]?
    var loveGood: [ItemModel]?
    var story : [ItemModel]?
    
    enum CodingKeys : String, CodingKey {
        case itemCategories
        case boost
        case items
        case levelUp
        case particles
        case loveGood
        case story
    }
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemCategories = try container.decode([ItemCategoryData].self, forKey: .itemCategories)
        boost = try container.decode([ItemModel].self, forKey: .boost)
        items = try container.decode([ItemModel].self, forKey: .items)
        levelUp = try container.decode([ItemModel].self, forKey: .levelUp)
        particles = try container.decode([ItemModel].self, forKey: .particles)
        loveGood = try container.decode([ItemModel].self, forKey: .loveGood)
        story = (try? container.decode([ItemModel].self, forKey: .story)) ?? nil
    }
}

struct ItemModel : Codable {
    
    // Item, emotion, Level
    var category : String
    var visibility : Bool
    
    var type : String
    var itemNo : String
    var itemNm : String
    var cost : Int = 0
    var thumbs : String
    var webpUrl : String
    var webpFileName : String
    var lottieUrl : String
    var lottieFileName : String
    var soundFileUrl : String
    var soundFileName : String
    var width : Int = 0
    var height: Int = 0
    var deviceRate : Float = 0.0
    var widthRate : Float = 0.0
    var heightRate : Float = 0.0
    var location : String
    var duration : Int
    var iosSelectType : String
    var isNew : Bool
    var sortNo : Int
    var ttsUseYn: String?  // 해당 아이템 tts 사용 여부, 해당 데이터로 컬렉션뷰에서 텍스트 박스를 올려줄지 결정
    
    enum CodingKeys : String, CodingKey {
        case type
        case itemNo
        case itemNm
        case cost
        case thumbs
        case lottieUrl
        case lottieFileName
        case webpUrl
        case webpFileName
        case soundFileUrl
        case soundFileName
        case width
        case height
        case deviceRate
        case widthRate
        case heightRate
        case location
        case duration
        case iosSelectType
        case category
        case visibility
        case isNew
        case sortNo
        case ttsUseYn
    }
    
    init(webpUrl : String ) {
        self.itemNm = ""
        self.type = "ani"
        self.cost = 0
        self.thumbs = ""
        self.width = 360
        self.height = 540
        self.deviceRate = 1.0
        self.widthRate = 1.0
        self.heightRate = 1.5
        self.duration = 12
        self.category = "normal"
        self.visibility = true
        self.isNew = false
        self.itemNo = ""
        self.lottieUrl = ""
        self.webpFileName = ""
        self.soundFileUrl = ""
        self.soundFileName = ""
        self.location = "topLeft"
        self.iosSelectType = "webp"
        self.sortNo = 0
        self.ttsUseYn = "n"
        self.lottieFileName = ""
        self.webpUrl = webpUrl
    }
    
    init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        type           = try container.decode(String.self, forKey: .type)
        itemNo         = try container.decode(String.self, forKey: .itemNo)
        itemNm         = try container.decode(String.self, forKey: .itemNm)
        cost           = try container.decode(Int.self, forKey: .cost)
        thumbs         = try container.decode(String.self, forKey: .thumbs)
        lottieUrl      = try container.decode(String.self, forKey: .lottieUrl)
        lottieFileName = try container.decode(String.self, forKey: .lottieFileName)
        webpUrl        = try container.decode(String.self, forKey: .webpUrl)
        webpFileName   = try container.decode(String.self, forKey: .webpFileName)
        soundFileUrl   = try container.decode(String.self, forKey: .soundFileUrl)
        soundFileName  = try container.decode(String.self, forKey: .soundFileName)
        
        width          = try container.decode(Int.self, forKey: .width)
        height         = try container.decode(Int.self, forKey: .height)
        deviceRate     = try container.decode(Float.self, forKey: .deviceRate)
        widthRate      = try container.decode(Float.self, forKey: .widthRate)
        heightRate     = try container.decode(Float.self, forKey: .heightRate)
        location       = try container.decode(String.self, forKey: .location)
        duration       = try container.decode(Int.self, forKey: .duration)
        iosSelectType  = try container.decode(String.self, forKey: .iosSelectType)
        category       = (try? container.decode(String.self, forKey: .category)) ?? "All"
        visibility     = (try? container.decode(Bool.self, forKey: .visibility)) ?? true
        isNew          = (try? container.decode(Bool.self, forKey: .isNew)) ?? true
        sortNo         = try container.decode(Int.self, forKey: .sortNo)
        ttsUseYn       = (try? container.decode(String.self, forKey: .ttsUseYn)) ?? "n"
    }
}

extension ItemModel: Equatable {
    public static func ==(lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.itemNo == rhs.itemNo
    }
}


struct TTSItemModel: Codable {
    var actorId : String?
    var actorName : String?
    var idx: String?
    
    enum CodingKeys : String, CodingKey {
        case actorId
        case actorName
        case idx
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            actorId   = (try? container.decode(String.self, forKey: .actorId)) ?? ""
            actorName = (try? container.decode(String.self, forKey: .actorName)) ?? ""
            idx       = (try? container.decode(String.self, forKey: .idx))
    }
}

struct TTSSendModel {
    var actorID: String
    var message: String
    
    /// 디폴트 모델 생성
    static func getDefault() -> TTSSendModel{
        return TTSSendModel(actorID: "", message: "")
    }
}

class NetworkModel : Codable {
    
    var result : String?
    var code : String?
    var message : String?
    var messageKey : String?
    var timestamp : String?
    var validationMessageDetail : [String]?
    private enum CodingKeys : String, CodingKey {
        case result
        case code
        case message
        case messageKey
        case timestamp
        case validationMessageDetail
    }

    required init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = (try? container.decode(String.self, forKey: .result)) ?? ""
        self.code = (try? container.decode(String.self, forKey: .code)) ?? ""
        self.message = (try? container.decode(String.self, forKey: .message)) ?? ""
        self.messageKey = (try? container.decode(String.self, forKey: .messageKey)) ?? ""
        self.timestamp = (try? container.decode(String.self, forKey: .timestamp)) ?? ""
        self.validationMessageDetail = (try? container.decode( [String].self, forKey: .validationMessageDetail)) ?? []
    }
    
    init() {
        
    }
}


class ClipTypeDataModel: Codable{
    var clipType: [ClipTypeData]
    
    enum CodingKeys: String, CodingKey {
        case clipType
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        clipType = try container.decode([ClipTypeData].self, forKey: .clipType)
    }
}

class ClipTypeData: Codable{
    var cd: String
    var cdNm: String
    var value: String
    var sortNo: Int
    var isUse: Int
    
    enum CodingKeys: String, CodingKey{
        case cd
        case cdNm
        case value
        case sortNo
        case isUse
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cd = try container.decode(String.self, forKey: .cd)
        cdNm = try container.decode(String.self, forKey: .cdNm)
        value = try container.decode(String.self, forKey: .value)
        sortNo = try container.decode(Int.self, forKey: .sortNo)
        isUse = try container.decode(Int.self, forKey: .isUse)
    }
}
