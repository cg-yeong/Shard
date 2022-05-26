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
    @IBOutlet weak var rotateBtn: UIButton!
    var rotateImages: [UIImage] = [UIImage(imageLiteralResourceName: "heart"), UIImage(imageLiteralResourceName: "like"), UIImage(imageLiteralResourceName: "star")]
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }

    
}

