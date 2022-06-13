//
//  GiftItemViewModel.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/10.
//

import Foundation
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
}
