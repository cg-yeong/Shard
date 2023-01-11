//
//  ViewController.swift
//  HaveDisabledToastButton
//
//  Created by root0 on 2023/01/11.
//

import UIKit
import Toast

class ViewController: UIViewController {

    lazy var btn: HaveDisabledToastButton = {
        let btn = HaveDisabledToastButton()
        btn.disablePhrase = "Use isEnabledUI instead isEnabled"
        btn.backgroundColor = .blue
        btn.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        btn.addTarget(self, action: #selector(basicAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnEnableUI: UIButton = {
       let btn = UIButton()
        btn.frame = CGRect(x: 80, y: 80, width: 70, height: 70)
        btn.backgroundColor = .gray
        btn.setTitle("enable", for: .normal)
        btn.addTarget(self, action: #selector(setBtnEnableUI), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnDisableUI: UIButton = {
       let btn = UIButton()
        btn.frame = CGRect(x: 180, y: 80, width: 70, height: 70)
        btn.backgroundColor = .gray
        btn.setTitle("disable", for: .normal)
        btn.addTarget(self, action: #selector(setBtnDisableUI), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(btn)
        btn.center = self.view.center
        
        self.view.addSubview(btnEnableUI)
        self.view.addSubview(btnDisableUI)
    }

    @objc func basicAction() {
        btn.backgroundColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.btn.backgroundColor = .blue
        }
    }
    
    @objc func setBtnEnableUI() {
        btn.isEnabledUI = true
    }
    
    @objc func setBtnDisableUI() {
        btn.isEnabledUI = false
    }
    
    
}


extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

