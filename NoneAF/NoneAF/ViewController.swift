//
//  ViewController.swift
//  NoneAF
//
//  Created by root0 on 2022/05/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        ServiceManager.shard.callService(urlString: "https://xivapi.com/character/26905756")
        
        ApiManager.shared.retreiveLodestone { (response: Lodestone_ID) in
            print(response.Character?.DC ?? "")
        } fail: {
            print("failed")
        }

    }


}

