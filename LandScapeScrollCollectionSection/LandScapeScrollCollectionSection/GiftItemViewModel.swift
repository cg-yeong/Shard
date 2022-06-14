//
//  GiftItemViewModel.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/10.
//

import Foundation
import Alamofire
struct ItemModelData: Codable {
    var type: String?
    var items: [ItemModel]?
}

struct ItemModel: Codable {
    var name: String
    var price: Int
}
class GiftItemViewModel {
    
    var itemCategory = [String]()
    var items: [String : [ItemModel]] = [:]
    
    
    
    init() {
        setData()
    }
    
    func setData() {
        guard let path = Bundle.main.path(forResource: "mockItem", ofType: "json") else {
            return
        }
        guard let jsonString = try? String(contentsOfFile: path) else {
            return
        }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data, let gift = try? decoder.decode([ItemModelData].self, from: data) {
            gift.forEach { _gift in
                itemCategory.append(_gift.type ?? "")
                items[_gift.type ?? ""] = _gift.items ?? [ItemModel(name: "empty", price: 999)]
            }
            
        }
    }
    
    func requestItemDalla() {
        
        let defaultHttpHeaders: HTTPHeaders = ["authToken" : "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI0MTY0MjEyMzE4NzIyOUB0cnVlIiwiaWF0IjoxNjU1MTY3Mzc4LCJleHAiOjE2NTc3NTkzNzh9.aqScAIf9qwrGbBa1PQyekxczO0adQOusl3tSsSCceOk", "custom-header" : "%7B%0A%20%20%22appAdId%22%20:%20%2200000000-0000-0000-0000-000000000000%22,%0A%20%20%22deviceToken%22%20:%20%22celhgwFglkX-vmF_WI9THN:APA91bGf14LC5J9-liBtGZDDosmXikwD6xRfGCVnMzvhkVT-bFFrZY21trTzMLrvI2tp-wWwCX06W5VBF6XIRRsHof80FAYmov0DJjS1q96F4r_NhX1unU1aklReGQ6vZiXemovMHJi0%22,%0A%20%20%22deviceId%22%20:%20%2298D3C0E3-DFB7-4A7C-85FE-5B86559897E0%22,%0A%20%20%22locale%22%20:%20%22KR%22,%0A%20%20%22os%22%20:%20%222%22,%0A%20%20%22appVer%22%20:%20%22150%22,%0A%20%20%22deviceModel%22%20:%20%22iPhone%208%20Plus%22,%0A%20%20%22deviceSdkVersion%22%20:%20%2214.7.1%22,%0A%20%20%22language%22%20:%20%22ko%22,%0A%20%20%22isFirst%22%20:%20%22Y%22,%0A%20%20%22deviceManufacturer%22%20:%20%22APPLE%22,%0A%20%20%22appBuild%22%20:%20%220%22%0A%7D"]
        
        AF.request(URL(string: "https://devapi.dalbitlive.com/broad/profile") ?? "", method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: defaultHttpHeaders).responseJSON { (response) in
            print(response)
        }
    }
    
}
