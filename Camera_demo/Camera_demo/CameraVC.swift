//
//  CameraVC.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/19.
//

import Foundation
import UIKit
import Combine

class CameraVC: UIViewController {
    
    lazy var cameraView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var topMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var bottomMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var galleryPreview: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var shutBtn: UIButton = {
        let btn = UIButton()
//        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(named: "circle"), for: .normal)
        btn.backgroundColor = .black
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }()
    
    lazy var swapCam: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
//        btn.setTitle("교체", for: .normal)
        btn.setImage(UIImage(named: "flip"), for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 9)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    var cBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Permission.sharedInstance.request(.Camera)
        // Do any additional setup after loading the view.
        addLazyView()
        
        observeTaps()
    }
    
    private func observeTaps() {
        swapCam
            .publisher(for: .touchUpInside)
            .sink { _ in
                print("Swap Camera Tapped")
            }
            .store(in: &cBag)
    }
    
    
}
