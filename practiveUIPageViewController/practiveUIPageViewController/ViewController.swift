//
//  ViewController.swift
//  practiveUIPageViewController
//
//  Created by root0 on 2023/04/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var openRelayConversation: UIButton = {
        let btn = UIButton()
        btn.setTitle("OPEN", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        return btn
    }()
    
    var mirrorbutton = MirrorButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(mirrorbutton)
        mirrorbutton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(250)
        }
        self.view.addSubview(openRelayConversation)
        openRelayConversation.addTarget(self, action: #selector(openConversaiton), for: .touchUpInside)
    }

    
    @objc func openConversaiton() {
        
//        let pageVC = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
//        pageVC.setViewControllers([], direction: <#T##UIPageViewController.NavigationDirection#>, animated: <#T##Bool#>)
//        self.navigationController?.pushViewController(pageVC, animated: true)
    }
    
}

