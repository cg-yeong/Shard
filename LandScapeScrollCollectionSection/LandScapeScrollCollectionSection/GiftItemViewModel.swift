//
//  GiftItemViewModel.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/10.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine
import RxSwift
import RxCocoa

struct mockItemModelData: Codable {
    var type: String?
    var items: [mockItemModel]?
}

struct mockItemModel: Codable {
    var name: String
    var price: Int
}
class GiftItemViewModel {
    
    var mockitemCategory = [String]()
    var mockitems: [String : [mockItemModel]] = [:]
    var im: BehaviorSubject<ItemModelData> = BehaviorSubject<ItemModelData>(value: ItemModelData())
    
    var filtered: [ItemModel] = []
    var itemModel: ItemModelData?
    init() {
        setData()
        requestItemDalla()
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
        if let data = data, let gift = try? decoder.decode([mockItemModelData].self, from: data) {
            gift.forEach { _gift in
                mockitemCategory.append(_gift.type ?? "")
                mockitems[_gift.type ?? ""] = _gift.items ?? [mockItemModel(name: "empty", price: 999)]
            }
            
        }
    }
    
    func requestItemDalla() {
        
        let defaultHttpHeaders: HTTPHeaders = ["authToken" : authToken, "custom-header" : customHeaderStr]
        AF.request(URL(string: "") ?? "", method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: defaultHttpHeaders).responseData { [weak self] response in
            guard let self = self else { return }
            let decoder = JSONDecoder()
            do {
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let itemListModel = try decoder.decode(ItemListModel.self, from: data)
                    if itemListModel.result == "success", let itemListData = itemListModel.data {
                        self.itemModel = itemListData
                        self.im.onNext(itemListData)
                        
                        self.itemFiltering()
                    }
                case .failure(let err):
                    self.requestItemDalla()
                    print(err)
                }
            } catch {
                
            }
        }
    }
    
    
    func itemFiltering() {
        guard itemModel != nil, itemModel!.itemCategories != nil else { return }
        for index in 0 ..< itemModel!.itemCategories!.count {
            let filteredOfSection = itemModel!.items!
                .filter { (model) -> Bool in
                    return model.category == itemModel!.itemCategories?[index].code && model.visibility == true && model.type != "direct"
            }
            filtered.append(contentsOf: filteredOfSection)
        }
    }
}
