//
//  ApiManager.swift
//  NoneAF
//
//  Created by root0 on 2022/05/18.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    func retreiveLodestone(success: @escaping ((Lodestone_ID) -> Void), fail: @escaping (() -> Void)) {
        ServiceManager.shard.callService(urlString: "https://xivapi.com/character/26905756") { (response: Lodestone_ID) in
            success(response)
        } fail: {
            fail()
        }
    }
    
}
