//
//  ServiceManager.swift
//  NoneAF
//
//  Created by root0 on 2022/05/18.
//

import Foundation

class ServiceManager {
    
    static let shard = ServiceManager()
    
    func callService(urlString: String) {
        let url = URL(string: urlString)
        guard let urlObj = url else { return }
        let session = URLSession.shared
        var request = URLRequest(url: urlObj)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            
            guard error == nil, let data = data else { return }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
        }
        task.resume()
    }
    
    func callService<T: Decodable>(urlString: String, success: @escaping ((T) -> Void), fail: @escaping (() -> Void)) {
        guard let urlObj = URL(string: urlString) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: urlObj)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil, let data = data else { return }
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(T.self, from: data) {
                success(json)
            } else {
                fail()
            }
        }
        task.resume()
    }
}
