//
//  ViewController.swift
//  Handmade_Animaiton
//
//  Created by root0 on 2022/05/26.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var plate: UIView!
    var rotateImages: [UIImage] = [UIImage(imageLiteralResourceName: "heart"), UIImage(imageLiteralResourceName: "like"), UIImage(imageLiteralResourceName: "star")]
    
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }
    
    
    @IBAction func play(_ sender: Any) {
//        plate.subviews.forEach { sub in
//            if ((sub as? CAView) != nil) {
//                sub.removeFromSuperview()
//            }
//        }
//        let view = CAView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        view.backgroundColor = .lightGray
//        self.plate.addSubview(view)
        
        let view = Bell_CA(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .lightGray
        view.center.x = self.plate.center.x
        self.plate.addSubview(view)
        
    }
    
    
}

